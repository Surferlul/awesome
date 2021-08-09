#!/usr/bin/env bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
[ -d "$HOME/.config/awesome" ] && tar cf $SCRIPT_DIR/previous.tar $HOME/.config/awesome/ && rm $HOME/.config/awesome/
cp -r $SCRIPT_DIR $HOME/.config/
