### SETTINGS

set -x PATH /opt/nvim-linux-x86_64/bin $HOME/code/tools $HOME/.local/bin $PATH

alias settings-power-switch='sudo vim /etc/systemd/logind.conf'
alias settings-sources='sudo vim /etc/apt/sources.list'

function settings-touchpad
    set file /etc/X11/xorg.conf.d/40-libinput.conf

    if test -f $file
        sudo vim $file
    else
        sudo mkdir -p (dirname $file)
        begin
            echo 'Section "InputClass"'
            echo '    Identifier "touchpad"'
            echo '    Driver "libinput"'
            echo '    MatchIsTouchpad "on"'
            echo '    Option "Tapping" "on"'
            echo '    Option "NaturalScrolling" "on"'
            echo 'EndSection'
        end | sudo tee $file > /dev/null
    end
end

