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

Use pacman and the provided PKGBUILD to install:

    wget https://raw.githubusercontent.com/onli/izulu/master/PKGBUILD #download "PKGBUILD" file
    makepkg
    sudo pacman -U izulu-git-*.pkg.tar.xz

### Manual

Download this repository and install with:

    make
    sudo make install # (or use checkinstall)

Install the dependencies (on Ubuntu):

    sudo apt-get install imagemagick xmlstarlet xml-twig-tools 

On older Ubuntu systems, install also `notify-send`. It is not strictly necessary, only if `--osd` is specified to show notifications on weather change.

## Start

To use all common features, start izulu like this:

    izulu --daemon --night --preview --temperature --osd &
    
## Configuration

izulu can configured partly in **~/.izulu/config**, especially the `CITY` and `WOEID` parameter are important if the automatic location detection fails.
First, try to set `CITY` to the current location. If that fails, get the `WOEID` from http://woeid.rosselliot.co.nz/ and set it in the config.

For a list of all parameters see the manpage.

To overwrite images locally, check their name in **/usr/share/izulu** and add a image with the same name to **~/.izulu/**. It is also possible to further distinct between weather states
(like rain/light_rain) instead of using the general category image by placing the more specific image into **~/.izulu/** as well. It should be best to directly look into the script (in `chooseWallpaper()`) to see the available categories.

