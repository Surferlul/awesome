#!/bin/sh
xinput --set-prop "SYNA7DB5:01 06CB:CD41 Touchpad" $(xinput list-props $(xinput list | grep 'Touchpad' | cut -f 2 | cut -d'=' -f 2) | grep "Disable While Typing Enabled (" | cut -d'(' -f 2 | cut -d')' -f 1) 0
xinput --set-prop "SYNA7DB5:01 06CB:CD41 Touchpad" $(xinput list-props $(xinput list | grep 'Touchpad' | cut -f 2 | cut -d'=' -f 2) | grep "Tapping Enabled (" | cut -d'(' -f 2 | cut -d')' -f 1) 1
xinput --set-prop "SYNA7DB5:01 06CB:CD41 Touchpad" $(xinput list-props $(xinput list | grep 'Touchpad' | cut -f 2 | cut -d'=' -f 2) | grep "Natural Scrolling Enabled (" | cut -d'(' -f 2 | cut -d')' -f 1) 1
xinput --set-prop "SYNA7DB5:01 06CB:CD41 Touchpad" $(xinput list-props $(xinput list | grep 'Touchpad' | cut -f 2 | cut -d'=' -f 2) | grep "Middle Emulation Enabled (" | cut -d'(' -f 2 | cut -d')' -f 1) 1
#python ~/user/projects/startup/presence.py &
picom --experimental-backends --backend glx &
cp ~/.gtkrc-2.0_default ~/.gtkrc-2.0
