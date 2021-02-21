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
`vim example.md +"152d"` will delete line 152 and leave the file open. <kbd>u</kbd> to undo the delition will work in that case.<br>

## the dot
<kbd>.</kbd> will repeat the last used command. So if you typed <kbd>d</kbd> <kbd>w</kbd> to delted a word, you only need to press <kbd>.</kbd> to continue deleting word by word. <br>
The dot can also be used to repeat more complex operations like the change of a word: <br>
If you press <kbd>c</kbd> <kbd>e</kbd> on the word "bank" and replace it with "financial institution", then exit insert mode with <kbd>ESC</kbd> and press <kbd>n</kbd>, your cursor will jumt to the next appearence of the word "bank". A press on <kbd>.</kbd> will then repeat the change and replace it with "financial institution". That way you can jump from "bank" to "bank" by pressing <kbd>n</kbd> and change those where it is required. <br>
To out-commend a line of bash code, press <kbd>0</kbd> <kbd>i</kbd> <kbd>#</kbd> – this can be repeated at each following line to quickly commend a block of text. <br>

## Vim config
The line **au bufnewfile,bufRead *filename* set filetype=sh** added in Vim config will make vim interprete the file *filename* as a bash file. <br>
`:set nu` show line numbers in vim. `set nonu` hides them. <br>
`:so %` reloads the file without closing it (to source a file) <br>
`:set list` shows you spaces tabs and stuff. `:set nolist` to turn it off. <br>
`:set cursorline` or `:set cul` to show a line under current cursor position. `nocursorline` or `nocul` to switch it off. <br>

## Vim ressources
**vimtutor** command to open an in vim integrated tutorial <br>
https://rwx.gg/vi-magic-wands/ <br>
https://vimgenius.com <br>
https://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/ <br>

## Navigation in Vim
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

## Exiting Vim
Vim has different modes in which it is operating. <br>
To ensure you're in the **Normal** mode - from which you can exit - press <kbd>ESC</kbd> <br>
Type <kbd>:</kbd> then <kbd>q</kbd> then <kbd>!</kbd> and hit <kbd>ENTER</kbd> to exit Vim without saving. <br>
Type <kbd>:</kbd> then <kbd>w</kbd> then <kbd>q</kbd> and hit <kbd>ENTER</kbd> to save and exit. <br>
Type <kbd>:</kbd> then <kbd>w</kbd> and hit <kbd>ENTER</kbd> to save without exiting. <br>
<kbd>Z</kbd> <kbd>Z</kbd> is a way to quit Vim from **normal** mode with saving the file. <br>

## Delete
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

## Copy, cut and paste
Good summary: https://vim.fandom.com/wiki/Copy,_cut_and_paste
There is no ctrl+x style cut and paste in Vim --> because it keeps the last deleted line in the cache. So to cut and past just delete whatever you want to cut and it is ready to be pasted. The so called cut command is not really for pasting, it is good for deleting and change into edit mode at the same time.
<kbd>p</kbd> the put command can be used to place prior deleted lines or words at cursor position. <br>
<kbd>2</kbd> <kbd>p</kbd> will paste the prior delted string two times. <br>
`y7w` will copy seven works from the cursors position. <br>
`2y` will copy two lines from the cursors position. <br>
`y$` will copy from cursor to the end `y0` to beginning of the line. <br>

## Insert mode text editing
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

## Undo, redo
<kbd>u</kbd> will undo the last change, the next <kbd>u</kbd> undos the prior change and so on … <br>
while <kbd>U</kbd> will undo all changes on the last edited line. <br>
<kbd>CTRL</kbd> + <kbd>r</kbd> redos the chages if you undid something by mistake. <br>
Redo doesn't work after capital <kbd>U</kbd>. <br>
<kbd>R</kbd> will enter **replace** mode where you can override everything under the cursor. <br>
<kbd>5</kbd> <kbd>u</kbd> will undo the last five operations. <br>

## Search
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

## Replace
`:s/thee/the` will replace the firtst thee in the line with the. <br>
`:s/thee/the/g` will replace all thee in the line. <br>
`:%s/thee/the/g` will replace all thee in the file. <br>
`:%s/thee/the/gc` finds all thee in the file and gives options replace y/n <br>
`545,555s/bold/old/g` will replace all bold with old in between line 545 and 555. <br>

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
The command promt looks a bit different in **visual** mode, the above will apper like `:'<,'>w TEST`. <br>
`:r TEST` will insert the content of TEST at the cursor position. <br>
Outputs of external commands can be inserted as well, example: `:r !ls`. <br>
<kbd>v</kbd> for **visual** mode and then <kbd>y</kbd> will copy all marked text. <br>
If `:e` is entered - or any other first letter - and <kbd>CTRL</kbd> + <kbd>d</kbd> is pressed the all command starting wit **e** will show. <br>

## Executing Code in Vim
<kbd>:</kbd> then `read !echo "Hello"` would print "Hello" at the cursors position. <br>
Or <kbd>:</kbd> `read !ps aux` would paste a list of running processes into the file. <br>
If you have a code block of **bash** in your document, and you want to see the outcome of it, press <kbd>!</kbd> <kbd>}</kbd>. It get's translated into an x-command and when you now typ "bash" and hit <kbd>ENTER</kbd>, the code block will get replaced with its actual output. <br>

## Case folding
<kbd>~</kbd> in **normal** mode changes the case of the letter under the cursor. <br>

## Vim tricks – magic wand
<kbd>!</kbd> <kbd>!</kbd> to enter a mode in which Vim accepts any command / function as input and writes its output at the cursors position. <br>
*Functions should be exported to be available in Vim!* <br>

## misc
`:set cuc` activates vim's **cursor column** – a vertical line indicator for the cursor position. <br>
Interesting on VimTricks: [Operate until pattern](https://vimtricks.com/p/vimtrick-operate-until-pattern/) <br>
To try out those methods I've created a test file repeting the sentence: <br>
```sh
This is a text test to test some vim stuff 12345 blablabla great test file.
```

**until single character**
So `dtt` deletes everything in the line until the first **t**:<br>
*text test to test some vim stuff 12345 blablabla great test file.* <br>
`ctt` does the same, but leaves you in **insert** mode before the word test.<br>
`yt1` copys everything until the first **1**. So with our sentence <kbd>p</kbd> gives you: <br>
*This is a text test to test some vim stuff* <br>
<br>
**until pattern**
`d/test` <kbd>enter</kbd> delets everything until the first **test**: <br>
*test to test some vim stuff 12345 blablabla great test file.* <br>
`c/test some` <kbd>enter</kbd> delets everything until the **test some** and leaves you in **insert** mode before **test**: <br>
*test some vim stuff 12345 blablabla great test file.* <br>
So in this example we have skipped the first **test** by given the command the pattern of the second **test** which is followed by **some**. <br>
To write out **some** is not really necessary, `c/test s` <kbd>enter</kbd> would do the job just as well. <br>
`y/stuff` <kbd>enter</kbd> copies everything untill **stuff**: <br>
*This is a text test to test some vim* <br>
