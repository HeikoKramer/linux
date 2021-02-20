# TMUX – terminal multiplexer
`sudo apt install tmux` to install the application. <br> 
I've installed **tmux** for a while now, used it once in a while for updating multiple remote systems simultaniously. <br>
But I belive I'm usind it pretty basic and there is much more power behind it. <br> 
So I'm watching the tmux series from [LernLinuxTV](https://youtu.be/gmjyMxezIWU) as the channel has gernerally the best beginner tutorials in my opinion. <br> 
<br>
**NOTE**: I'm using [rwxrob's](https://github.com/rwxrob) tmux config so the keybindings differ from the originals to match an application called screen. <br> 
So if someone reads this .. <kbd>CTRL</kbd> <kbd>b</kbd> is the original prefix to initiated tmux commands but I'm using <kbd>CTRL</kbd> <kbd>a</kbd>. <br>
Other key bindings are changed as well in the [rwxrob-style config](https://github.com/HeikoKramer/linux/blob/main/dotfiles/tmux.conf), but check it out for yourself. <br> 
<br>
Enter `tmux` to start the application. <br> 
You can reconnect to a tmux session after you closed your terminal window or lost connection to a server with `tmux a` or `tmux attach`. <br>
## panes
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>|</kbd> to split vertical. <br> 
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>-</kbd> to split horizontal. <br> 
<kbd>CTRL</kbd> <kbd>a</kbd> and then <kbd>x</kbd> then <kbd>y</kbd> to confirm to exit a pane. <br> 
You can also type `exit` to kill a pane – that way no confirmation is required. <br> 
<kbd>CTRL</kbd> <kbd>a</kbd> and <kbd>o</kbd> lets you jump from pane to pane. <br> 
The **arrow keys** can as well be used to navigate between keys, so <kbd>CTRL</kbd> <kbd>a</kbd> and then <kbd>left</kbd> <kbd>right</kbd> <kbd>up</kbd> <kbd>down</kbd> will move you in  the direction you're pressing. <br>
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>z</kbd> will **zoom** into a pane. Means it will open fullscreen without exiting from the other panes. <br>
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>z</kbd> again will zoom out and bring back the other panes. <br>
## windows
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>c</kbd> to **create** a new window. <br> 
*New window doesn't mean new separate window, more an additional instance within the same window.* <br> 
*The content of the window where you sterted the command will disappear and you'll look at a fresh shell. <br>*
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>p</kbd> to move back to the **previous** window. <br> <kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>n</kbd> to move back to the **next** window. <br>
*It doesn't actually matter which command you use if you've only two windows open* <br>
Each window has gets a number, visible in the statusbar. The \* indicates on which window you're looking at. <br>
You can navigate to a specific window with <kbd>CTRL</kbd> <kbd>a</kbd> then that window's number. <br> 
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>&</kbd> to **kill** a window. <br>
**exit** <kbd>enter</kbd> will much easier to type but has the same effect. <br>
You can rename a window by typing <kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>,</kbd>. <br>
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>f</kbd> to **find** a window. <br>
*Shows a list tree of all open windows and panes and you can brows through it to preview their content.*
## sessions
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>d</kbd> **detaches** session and brings you out of tmux. <br>
`tmux a` to get back to the session. This works well if you have only one session opened. <br>
But you can have multiple tmux sessions running simultaniously. <br>
```sh
$ ps aux | grep tmux
heiko       2423  0.6  0.0  10700  4124 ?        Ss   07:35   0:02 tmux
heiko       4655  0.0  0.0   9376   728 pts/1    S+   07:43   0:00 grep --color=auto tmux
```
The **ps aux** command is one way to show those sessions. A better way though is **tmux list-sessions**: <br>
```sh
$ tmux list-sessions
0: 1 windows (created Fri Feb 19 07:35:26 2021)
1: 1 windows (created Fri Feb 19 07:42:46 2021)
```
You don't have to be in tmux to use that command. It can be used from an other terminal window and work just fine. <br>
`tmux a -t 0` brings you back to the session with index **0**, `tmux a -t 1` to session **1**. <br>
More comfortable as remembering the session index is to name a session. <br>
To do so enter the session you want to rename and type <kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>$</kbd> and enter the name in the panel. <br>
I've split one session in horizontal, one in vertical panes to see if the switching works, so  I named them vertical and horizontal: <br>
```sh
$ tmux list-sessions
horizontal: 1 windows (created Fri Feb 19 07:42:46 2021)
vertical: 1 windows (created Fri Feb 19 07:35:26 2021)
```
**NOTE:** You can use spaces in the name, like **horizontal split** but you'll get an error if you try `tmux a -t horizontal split`. <br>
The first word of the name will bring you to that session `tmux a -t horizontal`, but spaces are generally a bad ides here. <br>
A simple, short name makes sense at this point, as tab-completion doesn't work with the `tmux a -t` command. <br>
Hm … maybe a space is not that bad after all … if you name a session **1 horizontal** you'd had an index plus name and could do just `tmux a -t 1`. <br>
You can name a session directly when you open it with `tmux new -s "dev"` <br>
```sh
$ tmux ls
dev: 1 windows (created Fri Feb 19 08:17:09 2021)
horizontal: 1 windows (created Fri Feb 19 07:42:46 2021)
vertical: 1 windows (created Fri Feb 19 07:35:26 2021)
```
See that? `tmux ls` is the short command for `tmux list-sessions`. <br>
To list all the sessions in tmux, type <kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>s</kbd>. <br>
This is probably the most comfortable way to browse your sessions as you can navigate through them with the arrow keys and tmux even displays a little preview of the session. <br>
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>w</kbd> is maybe even better, as it shows all sessions plus their open **windows**. <br>

[tmux cheat sheet](https://tmuxcheatsheet.com/) <br>
