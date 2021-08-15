# SETTINGS
set -o vi #activates vim key-bindings 
export PATH=$HOME/repos/github/linux/scripts:$PATH
shopt -s globstar
set -o noclobber #prevents the > operator from overwriting existing files, this can still be done with >|
# ALIASES
## COMMAND REPLACEMENTS
alias vim='nvim' #replace standard vim with neovim
alias mutt='neomutt' #launches neomutt instead of mutt
alias m='cmatrix -C magenta -s' #launches cmatrix in magenta and screensave mode
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
alias sfh='cd ~/repos/github/sfhcks; l' #enter and list Salesforce hacks repo 
alias isv='cd ~/repos/github/sfdx_projects/isv; l' #enter isv sfdx project
alias wd='cd ~/repos/github/webDev; l' #enter and list webDev repo
alias conf='cd ~/.config; l' #enter and list config files
alias vl='cd ~/repos/github/vlocity; l' #enter and list vlocity repo
## NOTES SHORTCUTS
alias notes='vim ~/repos/gitlab.com/heiko__b/dotfiles/notes.md' #opens my notes in VIM
alias linn='vim ~/repos/github/linux/linux_notes.md' #opens my notes on Linux
alias vimn='vim ~/repos/github/linux/vim_notes.md' #opens my notes on vim
alias tmuxn='vim ~/repos/github/linux/tmux_notes.md' #opens my notes on tmux
alias sfn='vim ~/repos/github/sfdx/sfdx_notes.md' #opens sfdx notes on sfdx
alias pin='vim ~/repos/github/linux/pi_notes.md' #opens my notes on Raspberry Pi related stuff
alias jsn='vim ~/repos/github/webDev/javascript_notes_2.md' #opens my notes on JS
alias htn='vim ~/repos/github/webDev/html_notes.md' #opens my notes on HTML
alias csn='vim ~/repos/github/webDev/css_notes.md' #opens my notes on CSS
alias dom='vim ~/repos/github/webDev/dom_notes.md' #opens my notes on the JS DOM
alias vsn='vim ~/repos/github/webDev/VS-Code_notes.md' #opens my notes on Visual Studio Code
alias vln='vim ~/repos/github/vlocity/vlocity_notes.md' #opens my notes on vlocity
alias don='vim ~/repos/github/linux/docker_notes.md' #opens my notes on Docker
## CONFIG SHORTCUTS
alias bashrc='vim ~/.bashrc' #opens my .bashrc in VIM
alias bashcr='vim ~/repos/github/linux/dotfiles/remote/.bash_aliases' #opens remote bashconfig in vim
alias bashc='vim ~/repos/github/linux/dotfiles/config.bash' #opens bashconfig in vim
alias tmuxc='vim ~/repos/github/linux/dotfiles/tmux.conf' #opens tmux config in vim
alias vimc='vim ~/repos/github/linux/dotfiles/vimrc' #opens vimrc in vim
alias conkyc='vim ~/repos/github/linux/dotfiles/conky.conf' #opens conky.conf
alias sfc='vim -c "set filetype=sh" ~/repos/github/sfdx/sfdx.conf' #opens sfdx config in vim
alias sshc='vim ~/.ssh/config' #opens ssh config in vim
alias muttc='vim ~/.config/mutt/muttrc' #opens (neo)mutt config file in vim
## BOOK SHORTCUTS
### Vim books
alias vimb='mupdf -I ~/books/Vim/Mastering_Vim_Quickly_v1.1.pdf' #opens vim book in mupdf
alias ovimb='mupdf -I ~/books/Vim/viandvimeditorspocketreference2e.pdf' #opens O'Reilly vim book in mupdf
alias pvimb='mupdf -I ~/books/Vim/781789341096-MASTERING_VIM.pdf' #opens Packt vim book in mupdf
### Linux / Unix command line books
alias book='mupdf -I ~/books/Linux_CL/TLCL-19.01.pdf' #opens "The Linus Command Line" book in mupdf
alias ubook='mupdf -I ~/books/Linux_CL/9781800564640-MASTERING_UBUNTU_SERVER_THIRD_EDITION.pdf' #opens Jay's ubuntu server book in mupdf
alias obash='mupdf -I ~/books/Linux_CL/bashpocketreference2e.pdf' #opens O'Reilly  bash book in mupdf
alias ogit='mupdf -I ~/books/Linux_CL/gitpocketguide1e.pdf' #opens O'Reilly git book in mupdf
alias ogrep='mupdf -I ~/books/Linux_CL/greppocketref.pdf' #opens O'Reilly grep book in mupdf
alias olinux='mupdf -I ~/books/Linux_CL/linuxpocketguide3e.pdf' #opens O'Reilly linux book in mupdf
alias oregex='mupdf -I ~/books/Linux_CL/regularexpressionspocketreference.pdf' #opens O'Reilly regex book in mupdf
alias oawk='mupdf -I ~/books/Linux_CL/sedandawkpocketreference2e.pdf' #opens O'Reilly sed & awk book in mupdf
## JavaScript books
alias jsb='mupdf -I ~/books/JS/Eloquent_JavaScript.pdf' #opens "Eloquent JS" book in mupdf
alias nodeb='mupdf -I ~/books/JS/9781838987572-NODEJS_WEB_DEVELOPMENT_FIFTH_EDITION.pdf' #opens Packt NodeJS book in mupdf
alias reactb='mupdf -I ~/books/JS/9781839219931-FULLSTACK_REACT_TYPESCRIPT_AND_NODE.pdf' #opens Packt React book in mupdf
## Salesforce book
alias lightb='mupdf -I ~/books/Salesforce/9781789956719-SALESFORCE_LIGHTNING_PLATFORM_ENTERPRISE_ARCHITECTURE_THIRD_EDITION.pdf' #opens Packt Lightning book in mupdf
alias apexp='mupdf -I ~/books/Salesforce/9781800200920-MASTERING_APEX_PROGRAMMING.pdf' #opens Packt Apex book in mupdf
alias archb='mupdf -I ~/books/Salesforce/9781800568754-BECOMING_A_SALESFORCE_CERTIFIED_TECHNICAL_ARCHITECT.pdf' #opens Packt SF Architect book in mupdf
## VIRTUALIZATION SHORTCUTS
alias vmac='VBoxManage startvm "VMac"' #starts my virtual mac
## TERMINAL COMMAND SHORCUTS
alias h='history' #shows command history
alias l='ls -alh --color=always --group-directories-first' #colorised list
alias x='xclip' #copy output into xclip
alias xs='xclip -section clipboard -o' #shows xclip clipboards
alias off='poweroff' #shuts down the system
alias offr='sudo poweroff' #shuts down a remote system
alias gs='git status' #shows git status is directory is a repo
alias ?='duck' #calls duck function (duckduckgo search in lynx)
alias ??='google' #calls google function (google search in lynx)
## REMOTE ACCESS SHORTCUTS
alias piho='clear; ssh pihole' #connects to pihole raspi
alias dopi='clear; ssh DockerPi' #connects to docker raspi
alias apie='clear; ssh ApplePie' #connects to Mac Mini gaming station
alias one='clear; ssh one' #connect to one server
## MISC
alias babo='vim ~/test/babofile' #opens vim training file
alias nur='vim ~/repos/github/linux/scripts/nuremo' #opens new remote script in vim 

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
        clear;
        cd; source .bashrc;
        cd $currentDirectory;
}
export -f refresh

# size
# get size of working directory
function size {
        currentDirectory=$(pwd);
        du -h $currentDirectory --max-depth=0;
}
export -f size

# allg = all Git 
# adds, commits and pushes everything in the working directory
# asks for a commit message
function allg {
	git add .;
	git status;
	read -p 'enter commit message: ' commitMessage;
	git commit -m "$commitMessage";
	git push -u origin main;
}

# gamp [file to add] = git add + commit + push
# adds and commits the file given as function option
# asks for a commit message
function gamp {
	read -p 'Please enter a commit message: ' commitMessage;
	git add $1;
	git commit -m "$commitMessage";
	git push -u origin main;
}
export -f gamp

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

# md [directory name] – alias function for mkdir
# creates directory with entered name and changes (cd) into the new directory
function md {
  mkdir $1;
  cd $1;
}
export -f md

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
