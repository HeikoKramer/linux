# SETTINGS
set -o vi #activates vim key-bindings 
export PATH=$HOME/repos/github/linux/scripts:$PATH
shopt -s globstar
set -o noclobber #prevents the > operator from overwriting existing files, this can still be done with >|
# ALIASES
## DIRECTORY SHORTCUTS
alias gil='cd ~/repos/gitlab.com' #enter gitlab directory
alias gih='cd ~/repos/github' #enter github directory
alias lin='cd ~/repos/github/linux' #enter linux repo
alias dot='cd ~/repos/github/linux/dotfiles' #jumps to dotfile directory
alias sf='cd ~/repos/github/sfdx' #enter sfdx repo
## FILE SHORTCUTS
alias notes='vim ~/repos/gitlab.com/heiko__b/dotfiles/notes.md' #opens my notes in VIM
alias linn='vim ~/repos/github/linux/linux_notes.md' #opens my notes on Linux
alias sfdxn='vim ~/repos/github/sfdx/sfdx_notes.md' #opens sfdx notes on sfdx
alias bashrc='vim ~/.bashrc' #opens my .bashrc in VIM
alias bashcr='vim ~/repos/github/linux/dotfiles/remote/.bash_aliases' #opens remote bashconfig in vim
alias bashc='vim ~/repos/github/linux/dotfiles/config.bash' #opens bashconfig in vim
alias vimrc='vim ~/repos/github/linux/dotfiles/vimrc' #opens vimrc in vim
alias sshc='vim ~/.ssh/config' #opens ssh config in vim
alias book='mupdf -I ~/Desktop/TLCL-19.01.pdf' #opens "The Linus Command Line" book in mupdf
## TERMINAL COMMAND SHORCUTS
alias h='history' #shows command history
alias l='exa -Fahl --color=always --group-directories-first' #colorised list
alias x='xclip' #copy output into xclip
alias xs='xclip -section clipboard -o' #shows xclip clipboards
alias off='shutdown -h now' #shuts down the system
## REMOTE ACCESS SHORTCUTS
alias pihole='ssh pihole' #connects to pihole raspi
alias apie='ssh ApplePie' #connects to Mac Mini gaming station
alias jitsi='ssh jitsi' #connect to digital ocean droplet

# PROMT
## All red
PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[00;30m\]\t\[\033[00m\]:\[\033[00;30m\]\u@\h\[\033[00m\]:\[\033[01;31m\]\w\[\033[00m\]\n$ "
## Mint promt
#PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
## Pi promt
#PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[00;31m\]\t\[\033[00m\]:\[\033[00;31m\]\u@\h\[\033[00m\]:\[\033[01;32m\]\w\[\033[00m\]\n$ "
## Ubuntu promt
#PS1="\[\e]0;\u@\h: \w\a\]${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\t\[\033[00m\]:\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[00;37m\]\w\[\033[00m\]\n$ "
export PS1


# FUNCTIONS

# refresh
# sources .bashrc while keeping you in the working directoty
function refresh {
        currentDirectory=$(pwd);
        cd; source .bashrc;
        cd $currentDirectory;
}

# allg = all Git 
# adds, commits and pushes everything in the working directory
# asks for a commit message
# toDo --> would actually be great to enter a commit message per changed item.
function allg {
	git add .;
	git status;
	read -p 'enter commit message: ' commitMessage;
	git commit -m "$commitMessage";
	git push -u origin main;
}

# newremote will copy remote editions of most relevant dot files to a remote system.
# newremote will then connect to the system, skipping authenticity question and perform updates.
# as last step newremote will log you into the remote maschine. 
function newremote {
	read -p 'enter user: ' user;
	read -p 'enter host: ' host;
	scp ~/repos/github/linux/dotfiles/remote/.vimrc $user@$host:;
	scp ~/repos/github/linux/dotfiles/remote/.bash_aliases $user@$host:;
  scp ~/repos/github/linux/dotfiles/remote/.bashrc $user@$host:;
  ssh -o "StrictHostKeyChecking=no" $user@$host "$(declare -f upgr);upgr";
  ssh $user@$host;
}

# upgr will update and upgrate your system
function upgr {
	sudo apt update -y;
	sudo apt upgrade -y;
}

# octal will show octal permission scheme for chmod command
function octal {
	echo "|0|---|";
	echo "|1|--x|";
	echo "|2|-w-|";
	echo "|3|-wx|";
	echo "|4|r--|";
	echo "|5|r-x|";
	echo "|6|rw-|";
	echo "|7|rwx|";
	echo 'Example: chmod 777 file = -rwxrwxrwx';
	echo 'Example: chmod 600 file = -rw-------';
}
export -f octal

# path will show all path elements seperated at ":"
function path {
  echo -e ${PATH//:/\\n};
}
export -f path
