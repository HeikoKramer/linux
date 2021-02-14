# My Notes on Linux, Bash, whatsoever
## Permissions
### ID
The `id` command will provide information about current user. <br>
Output: uid=1000(heiko) gid=1000(heiko) groups=1000(heiko),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),114(lpadmin),134(sambashare),136(docker) <br>
uid = User Id <br>
gid = primary Group Id <br>
User acoounts are defined in the **/etc/passwd** file and groups in **/etc/group**. <br>
Those files also defining accounts for superusers (uid 0) and other system users. <br>
**/etc/group** holds the user's password information. <br>
In older Unix-like systems users where assigned to a common group like "users", modern Linux practice is to create a unique single-member group with the same name as the user. <br>

### Reading, Writing, Executing
`ls- l` will show a list of files whiting a directoy with attributes like this: **-rw-rw-r--** <br>
The first charakter (in my system not - but .) is the file type. <br>
|Attribute|File Type|
|:--------|:--------|
|- (.)|A regular file.|
|d| A directory|
|l|A symbolic link\*|
|c|A character special file\*\*|
|b|A block special file\*\*\*|

\**a symbolic link will always show rwxrwxrwx --> those are dummy values, the real attributes are those of the file where the link points to.* <br>
\*\**Device that handles data as a stream of bytes, such as a terminal or /dev/null* <br>
\*\*\**Handles data in blocks, such as a hard drive or a DVD drive.* <br>
<br>
The remaining nine characters of the file attributes are called the **file mode**. <br>
They represent **read**, **write** and **execute** permissions for the file's **owner**, **group** and **everybody else (world)**. <br>

|Owner|Group|World|
|:----|:----|:----|
|rwx|rwx|rwx|

|Attribute|Files|Directories|
|:----|:----|:----|
|r|open, read|content can be listed if **x** is also set.|
|w|write, truncate, \*|create, delete, rename files within directory|
|x|makes file executable\*\*|allows to enter directory| 

\**r attribute on file does not grand rename or delete, those permissions come from directory permissione* <br>
\*\**must be readable also to be executed.* <br>

### chmod - Change File Mode
`chmod` command is used to change file or directory permissions. It can be used only by the file's owner or a superuser. <br>
**chmod** supports octal number or symbolic representation. <br>
<br>
The **Octal** number system can be used to change permissions. <br>

|Octal|Binary|File Mode|
|:----|:----|:----|
|0|000|---|
|1|001|--x|
|2|010|-w-|
|3|011|-wx|
|4|100|r--|
|5|101|r-x|
|6|110|rw-|
|7|111|rwx|

Most common used: 7(rwx), 6(rw-), 5(r-x), 4(r--) and 0(---). <br>
By passing three octa arguments to **chmod**, we are able to set **owner**, **group** and **world** permissions at once. <br>
`chmod 600 foo.txt; ls -l foo.txt` will show *-rw-------* – **read** and **write** for the owner. <br>
`chmod 777 foo.txt; ls -l foo.txt` will show *-rwxrwxrwx* – **read**, **write** and **execute** for the owner, the group and the world. <br> 
<br>
chmod also supports **symbolic notation** <br>

|Symbol|Meaning|Examples|
|:----|:----|:---|
|u|user|`chmod u+x script.sh #Add execute permission for owner`<br>`chmod u-x script.sh #Remove execute permission from owner`|
|g|group|`chmod u+rw,go=r file #read,write for owner, read only for group and others`|
|o|others (world)|`chmod go=r script.sh #this will set read for group and others – if they had write and execute before, it will be removed`|
|a|all (u+g+o)|`chmod +x script.sh #this will make script executable for all as "a+x" would`|

### umask
**umask** holds the default permission setting for new created files. <br>
`umask` the command without any options will show the current default setting. <br>
umask uses octals, but works kind of reverse as chmod. For a binary 1 in the octal table it takes the permission from the default settings. <br>
`umask 7777` would result in a default created file **---------** while `umask 0000` would grant **rwxrwxrwx** by default. <br>
The whole thing works actually with only three digits, but the book states four would be more correct. I don't care at this point. <br>

### chown
**chown** changes the owner, the group or both of a file. <br>
`chown bob text.txt` changes the owner of the text file to "bob". <br>
`chown bob:users text.txt` changes the owner to "bob" and the group to "users". <br>
`chown :admins text.txt` changes the group to "admins", owner remains unchanged. <br>
`chown bob: text.txt` changes the owner to "bob" and the group to bob's login group. <br> 
*In older Unix versions a separate command **chgrp** was used to change group ownership.* 

### passwd
To change your password, just enter `passwd` into the shell. <br>
A superuser can change passwords for others `passwd bob`. <br>
The **passwd** command has options like setting an expiration date, etc. … can be found in the man page. <br>

## PROCESSES
### Process Monitoring
#### The ps command
`ps` will show you basic information on running processes associated whit the current terminal session. <br>
`ps x | less` will show us all of our processes regardless of what terminal they are controlled by. <br>
This will lead in an outcome like this: <br>
```bash
    PID TTY      STAT   TIME COMMAND
   1805 ?        Ss     0:00 /lib/systemd/systemd --user
```
STAT reveals the current **status** of a process: <br>

|State|Meaning|
|:---|:---|
|R|Running – process is running or ready to run|
|S|Sleeping – process **not** running; it is rather waiting for an event, such as a keystroke or network packet|
|D|Uninterruptible sleep – process is waiting for I/O such as a disk drive|
|T|Stopped – process has been instructed to stop|
|Z|Zombie – child process that was stopped but not yet cleaned up by parent|
|<|High Priority – process with more CPU time granted|
|N|Low Priority – process will get processor time after other processes have been serviced|

*The process state may be followed by ther characters. Check `ps` man page for more detailed process characteristics.* <br>
<br>
`ps aux` displays the processes belonging to every user. <br>
**Note: Using the options without a leading dash invokes the command with "BSD style".** <br>
|Header|Meaning|
|:---|:---|
|USER|User ID of the process owner|
|%CPU|CPU usage in percent|
|%MEM|Memory|
|VSZ|Virtual memory size|
|RSS|Resident set size\*|
|START|Time when the process started|

\**Amount of physical memory (RAM) used by the process (in kilobytes)* <br>
<br>
`pstree` will show a visualisation of running processes. <br>
`ps aux | grep bluethooth` would also provide information on running "bluethooth" processes. <br>
`pgrep -li bluetooth` **pgrep** is kind of a combined form of **ps** and **grep**, but it provides less information. <br>
*While the `ps` command can reveal a lot about what the machine is doing, it provides only a snapshot of the machine's state at the moment it is executed.* <br>
`vmstat` outputs a snapshot of system resource usage. <br>

#### Viewing processed dynamically with top
`top` ist the terminal equivalent of **System Monitoring** and provides a detailed insight of running processes. <br>
`top | grep bluethooth` will show all running processes containing the word "bluethooth" and keeps on refreshing changes on it. <br>
*The top command displays continuosly udating (3 sec by default) the running processes in  order of process activity.* <br>
<br>
`htop` is a more detailed top-like monitoring tool. <br>
<br>
To end `top` or `htop` press <kbd>q</kbd>. <br>

#### Controlling Processes
There is a bunch of processes that can be used for testing purposes: <br>
`xlogo` – sample program supplied with the X Window System (underlying graphic engine). <br>
`xeyes` – this program is showing eyes following the mouse pointer. <br>
`glxgears` – is a very basic graphics benchmark tool. <br>
<br>
If a process like xlogo runs in the foreground, it can be interrupted with <kbd>CTRL</kbd> + <kbd>c</kbd>. <br>
<kbd>CTRL</kbd> + <kbd>z</kbd> will send the process to the background.
<br>
The `fg` command can be used to bring that process back to foreground, `bg` to resume its execution in the background. <br>
`pidof xlogo` will display ID(s) of running xlogo processes.

#### Killing Processes
`kill 14349` will kill the process with the corresponding ID. <br>
`pkill xlogo` will end all xlogo processes. <br>
`kilall xlogo` will also end all xlogo processes. <br>

#### Shutting down the system
`sudo reboot`, `sudo halt`, `sudo poweroff` may be used to halt, power-off, or reboot the machine. All three commands take the same options. <br>
`shutdown` may also be used to halt, power-off or reboot the machine. <br>
`sudo shutdown -H now` to **--halt**, `sudo shutdown -P now` to **--poweroff**, `sudo shutdown -r now` to **--reeboot** <br>
*The time string may either be in the format "hh:mm" for hour/minutes specifying the time to execute the shutdown at, specified in 24h clock format. Alternatively it may be in the syntax "+m" referring to the specified number of minutes m from now.  "now" is an alias for "+0", i.e. for triggering an immediate shutdown. If no time argument is specified, "+1" is implied.* <br>

## BASH
### commands / receipies
```bash
cd                         # takes you back into the home  directory
cd -                       # takes you back into the last directory
cd ..                      # takes you one  director up

mv 8ball eightball         # renames the file 8ball to eightball within same directory
mv eightball somedir/      # moves the eightball file to the somedir directory
# IMPORTANT: Get into the habbit to always use a / when moving a file into a directory!
# This will save you from accidentally overwriting a file with an similar name.
# An other good habbit to prevent this is to use tab completion -> which always puts a / behind directories.
  
df                         # shows free disk space
dg -h                      # shows it in human readable format

free -h                    # shows available memory in human readable format

chmod +x hello             # makes the hello file executable
exec bash                  # refreshes bash 

which ls                   # will show you if / where the ls command is /bin/ls installed
type ls                    # will show if ls has been overwritten by alias
                           # use \ to execute the actual command --> \ls
# IMPORTANT: which will still show you the original command directory, even if the command was overwritten.
# Always use the type command if you want to know what exactly will be running.

ls test1/ test2/           # will list files of test1 and test 2 directory
ls -lt                     # will show list in long format last modified first   
ls -lt --reverse           # will show list in long format first modified first   

cp -u *.html test1/        # will copy all .html files to test1 directory
                           ## which do not exist in test1 already or 
                           ### which do exist there in an older version
cp -a * test1/             # will copy all files and directories with all attributes (ownership, permissions) to the test1 dir.
cp -r test1/ test2/        # will recursively copy test1 and its content to test2. -r or -a are required when copying directories.
cp ~/test1/*.html ~/test2  # will copy all .html files from test1 to test2 directory
cp ~/test1/* ~/test2       # will copy all files from test1 to test2 directory
cp -i test.txt test1/      # will copy test.txt to the test1 directory and ask for confirmation to overwrite, if a text.txt file already exists in there.
# IMPORTANT: note that cp without the -i option will silently replace identically named files!

rm -r test1/ test2/        # will remove test1 and test 2 directory + all files included files
rm *.html                  # will remove all .html files in working directory
# IMPORTANT: Be careful with the rm command as it will delete files permanently.
# A minor typo while using wildcards could have a huge impact.
# The above command rm *.html with an extra space rm * .html would delete all files within the directory.
# Use the wildcard with ls command first to ensure the outcome is as expected, then replace ls with rm. 

file TLCL-19.01.pdf        # Provides information on a file (TLCL-19.01.pdf: PDF document, version 1.5). 

ln file1 file2             # will create a hard link between file1 and file2
                           # whenever one file is changed, the other will change too
                           # when one file will be removed, the other will remain keeping the content
                           # file two will have no visible indicator that it is a link
                           # the number behind permissions in long list will indicate how many instances of the file exists (-rw-rw-r--  2)
                           # all instances will change when one gets edited
ln -s file1 file2          # will create a symbolic link between file1 and file2
                           # a visible indicator will show the connection in a list (file2 -> file1)
                           # when one file is edited, file1 will contain the change, file2 will only display it.
                           # when file1 is removed, file2 will be broken and not contain any content.
                           # when file2 gets deleted file1 remains unchanged
                            
apropos copy               # will search al man pages for the term "copy" and list the results.
whatis ls                  # will show a one-line description of what the "ls" command does
whatis $(ls /usr/bin) | grep -v "nothing appropriate" | less
# this command substitution will show the whatis entry of all programms in /user/bin and cut out empty entries.

pstree                     # shows running processes as a tree.

##### FIND ##### REDIRECT #####
find / -name '*.md'                                            #find
# finds all files ending with ".md" + error for files without permissions

find / -name '*.md' 2>/dev/null                                #find #redirect
# to exclude the error messages use the following command:

find / -name '*.md' 2>/dev/null 1>/tmp/found                   #find #redirect
# find all files with ".md" in the name, send errors to dev/null*, save result in found file in tmp directory.

find / -name '*.md' &>/tmp/found                               #find #redirect
# &> will redirect results + errors to the specified file. 

echo "1st line in file" > aa1                                  #redirect #create #overwrite
# will write "1st line in file" into the first line of the "aa1" file.
# the file will be created if it doesn't exist
# IMPORTANT: if the file exist > will overwrite the file - no matter what it contained before, it will only contain one line "1st line in file" then.
# To prevent > from overwriting files, place "set -o noclobber" in your .bashrc.
# With noclober set, an error occures when you try to > an existing file.
# use >| to overwrite a file when #noclober is set

> aa1                                                          #redirect #empty 
# This would completely empty the "aa1" file, but keep the empty file. 

echo "some text" >> aa1                                        #redirect #append 
# >> would append the string "some text" to the next empty line in the "aa1" file.

# *dev/null is the nirvana of the shell. It is also called "bit bucket" or "black hole". 
# https://en.wikipedia.org/wiki/Null_device

##### APT #####
sudo apt update
# refreshes the index of what packages are available at which version

sudo apt install tmux -y
# will install tmux and automatically answer **yes** to questions like additional disk space due to the **-y** option 

sudo apt install tmux htop git
# will install three application at once

sudo apt remove zathura -y
# will remove the app zathura without further questions

sudo apt search vim
# will show all available vim packages like vim-nox, neovim, etc.

sudo apt upgrade
# updates all packages with updates available 
# make sure index is up-to-date (sudo apt update) before you upgrade

sudo apt dist-upgrade
# performs upgrades for apps which require the previous removal or installation of a package

sudo vim /etc/apt/sources.list
# will open the sources file for apt

##### CAT #####
cat notes.txt
# This would display the content of "notes.txt" in the terminal.
# The cat command is mostly used to display short texts in standard output.

cat movie.mkv.0* > movie.mkv 
# If a file is split into multiple parts, cat can be used to combine them together.

cat
# If you type cat without a command or file, it will wait for standard input.
# CTRL + d will tell cat that the files end has been reached and cat will send what was typed to standard output.

cat > notes.txt
# This behavior can be used to generate textfiles with cat.
# New words / lines can be entered directly into the terminal.
# When CTRL + d get's pressed, all the input is commited to the file.

cat >> notes.txt
# Text can as well be appended to a file this way.

##### PIPELINES ##### SORT ##### LESS ##### UNIQ ##### WC ##### GREP #####
# Pipelines (|) take the output of one command and hand it over to another.

ls /bin /usr/bin | sort | less
# lists all files in bin + usr/bin, sorts them and displays the output terminal window by window.
# Without sort, the output would be two sorted lists 2x a-z after each other, so it is 1x a-z.

ls /bin /usr/bin | sort | uniq | less 
# uniq removes any dublicates from the sorted list, so that every entry only exists once.

ls /bin /usr/bin | sort | uniq -d | less
# the -d option of the uniq command can be used to display only the dublicate values from a list.

ls /bin /usr/bin | sort | uniq -d | wc -l
# adding the wc (word count) command with the -l option would display the number of dublicates

wc notes.txt
# The wc command without options will show the number of lines, word and bytes of a file.

ls /bin /usr/bin | sort | uniq | grep zip
# The grep command will reduce the output to only those lines which contain the word "zip".
# The -v option would show only lines NOT containing "zip".
# Use the -i option to ignore case sensetivity.

ls /bin /usr/bin | sort | uniq | grep -v zip | head -n 5
ls /bin /usr/bin | sort | uniq | grep -v zip | tail -n 5
# The head command would will show only the first 5, the tail command only the last 5 lines of our output.
# The default lines shown for both commands is 10 but any desired number can be specified after the -n option.
# I've detected that is works also without -n (head -5).

tail -f logfile
# The tail command has the option -f which coninues to monitor changes to the end of the file.
# This is especially usefull to monitor logfiles. It can be exited with CTRL + c.
# Article on advanced tail usage: https://www.howtogeek.com/481766/how-to-use-the-tail-command-on-linux/

ls /bin /usr/bin | sort | uniq -d | tee complete_list | grep zip
# The "tee" command allows to save an intermediate result to a file and continue with the pipe.
# In this example it saves the sorted unique output to "complete_list" before the list gets reduced to only those lines which contains "zip".

### git -> connecting to gitlab
ssh git@gitlab.com         # will show you if your ssh key is set up correctly or not

git config --global user.name heiko__c #set username in config file
git config --global user.email heiko.kraemer@protonmail.com #set email in config file
git config -l #shows config entries
git init 
git remote add origin git@gitlab.com:heiko__b/eightball
git add .
git commit -m "initial commit"
git push -u origin master

### default editor
sudo update-alternatives --config editor
```
----

### Wildcards / Expansion
|Wildcard|Meaning|
|:---|:---|
|\*|Matches any characters|
|?|Matches any single character|
|[characters]|Matches any character that is a member of the set characters|
|[!characters]|Matches any character that is **not** a member of the set characters|
|[[:class:]]|Matches any character that is a member of the specified class|

|Character Class|Meaning|
|:---|:---|
|[[:alnum:]]|Matches any alphanumeric character|
|[[:alpha:]]|Matches any alphabetic character|
|[[:digit:]]|Matches any numeral|
|[[:lower:]]|Matches any lowercase letter|
|[[:upper:]]|Matches any uppercase letter|

|Wildcard Examples|What it does|
|:---|:---|
|`rm *.jpg`|will remove all JPGs in working directory|
|`cp sys*.txt logfiles/`|will copy all textfiles beginning with "sys" to logfile directory|
|`rm *data????`|will remove all files with "data" before four other characters (newdata.txt, mydata.jpg)|
|`rm [dD]*`|will remove all files beginning with "D" or "d"|
|`rm BACKUP.[0-9][0-9][0-9]`|will remove all files beginning with "BACKUP" followed by three numerals|
|`ls 1*[Tt]`|will list all files beginning with "1" and ending with "T" or "t"|
|`ls [[:upper:]][a-z][a-z][a-z].txt`|will list 4-letter textfiles beginning with an upper case|
|`ls [A-Z][a-z][a-z][a-z].txt`|will show exactly the same result as the one above|
|`ls [![:digit:]]*`|will list files **not** beginning with numerals|
|`ls *[[:lower:]123]`|will list files ending with a lower case or the number "1", "2" or "3"|
|`ls *{day,night}*`|will list all files containing day or night|
|`ls !(*[Tt][Ee][Ss][Tt]*)`|will list all files **not containing** "test", "Test", "TEST", tEsT, …|
|`ls [Tt][Ee][Ss][Tt]*!(*[0-9])`|will list files starting with "test" (*case insensitive*) not ending with numeral|
|`echo .[!.]*`|will display all dotfiles but **not** ".."|
|`echo [!AaBb]*`|will display all non-dotfiles **not** starting with A,a,B,b|
|`echo !(Desktop|Documents|Downloads)`|will display all files except for "Desktop", "Documents", "Downloads"|
|`rm test{1..5}`| will remove "test1", "test2", "test3", "test4" and "test5"|
|`ls *-{FRA1,FRA2}-*`|will list all files containing -FRA1- or -FRA2-, like test-FRA1-777,  test-FRA2-775|
|`mkdir {1981..2021}-{01..12}`|will create 12 directories for each year from 1981 to 2021 in the format 1981-01|


### Extensive Wildcard Examples
`ls [![:digit:]]*[0-9][0-9][0-9]*[![:digit:]]` <br>
This will list all files containing (at least) three numerals but not beginning or ending with one. <br>
File examples: test1234test  test123test  test123Test  tesT123test 
<br>

`ls [![:digit:]]*[a-z][0-9][0-9][0-9][aA-zZ]*[![:digit:]]` <br>
This will only list files which are <br>
* containing exactly 3 digits
* a lower case letter before those digits
* an upper case letter after those digits 
* do not start or end with numerals

File examples: test123test  test123Test <br>

`touch FRA1-{A{001..12},B{013..24}}-Port` <br>
This will create files "FRA1-A001-Port" - "FRA1-A012-Port" and "FRA1-B013-Port" - "FRA1-B024-Port". <br>
<br>
Related term **globbing**: <br>
*In shell-speak, globbing is what the shell does when you use a wildcard in a command (e.g. * or ?). Globbing is matching the wildcard pattern and returning the file and directory names that match and then replacing the wildcard pattern in the command with the matched items.*

----

## Bash scripting
`watch ./greet` will repetitive (every 2 sec) execute the "greet" script and let you watch. <br>
`while true; do ./greet; sleep 2; clear; done` will do the same. <br>
*Both methods can be used to live-view what changes to your script will do on its output.* <br>

```bash
echo "${color}Hello ${reset}${name}"      #echo requires -n option not to do a line break.
printf "${color}Hello ${reset}${name}\n"  #with printf a linebreak has to be set (\n)
```

### Conditionals
#### Simple IF Statement
```bash
read -p "Enter your name " NAME

if [ "$NAME" == "Brad" ]
  then
  echo "Yoyoyoy Brad!"
else
  echo "Hello $NAME"
fi
```
Declare condition in **square brackets**.
The shown example asks user for input – his/her name –, if the name is Brad, a specialised greeting will be shown. All other names will be greeted with "Hello". <br>

#### ELSE-IF (elif)
```bash
if [ "$NAME" == "Brad" ]
  then
  echo "Yo Brad, whaaazzzup!!??"
elif [ "$NAME" == "Heiko" ]
  then
  echo "Hey Heiko, you're the best man!"
else
  echo "Hello $NAME"
fi
```
Same behavior here with Brad, but here's a second name "Heiko" which has an other special greeting defined. 

#### Comparison
```bash
NUM1=3
NUM2=5

if [ "$NUM1" -gt "$NUM2" ]
  then
  echo "$NUM1 is greater than $NUM2"
else
  echo "$NUM1 is less than $NUM2"
fi
```
`-gt` stands for **greater than**. Output: 3 is less than 5 <br>

```bash
NUM1=3
NUM2=5

if [ "$NUM1" -ne "$NUM2" ]
  then
  echo "$NUM1 is not equal to $NUM2"
else
  echo "$NUM1 is equal to $NUM2"
fi
```
`-ne` stands for **not equal**. Output: 3 is not equal to 5 <br>

`-eq` stands for **equal** <br>
`-ge` stands for **greater than or equal** <br>
`-lt` stands for **less than** <br>
`-le` stands for **less than or equal** <br>

#### File Conditions
```bash
FILE="text.txt"

if [ -f "$FILE" ]
  then
  echo "$FILE is a file"
elif [ -d "$FILE" ]
  then
  echo "$FILE is a directory"
else
  echo "$FILE is neither a file nor a directory"
fi
```
`-f` true if **file**. `-d` true if **directory**. Output: text.txt is a file <br>

`-e` true if file **exists** <br>
`-g` true if **group** id is set on file <br>
`-r` true if file is **readable** <br>
`-s` true if file has non-zero **size** <br>
`-u` true if **user** id is set on file <br>
`-w` true if file is **writable** <br>
`-x` true if file is **executable** <br>

#### Case Statement
```bash
read -p "Are you 21 or over? " ANSWER

case "$ANSWER" in
  [yY] | [yY][eE][sS])
    echo "You can have a beer :)"
    ;;
  [nN] | [nN][oO])
    echo "Sorry, no drinking (in the US)"
    ;;
  *)
    echo "Please enter y/yes or n/no"
    ;;
esac
```
The script above takes user input and handels it with case. **IMPORTANT**: Closing bracket required after specified case (no opening brackets). Double semicolon after specified command! **esac** to mark the end of case. <br>

#### Simple FOR Loop
```bash
NAMES="Brad Kevin Alice Mark"

for NAME in $NAMES
  do
    echo "Hello $NAME" | lolcat
    sleep 0.5
done
```

#### FOR Loop to rename files
```bash
clear
rm \*demo
touch abc.demo def.demo ghi.demo jkl.demo mno.demo pqr.demo stu.demo vwx.demo yzz.demo

FILES=$(ls \*.demo)
DATE=$(date -I)

echo "Adding Date"
sleep 1

for FILE in $FILES
    do
      echo "Renaming $FILE to $DATE-$FILE" | lolcat
      mv $FILE $DATE-$FILE
      sleep 1
done
sleep 1

FILES=$(ls \*.demo)

echo "Removing Date"
sleep 1

for FILE in $FILES
    do
      FILENAME=$FILE
      echo "Renaming $FILE to ${FILENAME:11}" | lolcat
      mv $FILE ${FILENAME:11}
      sleep 1
done
sleep 3
```
This little demo script creates demo files, renames it by adding the current date upfront and reverse that change by cutting away the date again. All for the sake of demo, lolcat is totally optional. <br>
*Stars escaped because of issues with the markdown - does backslash should be removed before running the script*. <br>

#### WHILE Loop – Read through a file line by line
```bash
LINE=1

while read -r CURRENT_LINE
  do
    echo "$LINE: $CURRENT_LINE"
    ((LINE++))
    sleep 5
done < "./der_spieler"
```
Script reads through Dostojewski's "Der Spieler" and prints it line by line on the screen. <br>
The line number is shown, the LINE variable increments with each iteration. <br>

```bash
if [ "$1" == "read" ] ; then
LINE=1
while read -r CURRENT_LINE
  do
    echo "$LINE: $CURRENT_LINE" 
    ((LINE++))
    sleep 5
done < "./der_spieler"
else
  echo "tell me what to do!"
fi
```
The same script within an if statement `if [ "$1" == "read" ]` would only read those lines from the book, when the called it with the read optin. `./myscript.sh read`. <br>
If called without an option (or with any other option) the scrip would return "tell me what to do!". <br>

#### Testing
`#!/bin/bash -x` as long as **-x** is behing the bash declaration, the script will print out additional information on what commands are running when executed. <br>
`test $a == "b" && echo "Yep" || echo "Nope"` would **test** if the variable "a" is equal to the value "b" – and if true echo "Yep", if false echo "Nope". <br>
`&&` is used to execute an other command after the prior command run successfully. <br>
`||` is used to execute an other command after the prior command did not run successfully. <br>

#### Creating a log file for your script
To create a log file for any script, the first thing would be to check if there is an existing log file. <br>
In this example we are going to create a log file for a script **myscript** whiting a prior created **logfiles** directory. <br>
```bash
if [ ! -f /home/$USER/logfiles/myscript.log ]; then
  echo "┌( ಠ_ಠ)┘ logfile -- myscript --" \
  > /home/$USER/logfiles/myscript.log 
fi
```
*log file tbc*

#### Install missing package quietly 
`dpkg -l | grep -qw git || sudo apt-get install -yyq git` <br>
This series of commands would check if the "git" package is already installed -> and if not install it without the requirement of further input by the user. <br>
*Super useful method to install a set of default tools on a new system.* <br>


#### Where to put a script
You'll want to move your script to someplace within your path statement so you can run it like any other installed program on your system. There are two preferred places for scripts and compiled programs not handled by your distro's package manager: <br>
<br>
**/home/username/bin** <br>
or <br>
**/usr/local/bin** <br>
<br>
Many distros will detect when you create a **bin** directory in your home directory and add it to path statement automatically (handled by .profile or .bashrc). <br>

```bash
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
```
#### Misc
You can break down a long line into more readable parts by usind the backslash charakter `\`. <br>
`echo $'\n' something` will echo "something" with a blank line above it. <br>

#### Here document

```bash
cat << _EOF_
Endlich bin ich nach vierzehntägiger Abwesenheit zurückgekehrt. Die Unsrigen befinden sich schon seit drei Tagen in Roulettenburg. Ich hatte geglaubt, sie warteten bereits auf mich mit der größten Ungeduld; indes ist dies meinerseits ein Irrtum gewesen. Der General zeigte eine sehr stolze, selbstbewußte Miene, sprach mit mir ein paar Worte sehr von oben herab und schickte mich dann zu seiner Schwester. Offenbar waren sie auf irgendwelche Weise zu Geld gekommen. Es kam mir sogar so vor, als sei es dem General einigermaßen peinlich, mich anzusehen. Marja Filippowna hatte außerordentlich viel zu tun und redete nur flüchtig mit mir; das Geld nahm sie aber in Empfang, …
_EOF_
```
The use of the _EOF_ tag (or any other) print that text on the screen while keeping its format and without the requirement to exit any signes user in bash, like quotes, etc. <br>

```bash
sudo apt install xclip jq vim rofi snapd git neofetch cargo ranger brave \
htop locate lynx tmux postman keepassxc vs code nmap docker.io whois \
beep lolcat
```
The above shown example would be interpreted as only one line. <br>

### Parameter expansion
```
name=World
echo "Hello ${name}" 
```

*no matter what the input is … World, WORLD, world, wOrLd or whatever, you can specify the format of the output like this:* <br>

`${name,,}` will show as **world**. <br>
`${name^^}` will show as **WORLD**. <br>

echo ${var}
#Output: tak3 this simple t3xt
#prints var

echo ${#var}
#Output: 21 
#shows length of var (including spaces)

echo ${var:0}
#Output: tak3 this simple t3xt
#shows everything from letter zero to end

echo ${var:2}
#Output: k3 this simple t3xt
#shows var after letter two

echo ${var:0:2}
#Output: ta
#shows var from letter zwero to letter two

echo ${var:0:-2}
#Output: tak3 this simple t3
#shows var from letter zero to end minus two

echo ${var:4:-4}
#Output: this simple
#shows var after letter four to end minus four 

echo ${var: -4}
#Output: t3xt
#shows minus four letters from end (space required!)

echo ${var/s/z}
#Output: tak3 thiz simple t3xt
# replaces first appearance of "s" in var with "z"

echo ${var//s/z}
#Output: tak3 thiz zimple t3xt in var
#replaces all "s" in var with "z"

echo ${var//this/that}
#Output: tak3 that simple t3xt
#replaces all "this" in var  with "that"

echo ${var:0:-5}_abc
#Output: tak3 this simple_abc
#cuts last five letters, adds "_abc"
```

### Command substitution
`echo "Today is $(date)"` will print: "Today is Mon 11 Jan 2021 12:44:17 PM CET". <br>
`echo one plus one is $((1 + 1))` will print: "one plus one is 2". <br>
*math substitutions require a second set of brackets to be calculated* <br>

```bash
declare -i quater=3
echo "Result: $((100 / 12 * quater))"
```
Outcome of this is: "Result: 24" <br>
*math substitutions are the only place that do nor require a "$" to use a variable.*  <br>

### Working with Parameters and Arguments
Parameter: Slot, a thing where you can put something in. <br>
Argument: The thing that goes in the paramenter. <br>
*General wisdom: When in doubt, quote it out* So if you're not sure, if you require something in double quotes to functure properly .. put those quotes around it! <br>
So let's say our script **greet** contains the following:

```bash
declare name="$1"
echo "Hello ${name}"
```
It will take the first argument and place it into the variable "name". <br>
`greet World` will result in the output *Hello World*. <br>

```bash
declare name="$1"
declare name="${1:-World}"
```
This sets a default output to "World" .. if called `greet Heiko`, the output will be *Hello Heiko* if called `greet` it will be *Hello World*. <br>

----

## Globstar
Globstar allows to search recursively through sub-directories. <br>
It has to be enabled for a script of generally via the bashrc. <br>
The command to enable it is `shopt -s globstar`. <br>
<br>
Example: `ls -a **test*` will show you all files containing test in the current directory + it's sub-directories.

----

## Quoting
There are two types of quoting: <br>
**Weak**: uses double quotes: " <br>
**Strong**: use single quotes: ' <br>
<br>
If you want to bash to expand your argument, you can use **Weak Quoting**:
```bash
#!/usr/bin/env bash
world="World"
echo "Hello $world"
#> Hello World
```
If you don't want to bash to expand your argument, you can use **Strong Quoting**:
```bash
#!/usr/bin/env bash
world="World"
echo 'Hello $world'
#> Hello $world
```
You can also use **escape** to prevent expansion:
```bash
#!/usr/bin/env bash
world="World"
echo "Hello \$world"
#> Hello $world
```
*Source: https://riptutorial.com/bash*

----

## NETWORKING
The `ping` command sends packages to a specified host and provides information on package travel speed. <br>
Example: `ping heikokraemer.de` provides information regarding the connection to the server where heikokraemer.de is hosted. <br>
The `tracepath` command provides informations about the hops to the specified target. <br>
`nslookup` (from name server lookup) is a network administration command-line tool for querying the Domain Name System (DNS) to obtain domain name or IP address mapping, or other DNS records. <br>
`dig` is a command-line tool for querying DNS name servers for information about host addresses, mail exchanges, name servers, and related information. It supersedes in functionality older tools, such as `nslookup`. <br>
`ip -br a` shows the connections your computer hast to the internet. <br>
127.0.0.1 or lokalhost - is the hostname that refers to the current computer. https://en.wikipedia.org/wiki/Localhost <br>
`vi /etc/services` shows a list of all service ports. <br>
The `scp` command copies files over a secure, encrypted network connection. https://www.computerhope.com/unix/scp.htm <br>

----

## SSH
Create ssh key: `ssh-keygen -t ed25519` **Note:** we have used the **-t** option to specify key type ed25519. <br>
**ATTENTION:** processing like this is ok to generate the very first ed25519, but carefull not to overwrite an existing key – it could be your only way to enter a server. <br>
`ssh-keygen -t ed25519 -C "pihole"` the -C option can be used to **comment** on the key's usage. <br>
In the next steps the ss-keygen is asking *Enter file in which to save the key* – it is as above mentioned really important to change the default file name if multiple keys exist, the first key gets silently overwritten otherwise! <br>
A password for the key is optional, but recommended – especially when using it with an employeer or client. Everyone with access to an unsecured key would be able to identify as yourself and log into all remote systems using the key. A missing pw could even have legal consequences. <br>
Find your own naming convention, if you're for example using the key dedicated for a pihole dns server, name it *pihole_id_ed25519*. <br>
`ssh-add ~/.ssh/pihole_id_ed25519` can be used to store a private key in memory for the running ssh agent session – that way you'll have to entere the pw only once for that session. <br>
<br>
Show public key: `cat .ssh/id_ed25519.pub` <br>
Login into something: `ssh root@167.71.42.169` <br>
Copy something over: `scp /home/heiko/.bashrc root@167.71.42.169:` <br>
<br>
Place the following information into ~/.ssh/config to establish a connection by addressing the host: `ssh bboost` <br>
```bash
Host bboost
        User root
        Hostname 167.71.42.169
        IdentityFile ~/.ssh/id_ed25519.pub
```
`ssh bboost 'ls -alht' > bboost-home` will perform a list command within the home directory of the remote host "bboost" and save its output in as file "bboost-home" within the working directory. <br>
Use **single quotes** to hand over commands to a remote machine. <br>
`ssh user@host "$(declare -f upgr);upgr"` will execute the local "upgr" function on the remote system. <br>
Use **double quotes** to declare and execute functions. <br>
`ssh-copy-id -i ~/.ssh/id_ed25519.pub root@167.71.42.169` can be used to copy the public key over to a remote system. <br>

### sshd (ssh daemon)
`systemctl status sshd` shows the sshd status. <br>
The **sshd_config** lives in the **/etc/ssh** directory. <br>
**Warning:** dont's delete any of those host key files in that directory or you won't be able to re-connect to the server! <br>
sshd_config is important to change the default port, root login permit, password authentications, etc. <br>
`service ssh restart` or `systemctl restart sshd` restarts sshd (required to load sshd_config changes). <br>
**Important:** don't disconnect from the remote system until you've tested the sshd config change in an other session! <br>
<br>
PermitRootLogin should be set to **no** – !!after!! an other login user has been created. This is an important security setting as root is a powerful default admin user which all hackers are going to use. Shutting down that default setting is shutting down default attacks. <br>
<br>
PasswordAuthentication should been set to **no** as soon as ssh has been setup has been completed. <br>

### Tracking user logins
You can track user login login sessions with `tail -f /var/log/auth.log`. <br> 

### Troubleshooting ssh
* timeout messages could mean that the port is blocked by the router/firewall.
* permissions should be checked
  * ssh will only work if the private keys are **rw** by the user and nothing more.
  * the .ssh/ directory should only be **rwx** by your user
  * same on the remot side, .ssh/ and authorized key files should only be **rw** by you
* if you have a user with issues loging in .. let him try while you tail the logs

### User Management
To naviagate a system as root user is dangerous, because that user can change and delete everything. So any mistake could have irretrievable consequences .. loss of data, etc. <br>
There are two command to create a new user `useradd` and `adduser`. <br>
`adduser` is a perl script which leads as a single command through the whole user creation process, while `useradd` requires to manually execute a series of commands. <br>
<br>
`adduser hk` will create a new user **hk**. <br>
One way to give that user the rights to use the sudo command and therewith to install software, etc. is to edit the **group** file in the **etc** directory. <br>
`vim /etc/group` --> and then add the username at the and of the sudo line: *sudo:x:27:hk* <br>
To eneable ssh login for that user .. <br>
`su - hk` (logged in as root -> login as hk) <br>
`mkdir .ssh` (create .ssh directory) <br>
`chmod 700 .ssh` (make directory only readable for that user) <br>
`vim authorized_keys` -> paste outcome from `cat .ssh/id_ed25519.pub` on local host into that file and save. <br>
Now change the ~/.ssh/config to *User hk* -> `ssh bboost` will now log you in as hk. 
```bash
Host bboost
        User hk
        Hostname 167.71.42.169
        IdentityFile ~/.ssh/id_ed25519.pub
```
To change default port on host: <br>
```bash
vim /etc/ssh/sshd_config
# then change "Port" to 29999
service sshd restart
# add port setting to ssh config or use command:
ssh -p 29999 root@jitsi.myforce.net
```

----

## Searching for files
### locate
`locate` performs rapid database searchs of pathnames and outputs every name matching the given substring. <br>
`locate bin/zip` would provide us a list with all programs starting with "zip". <br>
There are several variants of **locate** – most common are **slocate** and **mocate**. <br>
`locate` won't work at a fresh installation or most recent files as it's using a search databes updated by a cron job. <br>
That cron job is running `updatedb` which can as well be run at the promt by the superuser. <br>
Looks like Raspian has no locate installed by default. <br>
<br>
### find
`find` is an other search command and it comes with a lot of interesting features. <br>
`find ~ | wc -l` will find and count all files in home + all sub-directories. <br>

#### -type
`find ~ -type d | wc -l` will count the **directories** starting from home. <br> 
`find ~ -type f | wc -l` will count the regular **files** starting from home. <br>

|file type|descriptio|
|:--------|----------|
|b|Block special device file|
|c|Charakter special device file|
|d|Directory|
|f|Regular fiel|
|l|Symbolic link|

#### -name *pattern*
`find ~ -type f -name ".vim*"` will show all **vim dotfiles**. <br>
*-name can be used with the wildcard pattern:* <br>
`find ~ -name '[A-Z][a-z][a-z][a-z].txt'` will find all 4-letter .txt files starting with a capital letter, like Test.txt or Find.txt. <br>
`find ~ -name '*[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]*'` finds all files containing a date structure like *2019-04-23*. <br>

#### -size *n*
`find ~ -type f -name "*.png" -size +500k` will show all **png** files larger than **500kbyte** <br>
-size **+** searchs for files **larger** … **-** for files **lower** than the specified unit. <br>

Size Units: 
|Character|Unit|
|:---|:---|
|b|512-byte blocks (default if not specified)|
|c|Bytes|
|w|2-byte words|
|k|Kilobytes|
|M|Megabytes|
|G|Gigabytes|

---
**NOTE**

-cmin / -ctime vs. -mmin / -mtime <br> 
**c**: means that either the content was changed, or the file's metadata (permission, owner, etc). <br>
**m**: means that only the content was modified.

---

#### -cmin *n* 
`$ find ~ -type f -cmin -5` finds files which were changed less then 5 minutes ago. <br>
`$ find ~ -type f -cmin +5` finds files which were changed more then 5 minutes ago. <br>
`$ find ~ -type f -cmin 5` finds files which were changed exactly 5 minutes ago. <br>

#### -cnewer *n*
`find ~ -type f -cnewer ~/.bashrc` finds files modified after .bashrc was las modified. <br>
 *-cnewer* requires full path: `find ~ -type f -cnewer ~/repos/gitlab.com/heiko__b/dotfiles/notes.md` <br>
 
#### -ctime *n*
`find ~ -type d -ctime 2` shows directories whose contents or metadata were modified within th last two hours. <br>

#### -empty
`find ~ -type d -empty` shows all empty directories. <br>

#### -group *name*
`find ~ -type f -group heiko | wc -l` shows all files belonging to group **heiko**. <br>

#### -iname *pattern*
Like name but case-insensitive <br>
`find ~ -type d -iname "*music*"` shows all directories whose name contains **music** or **Music**, etc. <br>

#### -mmin *n*
`find ~ -mmin -10 | wc -l` counts files whose contents were changed less then ten minutes ago. <br>

#### -mtime *n*
`find ~ -type d -ctime 2` shows directories whose contents were modified within the last two hours. <br>

#### -newer *file*
like -cnewer but only for datachanges, does not compare metadata changes like permissions. <br>

#### -nouser
`find ~ -nouser | wc -l` finds files not belonging to a valid user. <br>
*Can be used to find belongings of deleted accounts or detect activity by attackers.* <br>

#### -nogroup
`find ~ -nogroup | wc -l` finds files not belonging to a valid group. <br>

#### -perm *mode*
`find ~ -perm 777 | wc -l` counts files and directories that are *rwxrwxrwx*. <br>

#### -user *name*
`find ~ -user heiko | wc -l` counts all files and directories belonging to user **heiko**. <br>
<br>
#### logical operators (-and, -or, -not)
Multiple find options can be combined usind logical operators: <br>
`find ~ \( -type f -not -perm 0600 \) -or \( -type d -not -perm 0700 \)` <br>
<br>

#### predefined *find* actions
|Action|Description|
|:---|:---|
|-delete|Delete the current matching file|
|-ls|Equivalent of `ls -dils`|
|-print|Outputs full path of matching files (default)|
|-quit|Quit once a match has been made|
<br>
`find ~ -type f -name '*.xyz1' -delete` will find and delete all files ending with .xyz1. <br>
#### user defined *find* actions
All kind of commands can be used with the matching files / directories by usind: <br>
`-exec command '{}' ';'` or `-ok command '{}' ';'` <br>
**-exec** performs the action immediately: `find ~ -type f -name '*.xyz1' -exec rm '{}' ';'` <br>
*All files ending on .xyz1 will be removed after executing that command.* <br>
**-ok** performy the action file by file after user confirmation: `find ~ -type f -name '*.xyz1' -ok rm '{}' ';'` <br>
That command will result in a dialog `< rm ... /home/heiko/test1/def.xyz1 > ?` which has to be confirmed with **y** or declined with **n** for each file. <br>
**Note**: those commands above will execute their actions per files – which in most cases is an unnecessary heavy use of resources. <br>
So instead of ending our *remove* example with **';'** the following command will execute it on all files combined: <br>
`find ~ -type f -name '*.xyz1' -exec rm '{}' +` **+** will rm *file1* *file2* … <br>
<br>
#### xargs
An other way to execute such actions more efficient is the `xargs` command. <br>
**xargs** constructs and argument list of the prior output and executes a specified command: <br>
`find ~ -type f -name '*.xyz1' | xargs rm` is the xargs version of our *remove* example <br>

#### options
|Option|Description|
|:---|:---|
|-depth|Process a directory's files before itself|
|-maxdepth *levels*|Set max depth directory tree level|
|-mindepth *levels*|Set min depth directory tree level|
|-mount|Do not traverse on other file systems mounted directories|
|-noleaf|No Unix-like search optimization (needed for CD-ROMs / Windows file systems)|

*Options must be placed before any other arguments* <br>
`find -depth -name '*xyz*' -exec rm -r '{}' +` without **-depth** the system would delete first findings first – so if a directory would be named xyz and countain files named xyz, an error would be throw when the system tries to delte files it had already deleted with the directory. <br>

----

## Licenses for free software
* Apache License V2 https://www.apache.org/licenses/LICENSE-2.0.html
* Creative Commons https://creativecommons.org/choose/
* GNU General Public License https://en.wikipedia.org/wiki/GNU_General_Public_License

---- 

## further reaserch
* tab completion (Linux Beginner Boost Day 3 - 41:00)
* Rob's .vimrc & .bashrc -> for PLATFORM (linux,windows,mac,unknown)
  * check out how he sets different behaviours based on the platform he's working on.
* rwxrob's vim plugins and outoload plugin manager. Left that out my vimrc for now.
* wemux
* cd path withing rob's dotfiles (bashrc).
* I've skipped signals .. it's at page 144 in the book.
* Wargames: https://overthewire.org/wargames/bandit/ Bandit to chapter 5.
* Setup a Linux Server on all the major cloud providers
	* AWS, Google, Azure, Digital Ocean, Linode, Hetzner
	* Connect two of those servers together
* `curl http://ix.io/2mD6 | cat` read through all those settings from Rob's .bashrc
* checkout and fully understand pstree - what it is, what it does, what it shows
* Know difference between desktop- display- and window-manager
* Check out "Browsersync"
* Check out `ip` and `netstat` command in detail to gain more networking skills
* Learn more about `ftp`, `lftp`, `wget` and how to use it securely for filesharing
* Learn more about `systemctl` command

----

## Turorials, resources
https://subsignal.org/doc/AliensBashTutorial.html
List of tutorials: https://riptutorial.com/bash/awesome-learning/tutorial
Terminal commands sorted by topics: http://www.linuxguide.it/command_line/linux_commands_en.html

----

## Misc
### rwxrob's random comments
* don't use aliases -> use functions!
	* aliases can't be used by scripts
* export: makes a function available to child processes
	* `export -f greet` to export "greet" -f = **function**
	* `&& export -f greet` after the greet function ensures that the function gets exported – only if there is no error in it.
* $1: variable for the first input
* $\*: will allow the input to contain spaces
* create the file first, with touch, not via the editor
	* that way you'll realise no write access on dir before editing

----

## VIM

### the dot
<kbd>.</kbd> will repeat the last used command. So if you typed <kbd>d</kbd> <kbd>w</kbd> to delted a word, you only need to press <kbd>.</kbd> to continue deleting word by word. <br>
The dot can also be used to repeat more complex operations like the change of a word: <br>
If you press <kbd>c</kbd> <kbd>e</kbd> on the word "bank" and replace it with "financial institution", then exit insert mode with <kbd>ESC</kbd> and press <kbd>n</kbd>, your cursor will jumt to the next appearence of the word "bank". A press on <kbd>.</kbd> will then repeat the change and replace it with "financial institution". That way you can jump from "bank" to "bank" by pressing <kbd>n</kbd> and change those where it is required. <br>
To out-commend a line of bash code, press <kbd>0</kbd> <kbd>i</kbd> <kbd>#</kbd> – this can be repeated at each following line to quickly commend a block of text. <br>

### VIM config
The line **au bufnewfile,bufRead *filename* set filetype=sh** added in VIM config will make vim interprete the file *filename* as a bash file. <br>
`:set nu` show line numbers in vim. `set nonu` hides them. <br>
`:so %` reloads the file without closing it (to source a file) <br>
`:set list` shows you spaces tabs and stuff. `:set nolist` to turn it off. <br>
`:set cursorline` or `:set cul` to show a line under current cursor position. `nocursorline` or `nocul` to switch it off. <br>

### VIM ressources
**vimtutor** command to open an in vim integrated tutorial <br>
https://rwx.gg/vi-magic-wands/ <br>
https://vimgenius.com <br>
https://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/ <br>

### Navigation in VIM
To move the cursor use the h,j,k,l keys in the middle of the keyboard. <br> 
<kbd>k</kbd> The k key moves up. <br>
<kbd>j</kbd> The j key moves down. <br>
<kbd>h</kbd> The h key moves left. <br>
<kbd>l</kbd> The l key moves right. <br>
<kbd>0</kbd> then <kbd>ENTER</kbd> will bring you to the start of the line. <br>
<kbd>$</kbd> then <kbd>ENTER</kbd> will bring you to the end of the line. <br>
A number then <kbd>w</kbd> will jump number of words forward (2w wil jum two word). <br>
<kbd>3</kbd> then <kbd>e</kbd> will jump to the end of the third word from where the curso are. <br>
<kbd>CTRL</kbd> <kbd>g</kbd> will show your position in the document. <br>
Jump to document start by typing <kbd>g</kbd> <kbd>g</kbd>. <br>
Type <kbd>G</kbd> to jump to to the file bottom. <br>
<kbd>%</kbd> over any kind of bracket will flip cursor to the matching part. <br>
<kbd>4</kbd> <kbd>2</kbd> <kbd>G</kbd> will bring you to line 42. <br>
<kbd>4</kbd> <kbd>2</kbd> <kbd>g</kbd> <kbd>g</kbd> will bring you to line 42. <br>
<kbd>:</kbd> <kbd>4</kbd> <kbd>2</kbd> will bring you to line 42. <br>
<kbd>g</kbd> <kbd>j</kbd> moves down to a blank line (only <kbd>j</kbd> skipps those lines). <br>
Capital <kbd>W</kbd> and <kbd>B</kbd> move you word by word - but don't count brackets and stuff as words like <kbd>w</kbd> and <kbd>b</kbd> do. <br>
<kbd>f</kbd> + letter takes you to the next appearance of that letter in this line. <br>
<kbd>F</kbd> + letter takes you to the last appearance of that letter in this line. <br>
<kbd>CTRL</kbd> <kbd>f</kbd> for page down. <kbd>CTRL</kbd> <kbd>b</kbd> for page up. <br>

### Exiting VIM
VIM has different modes in which it is operating. <br>
To ensure you're in the **Normal** mode - from which you can exit - press <kbd>ESC</kbd> <br>
Type <kbd>:</kbd> then <kbd>q</kbd> then <kbd>!</kbd> and hit <kbd>ENTER</kbd> to exit VIM without saving. <br>
Type <kbd>:</kbd> then <kbd>w</kbd> then <kbd>q</kbd> and hit <kbd>ENTER</kbd> to save and exit. <br>
Type <kbd>:</kbd> then <kbd>w</kbd> and hit <kbd>ENTER</kbd> to save without exiting. <br>
<kbd>Z</kbd> <kbd>Z</kbd> is a way to quit VIM from **normal** mode with saving the file. <br>

### Delete
Press <kbd>x</kbd> in **Normal** mode to delete the character under the cursor. <br>
Park the cursor on the first letter of a word you'd like to **delete** and press <kbd>d</kbd> then <kbd>w</kbd>. <br>
The <kbd>e</kbd> instead of the <kbd>w</kbd> to leave the space after the word. <br>
Press <kbd>d</kbd> then <kbd>$</kbd> then <kbd>ENTER</kbd> to delete from where your cursor is to the end of the line. <br>
<kbd>d</kbd> <kbd>d</kbd> deletes the whole line. <br>
<kbd>3</kbd> <kbd>d</kbd> <kbd>d</kbd> deletes three lines. <br>
<kbd>d</kbd> <kbd>3</kbd> <kbd>w</kbd> will delte the word under the cursor plus the next two words. <br>
<kbd>3</kbd> <kbd>d</kbd> <kbd>d</kbd> deletes the line where cursor is plus the next two lines. <br>
<kbd>D</kbd> deletes from cursor position to the end of the line. <kbd>d</kbd> <kbd>$</kbd> does the same. <br>
When you're in line 15 ant type <kbd>d</kbd> <kbd>:</kbd> <kbd>3</kbd> <kbd>0</kbd> <kbd>ENTER</kbd> 15 lines (15-30) will be deleted. <br>
<kbd>d</kbd> <kbd>}</kbd> will delete a whole block, means to the next empty line. <br>

### Copy, cut and paste
Good summary: https://vim.fandom.com/wiki/Copy,_cut_and_paste
There is no ctrl+x style cut and paste in Vim --> because it keeps the last deleted line in the cache. So to cut and past just delete whatever you want to cut and it is ready to be pasted. The so called cut command is not really for pasting, it is good for deleting and change into edit mode at the same time.
<kbd>p</kbd> the put command can be used to place prior deleted lines or words at cursor position. <br>
<kbd>2</kbd> <kbd>p</kbd> will paste the prior delted string two times. <br> 
`y7w` will copy seven works from the cursors position. <br>
`2y` will copy two lines from the cursors position. <br>
`y$` will copy from cursor to the end `y0` to beginning of the line. <br>

### Insert mode text editing
Press <kbd>a</kbd> in **Normal** mode to start appending letters where you are. <br>
Press <kbd>A</kbd> in **Normal** mode to start appending at the end of the line. <br>
<kbd>c</kbd> <kbd>e</kbd> will delete from where the cursor is to the end of the word and put you in **insert** mode. <br>
<kbd>c</kbd> <kbd>$</kbd> will delete everything from where the cursor is to the end of the line and put you in insert mode. <br>
<kbd>2</kbd> <kbd>c</kbd> <kbd>c</kbd> will delete the two lines after the cursor and put you in insert mode. <br>
<kbd>o</kbd> will open a new line below the cursor and put you in **insert** mode. <br>
<kbd>O</kbd> will do the same but above the cursor position. <br>
<kbd>e</kbd> will make the cursor jump to the last letter of the next word. <br>
Use <kbd>e</kbd> in combination with <kbd>a</kbd> to jump to last letter before your insert, so you can straight start typing. <br>
<kbd>s</kbd> will delete the letter under the cursor and put you in **insert** mode. <br>
<kbd>S</kbd> will delete the line under the cursor and put you in **insert** mode. <br>
<kbd>I</kbd> will start **insert** mode at the beginning of the line.

### Undo, redo
<kbd>u</kbd> will undo the last change, the next <kbd>u</kbd> undos the prior change and so on … <br>
while <kbd>U</kbd> will undo all changes on the last edited line. <br>
<kbd>CTRL</kbd> + <kbd>r</kbd> redos the chages if you undid something by mistake. <br>
Redo doesn't work after capital <kbd>U</kbd>. <br>
<kbd>R</kbd> will enter **replace** mode where you can override everything under the cursor. <br>
<kbd>5</kbd> <kbd>u</kbd> will undo the last five operations. <br>

### Search 
To search for type <kbd>/</kbd> then any phrase then <kbd>ENTER</kbd>. <br>
<kbd>n</kbd> jumps down to the next search hit, <kbd>N</kbd> jumps up. <br>
You can start a search with <kbd>?</kbd> as well -> <kbd>n</kbd> and <kbd>N</kbd> move in the opposite direction then. <br>
<kbd>CTRL</kbd> <kbd>o</kbd> will bring you back to where you started the search. <br>
<kbd>CTRL</kbd> <kbd>i</kbd> will jump back to next cursor position. <br>
`:set ic` will ignore case sensitivity. <br>
A search for `/ignore` will show ignore, IGNORE or Ignore than. <br>
If you want to ignore case sensitivity for just one search type `/ignore\c`. <br>
`:set hls is` will activate search highlighting. <br>
`:nohlsearch` will deactivate it. <br> `:no` + command will disable all `:set` commands. <br>

### Replace
`:s/thee/the` will replace the firtst thee in the line  with the. <br>
`:s/thee/the/g` will replace all thee in the line. <br>
`:%s/thee/the/g` will replace all thee in the file. <br>
`:%s/thee/the/gc` finds all thee in the file and gives options replace y/n <br>
`545,555s/bold/old/g` will replace all bold with old in between line 545 and 555. <br>

### Indentation
<kbd>\></kbd> <kbd>\></kbd> in **normal** mode to indent a line. <br>
<kbd>\<</kbd> <kbd>\<</kbd> to take that line back. <br>
<kbd>5</kbd> <kbd>\></kbd> <kbd>\></kbd> to indent five lines from the cursors position. <br>

### Command & Visual mode
<kbd>:</kbd> <kbd>!</kbd> will set VIM in the mode to execute any external command. <br>
`:!ls` will for example show a list of the current directory. <br>
`:w filename` will save a copy of the edited file with name *filename*. <br>
<kbd>v</kbd> brings you in **visual** mode. All moves you make in visual mode mark the text you're passing by. <br>
You can use commands like <kbd>d</kbd> to delete the selected text or press <kbd>:</kbd> for external commands. <br>
`:w TEST` will for example write the selected text into a file named *TEST*. <br>
The command promt looks a bit different in **visual** mode, the above will apper like `:'<,'>w TEST`. <br>
`:r TEST` will insert the content of TEST at the cursor position. <br>
Outputs of external commands can be inserted as well, example: `:r !ls`. <br>
<kbd>v</kbd> for **visual** mode and then <kbd>y</kbd> will copy all marked text. <br>
If `:e` is entered - or any other first letter - and <kbd>CTRL</kbd> + <kbd>d</kbd> is pressed the all command starting wit **e** will show. <br>

### Executing Code in Vim
<kbd>:</kbd> then `read !echo "Hello"` would print "Hello" at the cursors position. <br>
Or <kbd>:</kbd> `read !ps aux` would paste a list of running processes into the file. <br>
If you have a code block of **bash** in your document, and you want to see the outcome of it, press <kbd>!</kbd> <kbd>}</kbd>. It get's translated into an x-command and when you now typ "bash" and hit <kbd>ENTER</kbd>, the code block will get replaced with its actual output. <br>

### Case folding
<kbd>~</kbd> in **normal** mode changes the case of the letter under the cursor. <br>

### VIM tricks – magic wand
<kbd>!</kbd> <kbd>!</kbd> to enter a mode in which Vim accepts any command / function as input and writes its output at the cursors position. <br>
*Functions should be exported to be available in Vim!* <br>

----

## TMUX (rwxrob config)
Enter `tmux` to start the application. <br>
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>|</kbd> to split vertical <kbd>-</kbd> to split vertical. <br>
Rob's config is inspired by **screen** which is still usefull for remote work. <br>
 which is still usefull for remote work. <br>
<kbd>CTRL</kbd> and <kbd>o</kbd> lets you jump from pane to pane. <br>
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>d</kbd> – detached, the session is ended. <br>
If you enter `tmux a` it will reconnect to the last session, bringing you where you've left. <br>
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>x</kbd> will kill a pane. <br>
<kbd>CTRL</kbd> <kbd>a</kbd> then <kbd>w</kbd> will show all windows. <br>

----

## MUTT
Mutt is a terminal email client. <br>

### installation & configuration
`sudo apt-get install mutt` get's mutt installed. <br>
Create file **~/.config/mutt/muttrc** and write inside: <br>
```sh
set folder ="imaps://mailadress@here.pl@Mailserver.information.here:993"

set spoolfile = "+INBOX"
``` 

Opening `mutt` or `neomutt` if installed will now ask you for the mail pw. <br>
You can now browse and read through your email. **N** are **new** mails, **r** marks emails you have **replied** too. <br>
<kbd>?</kbd> will show you all the key-bindings in place. <br>
<kbd>c</kbd> then <kbd>?</kbd> shows a list of all available mailboxes – should be none at this point. <br>
So to set up some mailboxes and make the mail sendable the **muttrc** must be completed like this: <br>
```sh
set folder = "imaps://mailadress@here.pl@Mailserver.information.here:993"
set smtp_url = "smtp://mailadress@here.pl@Mailserver.information.here:587"

set from = "mailadress@here.pl"
set realname = "Your Name"

set spoolfile = "+INBOX"
set record = "+Sent"
set trash = "+Trash"
set postponed = "+Drafts"

mailboxes =INBOX =Sent =Trash =Drafts =Junk  
```
The entry of your mail-password will be required as set. <br>


----

## gpg
`gpg` or `gpg2` come with basically every distro are used for basic encryption. <br>
```sh
gpg --full-gen-key #this command will initialise the process to generate a key
                   #it will be followed by a series of options

## PATH
gpg: keybox '/home/heiko/.gnupg/pubring.kbx' created

## KEY TYPE
Please select what kind of key you want:
   (1) RSA and RSA (default)
   (2) DSA and Elgamal
   (3) DSA (sign only)
   (4) RSA (sign only)
  (14) Existing key from card
Your selection? 1

## KEY SIZE
RSA keys may be between 1024 and 4096 bits long.
What keysize do you want? (3072) 4096
Requested keysize is 4096 bits

##  EXPIRATION
Please specify how long the key should be valid.
         0 = key does not expire
      <n>  = key expires in n days
      <n>w = key expires in n weeks
      <n>m = key expires in n months
      <n>y = key expires in n years
Key is valid for? (0) 0
Key does not expire at all
Is this correct? (y/N) 
```
An identity **name** and **email** must be given and a **password** will be required to protect  the key. <br>
To encrypt a file, use: `gpg -r your.mail@your-domain.com -e file` <br>
*your.mail@your-domain.com* should be the mail you specified as identifier. <br>
**file.gpg** will be cerated – **file** will remain in the directory and has to be removed manually. <br>
`gpg -d file.gpg > file` would decrypt file back in its former apperance. <br>
The entry of the former set **password** will be required to decrypt file.gpg. <br>

----

## pass
`sudo apt install pass` to install **pass**. <br>
`pass init your.mail@your-domain.com*` toinitialize a password storage. <br>
`pass add email` will add the password *email* to your password storage. <br>
`pass` or `pass ls` will list all stored passwords: 
```sh
Password Store
└── email
```
*pam-gnupg to unlock key-pair on login: https://github.com/cruegge/pam-gnupg*

## dmenu
`sudo apt install dmenu` to install **dmenu**. <br>
`man -k . | dmenu -l 30` will show a 30 lines visible list of all available manual files. As you type in your search the 30 lines will change to relevant output. <br>
*passmenu to show passwords and copy them to clipboard*

## zathura
`sudo apt install zathura` to install **zathura**. <br>

## virtualbox
Oracle® VirtualBox® [User Manual](https://www.virtualbox.org/manual/UserManual.html) <br>
**Reboot** after install and add yourself to the **vboxusers** group. <br>
Using vb is actually quite simple. This [YouTube video](https://youtu.be/D1dVhDYAv9E) gives a good overview. <br>
I'm using some Mac OS applications which are kind of mandatory for me. So my first virtualbox project was to set up a virtual mac. <br>
This [tutorial to run a mac on virtualbox](https://blog.victormendonca.com/2020/04/17/how-to-install-macos-catalina-in-virtual-box/) worked well for me. <br>
The tutorial's script comes with a nice little otion menue and finalises the setup of the virtual mac:  

```sh
#!/bin/bash

PS3='Please select the VM: '
n=0
while read line ; do
  options[n++]="$line"
done <<<"$(vboxmanage list vms | awk '{$NF=""; print $0}' | tr -d '"')"
select opt in "${options[@]}" ; do
  vm_name="$opt"
  break
done

echo "Running updates for \"${vm_name}\" VM"

vboxmanage modifyvm "$vm_name" --cpuidset 00000001 000106e5 00100800 0098e3fd bfebfbff && echo "Changed CPU ID Set" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/efi/0/Config/DmiSystemProduct" "iMac11,3" && echo "Changed DmiSystemProduct" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/efi/0/Config/DmiSystemVersion" "1.0" && echo "Changed DmiSystemVersion" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/efi/0/Config/DmiBoardProduct" "Iloveapple" && echo "Changed DmiBoardProduct" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/smc/0/Config/DeviceKey" "ourhardworkbythesewordsguardedpleasedontsteal(c)AppleComputerInc" && echo "Changed DeviceKey" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal/Devices/smc/0/Config/GetKeyFromRealSMC" 1 && echo "Changed GetKeyFromRealSMC" ; sleep .5
vboxmanage setextradata "$vm_name" "VBoxInternal2/EfiGraphicsResolution" "2560x1440" && echo "Changed resolution to 2560x1440" ; sleep .5

```

*commands can also be run individual, screen resolution should be adjusted* <br>

## surfshark vpn
Download installer from [surfshark.com](https://surfshark.com/download/linux) <br>
`sudo apt-get install {/path/to/file}` then `sudo  apt-get update` and `sudo apt-get install surfshark-vpn`. <br>
**surfshark** should be ready to go now, try `sudo surfshark-vpn`. You'll have to enter your credentials. <br>
`sudo surfshark-vpn help` will show all available command. most important are: <br>
`sudo surfshark-vpn attack` will connect you to the fastest available vpn server. <br>
`sudo surfshark-vpn status` will show the connection status of your vpn. <br>
`sudo surfshark-vpn down` will disconnect you from vpn service. <br>
I have written two functions **vpnc** and **vpnd** to cannect/disconnect sufshark. <br>
Those functions can be found in my [bash config](https://github.com/HeikoKramer/linux/blob/main/dotfiles/config.bash). <br>
They are using the [myip](https://github.com/HeikoKramer/linux/blob/main/scripts/myip) which I've – as I belive – stolen from [rwxrob](https://github.com/rwxrob/) to show the old/new public ip. <br>

## lynx
lynx is a text based webrowser. To install lynx type `sudo apt install lynx -y` <br>.
Check out the lynx config: `vim /etc/lynx/lynx.cfg` <br>
It has close to 4000 lines and the [official lynx user guide](https://lynx.invisible-island.net/release/lynx_help/Lynx_users_guide.html) also ain't lean … <br>
Those lynx folks are text-savy for sure. <br>
Typing `lynx` opens a a kind of offensive colored **About Lynx** page, not very inviting, but let's check it out. <br>
There are atually two files in `cd /etc/lynx/` **lynx.cfg** and **lynx.lss**. <br>
**config**: `sudo vim /etc/lynx/lynx.cfg` **colors**: `sudo vim /etc/lynx/lynx.lss`. <br>
Whatched [rob's video on lynx](https://youtu.be/Vdd2MTv6vrs) and just copied his [lynx.lss](https://github.com/rwxrob/dotfiles/blob/master/common/lynx/lynx.lss) – the colors are much better now. <br>
### navigation in lynx
So by default the **arrow keys** are used to navigate. <br>
<kbd>down</kbd> moves **down/right**, <kbd>up</kbd> moves **up/left**. The cursor jumps from link to link. <br>
<kbd>right</kbd> to **follow a link**. <kbd>left</kbd> to **go back** to the last page. <br>
<kbd>h</kbd> the lynx **help** is as rich and well documented as everything so far. <br>
<kbd>/</kbd> to **search**, <kbd>q</kbd> to **quit**. <br>
<kbd>o</kbd> the **options** menu is most interesting. Here you can change those settings which are also managed in **lynx.cfg** I guess. <br>
I've managed to save my changes by checking **Save options to disk** and click <kbd>left</kbd> on **Accept Changes**. <br>
Colors swapped back to the default after that, but it looks like my changes were saved. <br>
I've activated **vim** keybindings and to **auto-accept cookies**. <br>  
**vim** keybindings have the disadvantage that you start entering jjjjjj and stuff as soon as you hit some entry field. <br>


## ansible
### getting started with ansible – prerequisite ssh 
Notes while following the [LLTV](https://youtu.be/-Q4T9wLsvOQ) ansible tutorial series <br>
`sudo apt install openssh-server` on the remote client 
