# Commands to run in interactive sessions can go here
if status is-interactive

    # ------ abbreviations--------- 
    abbr -a -- pi 'sudo pacman -S'
    abbr -a -- pu 'sudo pacman -Syu'
    abbr -a -- pr 'sudo pacman -R'
    abbr -a -- cl 'clear'
    abbr -a -- sl 'systemctl suspend2'

    

    #-------- bindings------------
    bind \cH backward-kill-word #ctrl-backspace to delete an entire word

    # add a desktop image at startup
    ~/.fehbg &
end
