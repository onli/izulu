use Frinfon;
use HTTP::UserAgent;
use JSON::Fast;
use Cache::LRU;
use Config::INI;

# TODO:
# * limit api calls 

my %config = Config::INI::parse_file('keys.ini');

my $try = 0;
my $cache = Cache::LRU.new(size => 1024);
my $coordcache = Cache::LRU.new(size => 1024);
my $ua = HTTP::UserAgent.new;
$ua.timeout = 10;

get '/forecast/:place' => sub ($c) {
    my $city = $c.captured<place>;
    my ($latitude, $longitude) = getCoordinates($city);
    $c.render-text(getForecast($latitude, $longitude));
};

get '/forecast/:latitude/:longitude' => sub ($c) {
    $c.render-text(getForecast($c.captured<latitude>, $c.captured<longitude>));
};

sub getForecast($latitude, $longitude) {
    my $key = "$latitude $longitude";
    my $cached_page = $cache.get($key);
    if ($cached_page && ($cached_page[0] > (DateTime.now().posix()))) {
        return $cached_page[1];
    }
    my $response = $ua.get("https://api.darksky.net/forecast/%config<_><forecast>/$latitude,$longitude?units=si&exclude=minutely,hourly,alerts,flags");
    if $response.is-success {
        my $data = $response.content;
        my $cachetime = $response.header.field('Cache-Control').Str.subst('max-age=', '');  # currently always 3600, but maybe some day they will implement more accurate caching
        $cache.set($key, [DateTime.now().posix() + $cachetime, $data]);
        return $data;
    }
}

sub getCoordinates($city) {
    try {
        my $location = $coordcache.get($city);
        if ($location) {
            return $location[0], $location[1];
        }
        my $response = $ua.get("https://api.mapbox.com/geocoding/v5/mapbox.places/$city.json?access_token=%config<_><mapbox>&autocomplete=true");
        if $response.is-success {
            my $where = from-json($response.content);
            $coordcache.set($city, $where{'features'}[0]{'center'});
            return ($where{'features'}[0]{'center'}[0], $where{'features'}[0]{'center'}[1]);
        } else {
            die $response.status-line;
        }
        
        CATCH {
            default {
                $try++;
                sleep 3;
                if ($try < 3) {
                    getCoordinates($city);
                }
            }
        }
    }
    print "error getting coordinates";
}

app;