# VIM

## Installing Vim
`sudo apt install vim` on Debian based Linux distros, `brew install vim` on Mac OS. <br>

## Starting Vim
`vim example.md` will open example.md positioning the cursor at the start of the file. <br>
Add the following line to your **.vimrc** to ensure Vim opens each file with the cursor positioned at the last edited line: <br>
`au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif` <br>
`vim example.md +33` will open example.md with cursor positioned at line 33. `vim +33 example.md` works as well.<br>
`vim +/Pinguine example.md` opens example.md at the first appearance of the pattern **Pinguine**. <br>
It's functioning like a regular search, so pressing the <kbd>n</kbd> key will jump to the next pattern-match. <br>
`vim example.md +"152d|x"` will delete line 152 of example.md and close the file before you even realize it has been opened. <br>
`vim example.md +"152d"` will delete line 152 and leave the file open. <kbd>u</kbd> to undo the deletion will work in that case.<br>

## Command types
There are three types of commands in vim: <br>
**Ex commands** like `:set nonu` to deactivate line numbers or `:set nu` to switch them back on again. <br>
`:help ex-cmd-index` will show the entire list of ex commands. <br>
**Mapped commands** are more complex commands which are mapped ore bind to keys for easier access. <br>
Those commands are usually added to your **.vimrc** file. <br>
**Editing Commands** are usually used in **normal** or **insert** mode – like `d4w` to *delete four words*. <br>

## Opening files
`vim filename` to open the file *filename* in vim. <br>
`vim` to open vim and then `:e filename` to open *filename* from vim. <br> 

## Close & save files / exiting Vim
Vim has different modes in which it is operating. <br>
To ensure you're in the **normal** mode – from which you can exit – press <kbd>ESC</kbd> <br>
Type <kbd>:</kbd> then <kbd>q</kbd> then <kbd>!</kbd> and hit <kbd>ENTER</kbd> to exit Vim without saving. <br>
Type <kbd>:</kbd> then <kbd>w</kbd> then <kbd>q</kbd> and hit <kbd>ENTER</kbd> to save and exit. <br>
Type <kbd>:</kbd> then <kbd>w</kbd> and hit <kbd>ENTER</kbd> to save without exiting. <br>
`:w example.md` to save file as example.md – `:w! example.md` to overwrite if example.md already exists. <br>
Type <kbd>:</kbd> then <kbd>x</kbd> and hit <kbd>ENTER</kbd> to leave vim and save (only if file has been changed). <br>
<kbd>Z</kbd> <kbd>Z</kbd> is another way to quit Vim from **normal** mode with saving the file. <br>

## Navigation in Vim
To move the cursor use the h,j,k,l keys in the middle of the keyboard. <br>
<kbd>k</kbd> The k key moves up. <br>
<kbd>j</kbd> The j key moves down. <br>
<kbd>h</kbd> The h key moves left. <br>
<kbd>l</kbd> The l key moves right. <br>
<kbd>6</kbd> <kbd>j</kbd> will move you six lines down, <kbd>6</kbd> <kbd>k</kbd> six lines up. <br>
<kbd>22</kbd> <kbd>h</kbd> will move you 22 cursor positions left, <kbd>22</kbd> <kbd>l</kbd> 22 positions right. <br>
<kbd>0</kbd> then <kbd>ENTER</kbd> will bring you to the start of the line. <br>
<kbd>$</kbd> then <kbd>ENTER</kbd> will bring you to the end of the line. <br>
<kbd>}</kbd> then <kbd>ENTER</kbd> will bring you to the next empty line after a block of text. <br>
<kbd>{</kbd> then <kbd>ENTER</kbd> will bring you to the next empty line before a block of text. <br>
A number then <kbd>w</kbd> will jump number of words forward (2w will jump two words). <br>
<kbd>3</kbd> then <kbd>e</kbd> will jump to the end of the third word from where the cursor is. <br>
<kbd>CTRL</kbd> <kbd>g</kbd> will show your position in the document. <br>
Jump to document start by typing <kbd>g</kbd> <kbd>g</kbd>. <br>
Type <kbd>G</kbd> to jump to to the file bottom. <br>
`50%` <kbd>ENTER</kbd> will bring you to the middle of the document. <br>
<kbd>%</kbd> over any kind of bracket will flip cursor to the matching part. <br>
<kbd>4</kbd> <kbd>2</kbd> <kbd>G</kbd> will bring you to line 42. <br>
<kbd>4</kbd> <kbd>2</kbd> <kbd>g</kbd> <kbd>g</kbd> will bring you to line 42. <br>
<kbd>:</kbd> <kbd>4</kbd> <kbd>2</kbd> will bring you to line 42. <br>
<kbd>g</kbd> <kbd>j</kbd> moves down to a blank line (only <kbd>j</kbd> skips those lines). <br>
Capital <kbd>W</kbd> and <kbd>B</kbd> move you word by word - but don't count brackets and stuff as words like <kbd>w</kbd> and <kbd>b</kbd> do. <br>
<kbd>f</kbd> + letter takes you to the next appearance of that letter in this line. <br>
<kbd>F</kbd> + letter takes you to the last appearance of that letter in this line. <br>
<kbd>CTRL</kbd> <kbd>f</kbd> for page down. <kbd>CTRL</kbd> <kbd>b</kbd> for page up. <br>

## The read command
When we want to get content from an other file into our currently open file, we are **loading it into Vim's buffer**. <br>
A command to do that is the **read** command – `:read` or the short form `:r`. <br>
`:r example.md` will insert full content of example.md below the cursor. <br>
`:30r example.md` will insert full content of example.md below line 30. <br>
`:0r example.md` will insert full content of example.md before line 1. <br>
`:31r!sed -n 56,62p ~/test/example.md` will combine **read** and **sed** to insert line 56-62 from example.md below line 31 in current buffer. <br>
You can load any command output into buffer that way: `r!ls ~/test` to list files from the text directory or `r!man man` to load the whole *man* manpage. <br> 
<kbd>:</kbd> then `read !echo "Hello"` would print "Hello" at the cursors position. <br>
Or <kbd>:</kbd> `read !ps aux` would paste a list of running processes into the file. <br>
*This doesn't only work with standard commands, but also with any executable or exported functions.* <br>

## Executing Code in Vim
If you have a code block of **bash** in your document, and you want to see the outcome of it, press <kbd>!</kbd> <kbd>}</kbd>. It get's translated into an x-command and when you now type "bash" and hit <kbd>ENTER</kbd>, the code block will get replaced with its actual output. <br>

## Search
To search for type <kbd>/</kbd> then any phrase then <kbd>ENTER</kbd>. <br>
<kbd>n</kbd> jumps down to the next search hit, <kbd>N</kbd> jumps up. <br>
You can start a search with <kbd>?</kbd> as well – <kbd>n</kbd> and <kbd>N</kbd> move in the opposite direction then. <br>
<kbd>CTRL</kbd> <kbd>o</kbd> will bring you back to where you started the search. <br>
<kbd>CTRL</kbd> <kbd>i</kbd> will jump back to next cursor position. <br>
Press <kbd>\*</kbd> in **normal** mode to search forwards for the word under the cursor. <br>
Press <kbd>\#</kbd> in **normal** mode to search backwards for the word under the cursor. <br>
`*` and `#` will only search for the exact pattern. If the cursor is on the word **for** and you also want to find **forwards**, type <kbd>g</kbd> <kbd>\*</kbd> or <kbd>g</kbd> <kbd>\#</kbd>. <br>
`5*` will jump to the 5th occurrence of the word under the cursor. <br>
If you want to edit the word under the cursor before editing, press <kbd>/</kbd> then <kbd>CTRL</kbd> <kbd>r</kbd> then <kbd>CTRL</kbd> <kbd>w</kbd>. <br>
`:set ic` will ignore case sensitivity. <br>
A search for `/ignore` will show ignore, IGNORE or Ignore than. <br>
If you want to ignore case sensitivity for just one search type `/ignore\c`. <br>
`:set hls is` will activate search highlighting. <br>
`:nohlsearch` or short `:noh` will deactivate it. <br>
`:no` + command will disable all `:set` commands. <br>
**Match a string** <br>
A command close search to search is **match** – if you'd like to highlight the patter **something**, type `:match ErrorMsg /something/`. <br>
The highlight color depends on your color scheme, try: `ErrorMsg`, `WarningMsg`, `ModeMsg` or `MoreMsg`. <br>

## Search multiple files
To search for the pattern **maker** within all files in your working directory, type `:vimgrep maker *` <br>
Use `:clist` to get a list of all files containing that pattern. `cc 2` jumps to the 2nd second list entry. <br>
Jump to the next match with `:cn` or to the previous with `:cN` <br>

## The global command
`:g/bla/d` deletes all lines in the document that contain *bla* with. <br>
`:g!/bla/d` deletes all lines in the document that do **not** contain *bla* with. <br>
`:g/^\s*$/d` deletes all blank lines in current file. <br>

## Replace
**Substitue flags**: `c` **c**onfirm, `g` all occurrences in line, `i` **i**gnore case, `I` don't ignore case <br>
`:s/thee/the` will replace the **first** *thee* **in the line** with *the*. <br>
`:s/thee/the/g` will replace all *thee* **in the line** with *the*. <br>
`:%s/thee/the/g` will replace **all** *thee* in the file with *the*. <br>
`:%s/thee/the/gc` finds all *thee* in the file and **gives y/n option for each** to replace with *the*. <br>
`:545,555s/bold/old/g` will replace all *bold* with *old* in **between line 545 and 555**. <br>
`:23s/one/two/g` will replace all *one* with *two* **in line 23**. <br>
`:23s/one/two/g` will replace all *one*, *ONE*, *One*, *oNe* and so on with *two* **in line 23**. <br>
`:23,$s/one/two/g` will replace all *one* with *two* **from line 23 until the end of the document**. <br>
`:?start?,/end/s/bla/blubb/g` replaces all *bla* with *blubb* between pattern **start** and **end** <br>
<br>
**NOTE:** The shown examples will replace the search pattern wherever they find it! <br>
Example: Let's change the string "Game of thrones season one" to "Game of thrones season two". <br>
`:s/one/two/g` will do the trick, right? Unfortunately the outcome will be: Game of thr**two**s season two. <br>
To **replace only whole words** you have to tag them: `:s/\<one\>/two/g` will replace *one* with *two* and leave thr**one**s as it is. <br> 
<br>
You can also **replace multiple pattern** with the same string in only one go: <br>
Let's say our line is "Replace this and that with some variables." and we want to replace **this** and **that** with some identical variable … <br>
The command `:s/\(this\|that\)/\{!object.field\}/g` would result in "Replace {!object.field} and {!object.field} with some variables." <br>

## Delete
Press <kbd>x</kbd> in **normal** mode to delete the character under the cursor and continue left. <br>
<kbd>X</kbd> to delete the character under the cursor and continue right. <br>
So if the cursor is on **m** in **example**, <kbd>x</kbd> <kbd>x</kbd> will result in **exale**, <kbd>X</kbd> <kbd>X</kbd> in **emple**. <br>
<kbd>s</kbd> deletes the character under the cursor like <kbd>x</kbd>, but it leaves you in **insert** mode afterwards. <br>
Park the cursor on the first letter of a word you'd like to **delete** and press <kbd>d</kbd> then <kbd>w</kbd>. <br>
The <kbd>e</kbd> instead of the <kbd>w</kbd> to leave the space after the word. <br>
Press <kbd>d</kbd> then <kbd>$</kbd> then <kbd>ENTER</kbd> to delete from where your cursor is to the end of the line. <br>
<kbd>d</kbd> <kbd>d</kbd> deletes the whole line. <br>
<kbd>3</kbd> <kbd>d</kbd> <kbd>d</kbd> deletes three lines. <br>
<kbd>d</kbd> <kbd>3</kbd> <kbd>w</kbd> will delete the word under the cursor plus the next two words. <br>
<kbd>3</kbd> <kbd>d</kbd> <kbd>d</kbd> deletes the line where cursor is plus the next two lines. <br>
<kbd>D</kbd> deletes from cursor position to the end of the line. <kbd>d</kbd> <kbd>$</kbd> does the same. <br>
When you're in line 15 ant type <kbd>d</kbd> <kbd>:</kbd> <kbd>3</kbd> <kbd>0</kbd> <kbd>ENTER</kbd> 15 lines (15-30) will be deleted. <br>
<kbd>d</kbd> <kbd>}</kbd> will delete a whole block to the next empty line below, <kbd>d</kbd> <kbd>{</kbd> above the cursor. <br>
You can delete un**t**il something by adding the **t** modifier: <kbd>d</kbd> <kbd>t</kbd> <kbd>?</kbd> deletes everything from the cursor's position un**t**il the next question mark. <br>

## Until pattern
Interesting on VimTricks: [Operate until pattern](https://vimtricks.com/p/vimtrick-operate-until-pattern/) <br>
To try out those methods I've created a test file repeating the sentence: <br>
```sh
This is a text test to test some vim stuff 12345 blablabla great test file.
```

**until single character** <br>
So `dtt` deletes everything in the line until the first **t**:<br>
*text test to test some vim stuff 12345 blablabla great test file.* <br>
`ctt` does the same, but leaves you in **insert** mode before the word test.<br>
`yt1` copies everything until the first **1**. So with our sentence <kbd>p</kbd> gives you: <br>
*This is a text test to test some vim stuff* <br>
<br>
**until pattern** <br>
`d/test` <kbd>enter</kbd> deletes everything until the first **test**: <br>
*test to test some vim stuff 12345 blablabla great test file.* <br>
`c/test some` <kbd>enter</kbd> deletes everything until the **test some** and leaves you in **insert** mode before **test**: <br>
*test some vim stuff 12345 blablabla great test file.* <br>
So in this example we have skipped the first **test** by given the command the pattern of the second **test** which is followed by **some**. <br>
To write out **some** is not really necessary, `c/test s` <kbd>enter</kbd> would do the job just as well. <br>
`y/stuff` <kbd>enter</kbd> copies everything until **stuff**: <br>
*This is a text test to test some vim* <br>

## Change inside
**Change inside quotes** <br>
Write this sentence in a Vim file: Vim is the most "complicated" editor in the galaxy. <br> 
Place the cursor somewhere before the word *complicated* in that line and type <kbd>c</kbd> <kbd>i</kbd> <kbd>"</kbd> then type the word *powerful* and hit <kbd>ESC</kbd>. <br>
**Change inside tags** <br>
To change the content within tags like `<h1>Super cool title here</h1>`, press <kbd>c</kbd> <kbd>i</kbd> <kbd>t</kbd> somewhere in the line to get `<h1></h1>` and the cursor within, ready to insert new content. <br>
**Change inside sentence** <br>
<kbd>c</kbd> <kbd>i</kbd> <kbd>s</kbd> within a block of text, will delete all words between punctuation characters. <br> 
**Example:** This is a sentence. Is this another one? Of course it is! <br> 
Type <kbd>c</kbd> <kbd>i</kbd> <kbd>s</kbd> while the cursor is on **another** to delete *Is this another one?* and leave *This is a sentence.  Of course it is!* with the cursor before **Of** and in **insert** mode. <br>
<kbd>c</kbd> <kbd>i</kbd> <kbd>p</kbd> for **change inside paragraph** will delete a whole block of text between two empty lines. <br>
<kbd>c</kbd> <kbd>i</kbd> <kbd>w</kbd> for **change inside word** is a bit useless as <kbd>c</kbd> <kbd>w</kbd> or <kbd>c</kbd> <kbd>e</kbd> will do the same with one keystroke less. <br>
It actually makes sense when the cursor is positioned in the middle of a long word you'd like to change, as those other commands require the cursor to be positioned at the beginning of the word. <br>
<kbd>c</kbd> <kbd>i</kbd> <kbd>(</kbd> or <kbd>c</kbd> <kbd>i</kbd> <kbd>{</kbd> or <kbd>c</kbd> <kbd>i</kbd> <kbd>[</kbd> work as well, but the cursor has to be positioned on the **(, {, [** when entering the command. <br>

## Copy, cut and paste
Good summary: https://vim.fandom.com/wiki/Copy,_cut_and_paste
There is no ctrl+x style cut and paste in Vim --> because it keeps the last deleted line in the cache. So to cut and past just delete whatever you want to cut and it is ready to be pasted. The so called cut command is not really for pasting, it is good for deleting and change into edit mode at the same time.
<kbd>p</kbd> the put command can be used to place prior deleted lines or words at cursor position. <br>
<kbd>2</kbd> <kbd>p</kbd> will paste the prior deleted string two times. <br>
`y7w` will copy seven works from the cursors position. <br>
`2y` will copy two lines from the cursors position. <br>
`y$` will copy from cursor to the end `y0` to beginning of the line. <br>

## Ways to change into insert mode
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
<kbd>I</kbd> will start **insert** mode at the beginning of the line. <br>
While in **insert** mode press <kbd>CTRL</kbd> <kbd>o</kbd> to execute one **normal** mode command before switching back into **insert**.

## Undo, redo
<kbd>u</kbd> will undo the last change, the next <kbd>u</kbd> undoes the prior change and so on … <br>
<kbd>U</kbd> will undo all changes on the last edited line. <br>
<kbd>CTRL</kbd> + <kbd>r</kbd> redoes the changes if you undid something by mistake. <br>
Redo doesn't work after capital <kbd>U</kbd>. <br>
<kbd>R</kbd> will enter **replace** mode where you can override everything under the cursor. <br>
<kbd>5</kbd> <kbd>u</kbd> will undo the last five operations. <br>
Use the `:earlier` command (short `:ea`) to set your document back to a state it had a specific time ago: <br>
`:earlier 3d` or `:ea 3d` will show how your doc looked **3 days** ago. <br>
`:ea 3h` will set it back **3 hours**, `:ea 3m` **3 minutes**, `:ea 30s` **30 seconds**. <br>
Go back forward in time with the `:later` (short `:lat`) command. <br>
Use `:ea 10` or `lat 10` without a time option to **undo/redo** the ten last edits. <br>
Additional to the time options there is **f** – for **file** state – which counts every time you saved. <br>
`:ea 3f` undoes all changes since the last **3x you saved**, `:lat 3f` redoes all that. <br>
**Undo branches:** When you use undo/redo operations, Vim will create a branch at any undo point. <br>
You can switch between branches by typing `g-` or `g+`. <br>
**Persistent undo:** the undo command <kbd>u</kbd> is usually restricted to the current session. <br>
You can activate session overarching undo by adding `set undofile` in your **.vimrc** <br>
Vim will create a hidden **undofile** for each edited file in the directory where that file is located. <br>
You can specify a storage location for those files in your **.vimrc**, like I have here: `set undodir=~/.vim/undo`. <br>

## The Dot
<kbd>.</kbd> will repeat the last used command. So if you typed <kbd>d</kbd> <kbd>w</kbd> to deleted a word, you only need to press <kbd>.</kbd> to continue deleting word by word. <br>
The dot can also be used to repeat more complex operations like the change of a word: <br>
If you press <kbd>c</kbd> <kbd>e</kbd> on the word "bank" and replace it with "financial institution", then exit insert mode with <kbd>ESC</kbd> and press <kbd>n</kbd>, your cursor will jump to the next appearance of the word "bank". A press on <kbd>.</kbd> will then repeat the change and replace it with "financial institution". That way you can jump from "bank" to "bank" by pressing <kbd>n</kbd> and change those where it is required. <br>
To out-commend a line of bash code, press <kbd>0</kbd> <kbd>i</kbd> <kbd>#</kbd> – this can be repeated at each following line to quickly commend a block of text. <br>

## Indentation
<kbd>\></kbd> <kbd>\></kbd> in **normal** mode to indent a line. <br>
<kbd>\<</kbd> <kbd>\<</kbd> to take that line back. <br>
<kbd>5</kbd> <kbd>\></kbd> <kbd>\></kbd> to indent five lines from the cursors position. <br>

## Command & Visual mode
<kbd>:</kbd> <kbd>!</kbd> will set Vim in the mode to execute any external command. <br>
`:!ls` will for example show a list of the current directory. <br>
`:w filename` will save a copy of the edited file with name *filename*. <br>
<kbd>v</kbd> brings you in **visual** mode. All moves you make in visual mode mark the text you're passing by. <br>
You can use commands like <kbd>d</kbd> to delete the selected text or press <kbd>:</kbd> for external commands. <br>
`:w TEST` will for example write the selected text into a file named *TEST*. <br>
The command promt looks a bit different in **visual** mode, the above will appear like `:'<,'>w TEST`. <br>
`:r TEST` will insert the content of TEST at the cursor position. <br>
Outputs of external commands can be inserted as well, example: `:r !ls`. <br>
<kbd>v</kbd> for **visual** mode and then <kbd>y</kbd> will copy all marked text. <br>
If `:e` is entered - or any other first letter - and <kbd>CTRL</kbd> + <kbd>d</kbd> is pressed the all command starting wit **e** will show. <br>
### Visual Block
If you have some table-like formatted text/code with vertical aligned strings of identical size, you can use **visual block** to edit them simultaneously. <br>
Bring the cursor to the first entry you'd like to edit, press <kbd>CTRL</kbd> <kbd>v</kbd> to enter **visual block** mode. <br>
Press <kbd>l</kbd> till the string is fully selected, then start pressing <kbd>j</kbd> to mark the same areal in as many lines below as you like. <br>
When all lines are selected press <kbd>c</kbd> to **change**, enter the new text, press <kbd>ESC</kbd> and that change will apply to all selected lines. <br>
This method works as well with <kbd>d</kbd> for **delete** or <kbd>y</kbd> for **yank**. <br>

## Case folding
<kbd>~</kbd> in **normal** mode changes the case of the letter under the cursor. <br>

## Vim tricks – magic wand
<kbd>!</kbd> <kbd>!</kbd> to enter a mode in which Vim accepts any command / function as input and writes its output at the cursors position. <br>
*Functions should be exported to be available in Vim!* <br>

## Cursor position visualisation
`:set cul` activates **cursor line** – a horizontal line indicator for the cursor position. <br> 
`:set cuc` activates **cursor column** – a vertical line indicator for the cursor position. <br>
`:set nocul` or `:set nocuc` for to deactivate those indicators. <br>
The styling of the cursor line can be set, example: `:highlight CursorLine guibg=lightblue ctermbg=lightgrey` <br>

## Spellchecking
`:set spell` to activate **spellchecking** in default language. `:set nospell` to deactivate it. <br>
Use this command to set the default language `:set spell spelllang=en_us` – add it to your **.vimrc** to set it permanent<br>
When turned on, miss-spelled word will be highlighted like search results. <br>
<kbd>\]</kbd> <kbd>s</kbd> to jump forwards through those results, <kbd>\[</kbd> <kbd>s</kbd> does the same backwards. <br>
<kbd>z</kbd> <kbd>=</kbd> will provide a list with spelling recommendations. <br> 
You can type the list index number and <kbd>ENTER</kbd> and Vim will replace the word with your selection. <br>
Just hit <kbd>ENTER</kbd> if no suggestion is matching to leave the listing page. <br>
If Vim is marking correct spelled word as incorrect type <kbd>z</kbd> <kbd>g</kbd> to add that word to the dictionary. <br>
You can as well mark a word as incorrect by using <kbd>z</kbd> <kbd>w</kbd> <br>
Good link on spellchecking: [linux.com](https://www.linux.com/training-tutorials/using-spell-checking-vim/) <br>

## netrw – the Vim file manager
`:Ex` opens current directory with horizontal screen split (same as `:Sex`). <br>
`:Vex` opens current directory in vertical split – directory left (same as `:Lex`). <br>
*I've tried :Rex but it didn't work. The book says :Vex would open directories on the right .. but for me :Lex and :Vex look exactly the same (left)* <br>
`:Ex ~/repos/` opens **repos** directory. <br>
`:Tex` opens current directory in new window. <br>
There are different list viewing options available. Press <kbd>i</kbd> within the list view to change to the next one. <br>
`:q` will bring you back to full screen document mode. <br>
<kbd>D</kbd> in list mode to **delete** the file under the cursor, <kbd>R</kbd> to **rename** and <kbd>X</kbd> to **execute** it . <br>
To create a new file press <kbd>%</kbd> – Vim will open an other editor in the split screen then. `:wq` will save that file and return to full screen. <br>

## Vim config
The line **au bufnewfile,bufRead *filename* set filetype=sh** added in Vim config will make vim interprets the file *filename* as a bash file. <br>
`:set nu` show line numbers in vim. `set nonu` hides them. <br>
`:so %` reloads the file without closing it (to source a file) <br>
`:set list` shows you spaces tabs and stuff. `:set nolist` to turn it off. <br>
`:set cursorline` or `:set cul` to show a line under current cursor position. `nocursorline` or `nocul` to switch it off. <br>

## Vim version
`:version` will show you the installed version and options of Vim – options marked with a **+** are installed those with **-** ain't.<br


## Vim resources
**vimtutor** command to open an in vim integrated tutorial <br>
[rwxrob magic wands](https://rwx.gg/vi-magic-wands/) <br>
[vimgenius](https://vimgenius.com) <br>
[learn vim progressively](https://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/) <br>
