#!/usr/bin/fish
#~/.config/fish/functions/chitubox.fish 
# purpose: alleviate LD_LIBRARY_PATH conflict with other programs

function chitubox
    set -lx LD_LIBRARY_PATH /usr/local/share/lib; # note that this is a local env!
    /usr/local/share/CHITUBOX &;disown; # start chitubox 
end 