# Replaces standard fish startup with function defined below
if status is-interactive
	set -U fish_greeting
end

# This function executes code upon fish startup
function fish_greeting
	# Add any greeting stuff here
end


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
alias files="nautilus"

alias slack="com.slack.Slack"
alias brave="com.brave.Browser"
alias discord="com.discordapp.Discord"

alias gitconfig="/usr/bin/git --git-dir=$HOME/.Dotfiles --work-tree=$HOME"

# Useful functions
function mousespeed
	xinput set-prop 11 180 $argv 0 0 0 $argv 0 0 0 1
end

fish_vi_key_bindings
