# LINUX 
## info
Public repo to backup my Linux configs and to keep track of my learning progress. <br>
**linux_notes.md** holds currently my combined notes on **vim**, **bash** and **Linux** in general. I'm planning a cleanup there and maybe a splitt into separate files. <br>
<br>
## scripts
**scripts/** holds interesting scripts I've copied or written. The directory is exported to my path to make them executable from my shell. <br>
## dotfiles
**dotfiles/** stores my most relevant config files and a *setup* script which links those files to my home directory. <br>
### dotfiles/remot
**remote/** stores reduced versions of my *dotfiles* which I'm using as a default setup on any new remote systems. <br>
The function **newremote** in *dotfiles/config.bash* copys those files over to the remote host. <br>
```bash
function newremote {
  read -p 'enter user: ' user;
  read -p 'enter host: ' host;
  scp ~/repos/github/linux/dotfiles/remote/.vimrc $user@$host:;
  scp ~/repos/github/linux/dotfiles/remote/.bash_aliases $user@$host:;
  scp ~/repos/github/linux/dotfiles/remote/.bashrc $user@$host:;
  ssh -o "StrictHostKeyChecking=no" $user@$host "$(declare -f upgr);upgr";
  ssh $user@$host;
}
```
