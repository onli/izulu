izulu
=====

weather-aware desktop background images

izulu is a Bash-script that fetches the current weather from Yahoo and changes the desktop background accordingly.

It can also show the weather forecast and the current temperature. As much as possible is detected automatically,
like the command to change the background or the current position.

Install
=====

Either install the provided .deb, or install with:

    make
    sudo make install # (or use checkinstall)

Install the dependencies (on Ubuntu):

    sudo apt-get install imagemagick xmlstarlet xml-twig-tools notify-send

notify-send is not strictly necessary, only if `--osd` is specified to show notifications on weather change.

Configuration and Start
=====

izulu can configured partly in **~/.izulu/config**, especially the `CITY` and `WOEID`-Parameter, if the automatic location detection fails.
First, try to set `CITY` to the current location. If that fails, get the `WOEID` from http://woeid.rosselliot.co.nz/ and set it in the config.

Then, start izulu:

    izulu --daemon --night --preview --temperature --osd &

For a list of all parameters see the manpage.

To overwrite images locally, check their name in **/usr/share/izulu** and add a image with the same name to **~/.izulu/**. It is also possible ot further distinct between weather states
(like rain/light_rain) instead of using the general category image by placing the more specific image into **~/.izulu/** as well. It should be best to directly look into the script (in `chooseWallpaper()`) to see the available categories.

