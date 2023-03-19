# .bash_profile

export NVM_DIR="$HOME/.nvm"

# Get the aliases and functions
if [ -f ~/.bashrc ]; then 
	. ~/.bashrc
fi

export PATH="$PATH:/opt/flutter/bin"
. "$HOME/.cargo/env"

# Enable touch
xinput set-prop 'SYNA7DB5:01 06CB:CD41 Touchpad' 'libinput Tapping Enabled' 1
# Swap caps and escape
setxkbmap -option caps:swapescape

# increase history size to 1000 lines
export HISTCONTROL=ignoredups
export HISTSIZE=1000
export HISTFILESIZE=1000


# copyq
copyq&
