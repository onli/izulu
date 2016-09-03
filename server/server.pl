use Frinfon;
use LWP::Simple;
use JSON::Fast;
use Cache::LRU;
use Config::INI;

# TODO:
# * limit api calls 

my %config = Config::INI::parse_file('keys.ini');

my $try = 0;
my $cache = Cache::LRU.new(size => 1024);

get '/forecast/:place' => sub ($c) {
    my $city = $c.captured<place>;
    my ($latitude, $longitude) = getCoordinates($city);
    $c.render-text(getForecast($latitude, $longitude));
};

get '/forecast/:latitude/:longitude' => sub ($c) {
    $c.render-text(getForecast($c.captured<latitude>, $c.captured<longitude>));
};

sub getForecast($latitude, $longitude) {
    my $key = $latitude + ' ' + $longitude;
    my $cached_page = $cache.get($key);
    if ($cached_page && ($cached_page[0] > (DateTime.now().posix()))) {
        return $cached_page[1];
    }
    my $forecastURL = "https://api.forecast.io/forecast/%config<_><forecast>/$latitude,$longitude?units=si&exclude=minutely,hourly,alerts,flags";
    my $data = LWP::Simple.get($forecastURL);
    $cache.set($key, [DateTime.now().posix() + 1790, $data]);
    return $data
}

sub getCoordinates($city) {
    try {
        my $where = from-json(LWP::Simple.get("https://maps.googleapis.com/maps/api/geocode/json?address=$city&key=%config<_><google>"));
        return ($where{'results'}[0]{'geometry'}{'location'}{'lat'}, $where{'results'}[0]{'geometry'}{'location'}{'lng'});
        
        CATCH {
            default {
                $try++;
                sleep 3;
                if ($try < 3) {
                    getCoordinates($city)
                }
            }
        }
    }
    print "error getting coordinates";
}

app;