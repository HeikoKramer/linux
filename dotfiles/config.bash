# SETTINGS
set -o vi #activates vim key-bindings 
export PATH=$HOME/repos/github/linux/scripts:$PATH
shopt -s globstar
set -o noclobber #prevents the > operator from overwriting existing files, this can still be done with >|
# ALIASES
## DIRECTORY SHORTCUTS
alias gil='cd ~/repos/gitlab.com; l' #enter and list gitlab directory
alias gih='cd ~/repos/github; l' #enter and list github directory
alias lin='cd ~/repos/github/linux; l' #enter and list linux repo
alias lins='cd ~/repos/github/linux/scripts; l' #enter and list linux scripts
alias dot='cd ~/repos/github/linux/dotfiles; l' #enter and list dotfiles directory
alias dotr='cd ~/repos/github/linux/dotfiles/remote; l' #enter and list remote dotfiles directory
alias sf='cd ~/repos/github/sfdx; l' #enter and list sfdx repo
alias sfp='cd ~/repos/github/sfdx_projects; l' #enter and list sfdx_projects private repo
alias sfs='cd ~/repos/github/sfdx/sfdx_scripts; l' #enter and list sfdx scripts
alias isv='cd ~/repos/github/sfdx_projects/isv; l' #enter isv sfdx project
alias conf='cd ~/.config; l' #enter and list config files
## FILE SHORTCUTS
alias notes='vim ~/repos/gitlab.com/heiko__b/dotfiles/notes.md' #opens my notes in VIM
alias linn='vim ~/repos/github/linux/linux_notes.md' #opens my notes on Linux
alias vimn='vim ~/repos/github/linux/vim_notes.md' #opens my notes on vim
alias tmuxn='vim ~/repos/github/linux/tmux_notes.md' #opens my notes on tmux
alias sfn='vim ~/repos/github/sfdx/sfdx_notes.md' #opens sfdx notes on sfdx
alias bashrc='vim ~/.bashrc' #opens my .bashrc in VIM
alias bashcr='vim ~/repos/github/linux/dotfiles/remote/.bash_aliases' #opens remote bashconfig in vim
alias bashc='vim ~/repos/github/linux/dotfiles/config.bash' #opens bashconfig in vim
alias tmuxc='vim ~/repos/github/linux/dotfiles/tmux.conf' #opens bashconfig in vim
alias vimrc='vim ~/repos/github/linux/dotfiles/vimrc' #opens vimrc in vim
alias sfc='vim ~/repos/github/linux/dotfiles/sfdx.conf' #opens sfdx.conf in vim
alias sshc='vim ~/.ssh/config' #opens ssh config in vim
alias book='mupdf -I ~/books/TLCL-19.01.pdf' #opens "The Linus Command Line" book in mupdf
alias vimb='mupdf -I ~/books/mastering_vim/book/Mastering_Vim_Quickly_v1.1.pdf' #opens vim book in mupdf
alias muttc='vim ~/.config/mutt/muttrc' #opens (neo)mutt config file in vim
alias vmac='VBoxManage startvm "VMac"' #starts my virtual mac
## TERMINAL COMMAND SHORCUTS
alias h='history' #shows command history
alias l='ls -alh --color=always --group-directories-first' #colorised list
alias x='xclip' #copy output into xclip
alias xs='xclip -section clipboard -o' #shows xclip clipboards
alias off='shutdown -h now' #shuts down the system
alias offr='sudo shutdown -h now' #shuts down a remote system
alias gs='git status' #shows git status is directory is a repo
alias mutt='neomutt' #launches neomutt instead of mutt
alias ?='duck' #calls duck function (duckduckgo search in lynx)
alias ??='google' #calls google function (google search in lynx)
## REMOTE ACCESS SHORTCUTS
alias pihole='ssh pihole' #connects to pihole raspi
alias apie='ssh ApplePie' #connects to Mac Mini gaming station
alias jitsi='ssh jitsi' #connect to digital ocean droplet
alias one='ssh one' #connect to one server

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
  refresh;
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

# vpnc – vpn connect – will establish a connection to my surfshark-vpn service
function vpnc {
  myip; #calls myip script to display current public ip
  printf "––– old-ip –––\n" | lolcat;
  sleep 0.25;
  sudo surfshark-vpn attack;
  sleep 0.25;
  printf "––– new-ip –––\n" | lolcat;
  myip;
}

# vpnd – vpn disconnect – will disconnect the connection to my surfshark-vpn service
function vpnd {
  myip; #calls myip script to display current public ip
  printf "––– old-ip –––\n" | lolcat;
  sleep 0.25;
  sudo surfshark-vpn down;
  sleep 0.25;
  printf "––– new-ip –––\n" | lolcat;
  myip;
}

# duck – takes user input and performs a duckduckgo search with it in the lynx browser
function duck {
  lynx "duckduckgo.com/lite?kd=-1&kp=-1&q=$*";
}
export -f duck

# google – takes user input and performs a google search with it in the lynx browser
function google {
  lynx "google.com/search?q=$*";
}
export -f google

# wikie – takes user input and performs a search within the english wikipedia via lynx
function wikie {
  lynx "en.wikipedia.org/wiki/$*";
}
export -f wikie

# wikid – takes user input and performs a search within the german wikipedia via lynx
function wikid {
  lynx "de.wikipedia.org/wiki/$*";
}
export -f wikid

## autostart apps
neofetch

# source sfdx configuration file
# check out sfdx.conf so see all sfdx related aliases and functions
if [ -f ~/.sfdx.conf ]; then
    . ~/.sfdx.conf
    echo "sourced >> .sfdx.conf"
fi

### "vim" as manpager
export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
