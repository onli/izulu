# izulu
Weather aware desktop background images

![izulu example](https://lh5.googleusercontent.com/-E2Idz1l1NV0/U0rCEzev83I/AAAAAAAAC60/rK9ELFUp7Pg/s800/izulu.jpg)

Izulu is a script that fetches the current weather from Yahoo and changes the desktop background accordingly.

It can also show the weather forecast and the current temperature. As much as possible is detected automatically, like the command to change the background or the current position.

## Install

### PPA

On launchpad, there is a [PPA with daily builds](https://launchpad.net/~onli/+archive/izulu). Add it with
    
    sudo add-apt-repository ppa:onli/izulu
    
and install **izulu**
    
    sudo apt-get update
    sudo apt-get install izulu
    
### Arch Linux

Install izulu-git from [the AUR](https://aur.archlinux.org/packages/izulu-git/)

    yaourt -S izulu-git

### Gentoo/Funtoo

Use the [overlay](https://github.com/onli/overlay ) with layman

    layman -o https://raw.github.com/onli/overlay/master/repositories.xml -f -a onli
    
and install with emerge

    emerge izulu


### Manual

Download this repository and install with:

    make
    sudo make install # (or use checkinstall)

Install the dependencies (on Ubuntu):

    sudo apt-get install imagemagick xmlstarlet jq bc xml-twig-tools gettext

On older Ubuntu systems, install also `notify-send`. It is not strictly necessary, only if `--osd` is specified to show notifications on weather change.

## Start

To use all common features, start izulu like this:

    izulu --daemon --night --preview --temperature --osd &

Optionally, use `-c city` or `-l LAT:LON` to set your current location manually. 
    
## Configuration

For a list of all parameters see the manpage.

### Location

izulu can configured partly in **~/.izulu/config**, especially the `CITY` or `LATITUDE` and `LONGITUDE` parameter are important if the automatic location detection fails.
First, try to set `CITY` to the current location. If that fails, set `LATITUDE` and `LONGITUDE`.

### Custom images

To set custom images, check their name in **/usr/share/izulu** and add a image with the same name to **~/.izulu/**. The categories are *sun*, *cloud*, *rain*, *snow* , *wind* and *misc* (=fog), and there is a *thunder* category (according to its documentation not yet supported by the weather api, but planned). The image files are called *gen_CATEGORY*, for example *gen_sun*. Substates are *partly_cloudy* and *cloudy* for *gen_cloud*, *rain* and *hail* for *gen_rain*, *sleet* and *snow* for *gen_snow*. The category *gen_wind* also knows the substates *windy* and *tornado*, I hope you never see the latter. You can set custom images for the substates by saving an image with its name in **~/.izulu/**.

### Random images

With `-r|--random` izulu picks a random image from the corresponding directory set in **~/.izulu/config**. If no directory is set, izulu will try to get a random image from a fitting flickr group. This is currently a bit flaky, but izulu tries to fall back to its provided images if the flickr way fails.
