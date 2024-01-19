# Commands to run in interactive sessions can go here
if status is-interactive

    # ------ abbreviations--------- 
    abbr -a -- ps 'sudo pacman -S'
    abbr -a -- pu 'sudo pacman -Syu'
    abbr -a -- pr 'sudo pacman -R'
    abbr -a -- cl 'clear'
    abbr -a -- sl 'systemctl suspend'

    #-------- bindings------------
    bind \cH backward-kill-word #ctrl-backspace to delete an entire word

    #--------   envs  ------------#
    set -gx PICO_SDK_PATH /opt/pico-sdk
    set -gx FREERTOS_KERNEL_PATH /opt/FreeRTOS-Kernel

    # SSH shite
    eval $(keychain --eval --quiet --ignore-missing id_ed25519 id_rsa)
end
