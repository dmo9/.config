# !/usr/bin/fish
# file: ~/.config/fish/functions/polybar.fish
# purpose: have polybar launch on startup through i3

function polybar_launch

    # launch firefox browser w/o tabs or search bar
    killall -q polybar;
    polybar &;
    disown;
end