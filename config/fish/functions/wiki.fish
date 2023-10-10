# !/usr/bin/fish
# file: ~/.config/fish/functions/wikijs.fish
# purpose: launch wikijs in an app-like firefox window

function wiki

    # launch firefox browser w/o tabs or search bar
    firefox localhost:3000 -P "no-tabs-or-search-bar" &;
    disown;
end