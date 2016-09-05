weather server for izulu, providing access to forecast.io

## Requirements

perl6 and its modules:

   panda install Frinfon HTTP::UserAgent IO::Socket::SSL Cache::LRU Config::INI

## Start

Create the config file **server/keys.ini** and add the dark sky forecast and the google api key

    forecast=…
    google=…

Then start the server:

    crustup server.pl
