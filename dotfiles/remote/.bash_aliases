# REDUCED BASH CONFIG FOR REMOTE SYSTEMS
set -o vi #activates vim key-bindings

# ALIASES
## CONFIG SHORTCUTS
alias bashrc='vim ~/.bashrc' #opens my .bashrc in VIM
alias bashc='vim ~/.bash_remote' #opens bashconfig in vim
alias vimrc='vim ~/.vimrc' #opens vimrc in vim
alias tmuxc='vim ~/.tmux.conf' #opens .tmux.conf in vim
alias conf='cd ~/.config; l' #enter and list config files
## TERMINAL COMMAND SHORCUTS
alias h='history' #shows command history
alias l='ls -Flah' #my prefered list options

# PROMT
## All red
#PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[00;30m\]\t\[\033[00m\]:\[\033[00;30m\]\u@\h\[\033[00m\]:\[\033[01;31m\]\w\[\033[00m\]\n$ "
## Mint promt
#PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
## Pi promt
PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[00;31m\]\t\[\033[00m\]:\[\033[00;31m\]\u@\h\[\033[00m\]:\[\033[01;32m\]\w\[\033[00m\]\n$ "
## Ubuntu promt
#PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\t\[\033[00m\]:\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[00;37m\]\w\[\033[00m\]\n$ "
export PS1

# FUNCTIONS
## refresh
## sources .bashrc while keeping you in the working directoty
function refresh {
        currentDirectory=$(pwd);
        clear;
        cd; source .bashrc;
        cd $currentDirectory;
}
export -f refresh

## upgr will update and upgrate your system
function upgr {
        sudo apt update -y;
        sudo apt upgrade -y;
}

# syncdot – function to curl the current version of my dotfiles    
function syncdot {    
  curl https://raw.githubusercontent.com/HeikoKramer/linux/main/dotfiles/remote/.vimrc > .vimrc;    
  curl https://raw.githubusercontent.com/HeikoKramer/linux/main/dotfiles/remote/.bashrc > .bashrc;    
  curl https://raw.githubusercontent.com/HeikoKramer/linux/main/dotfiles/remote/.bash_aliases > .bash_aliases;
  curl https://raw.githubusercontent.com/HeikoKramer/linux/main/dotfiles/tmux.conf > .tmux.conf;    
  refresh;
}
