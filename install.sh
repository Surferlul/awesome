#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
CACHE_DIR="/tmp/surferlul_awesome"
[ -d "$CACHE_DIR" ] && rm -rf /tmp/surferlul_awesome
mkdir $CACHE_DIR
git clone https://github.com/Surferlul/awesome.git $CACHE_DIR
[ -d "$HOME/.config/awesome" ] && tar cf $CACHE_DIR/previous.tar $HOME/.config/awesome/ && rm -rf $HOME/.config/awesome/
git clone https://github.com/vicious-widgets/vicious.git $CACHE_DIR/vicious
mv $CACHE_DIR $HOME/.config/awesome
[ "$1" != "--preserve-git" ] && rm -rf $HOME/.config/awesome/.git
