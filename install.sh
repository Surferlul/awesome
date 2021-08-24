#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CACHE_DIR="/tmp/surferlul_awesome"
[ -d "$CACHE_DIR" ] && echo "Removing previous cache" && rm -rf /tmp/surferlul_awesome
mkdir $CACHE_DIR
echo "Downloading AwesomeWM Configs"
git clone https://github.com/Surferlul/awesome.git $CACHE_DIR
[ -d "$HOME/.config/awesome" ] && echo "Backing up previous configs" && tar cf $CACHE_DIR/previous.tar $HOME/.config/awesome/ && echo "Removing previous configs" && rm -rf $HOME/.config/awesome/
echo "Downloading Vicious widgets for AwesomeWM"
git clone https://github.com/vicious-widgets/vicious.git $CACHE_DIR/vicious
echo "Moving configs to install location"
mv $CACHE_DIR $HOME/.config/awesome
[ "$1" != "--preserve-git" ] && rm -rf $HOME/.config/awesome/.git
[ ! -d "$HOME/.fonts" ] && echo "Creating ~/.fonts directory" && mkdir $HOME/.fonts
[ -z '$(ls $HOME/.fonts | grep "[Ii]ndie *[Ff]lower")' ] && echo "Indie Flower doesn't exist, installing" && mkdir $CACHE_DIR && curl 'https://google-webfonts-helper.herokuapp.com/api/fonts/indie-flower?download=zip&subsets=latin&variants=regular' > $CACHE_DIR/IndieFlower.zip && 7z e -y $CACHE_DIR/IndieFlower.zip -o$CACHE_DIR/ && cp $CACHE_DIR/*.ttf $HOME/.fonts && rm -rf $CACHE_DIR
