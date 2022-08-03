# ---------------------------------------
# Fish Startup
# ---------------------------------------

# Replaces standard fish startup with function defined below
if status is-interactive
	set -U fish_greeting
end

# This function executes code upon fish startup
function fish_greeting
	# Add any greeting stuff here
end


# ---------------------------------------
# Aliases
# ---------------------------------------

# This section contains alias commands for quicker access
alias fishrc="nvim ~/.config/fish/config.fish"
alias bashrc="nvim ~/.bashrc"
alias qtilerc="nvim ~/.config/qtile/config.py"
alias vimrc="nvim ~/.vimrc"
alias nvimrc="nvim ~/.config/nvim/init.vim"
alias mouserc="nvim /etc/X11/xorg.conf.d/50-mouse.conf"
alias monitorrc="nvim /etc/X11/xorg.conf.d/10-monitor.conf"
alias xresrc="nvim ~/.Xresources"
alias alrc="nvim ~/.config/alacritty/alacritty.yml"
alias kittyrc="nvim ~/.config/kitty/kitty.conf"
alias sshdrc="sudo nvim /etc/ssh/sshd_config"

alias gitconfig="/usr/bin/git --git-dir=$HOME/.Dotfiles --work-tree=$HOME"

# File Navigation
alias ..='cd ..'
alias .2='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# ---------------------------------------
# Brings back Bash !! and !$
# ---------------------------------------

function bind_bang
    switch (commandline -t)[-1]
        case "!"
            commandline -t $history[1]; commandline -f repaint
        case "*"
            commandline -i !
    end
end

function bind_dollar
    switch (commandline -t)[-1]
        case "!"
            commandline -t ""
            commandline -f history-token-search-backward
        case "*"
            commandline -i '$'
    end
end

function fish_user_key_bindings
    bind -M insert ! bind_bang
    bind -M insert '$' bind_dollar
end


# ---------------------------------------
# Other
# ---------------------------------------

# Quick binding for setting mouse speed
function mousespeed
	xinput set-prop 11 180 $argv 0 0 0 $argv 0 0 0 1
end

# This totally doesn't do anything trolly ;)
alias rickroll='curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash'

# Enables Vim Mode
fish_vi_key_bindings
