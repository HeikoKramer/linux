syntax on


" NUMBER SETTINGS 
" turn on line numbers
set number
" start vim with relative line numbers by default
set relativenumber
" switch to absolut line numbers when entering insert mode
autocmd InsertEnter * :setlocal norelativenumber
" switch back to relative line numbers when leaving insert mode
autocmd InsertLeave * :setlocal relativenumber


" set ruler " ruler is the bar at the bottom and it is on by default
set wildmenu " shows command tab-completion options as a selectable menue
set showcmd
set title " shows filename in the window top bar
" set spell " spellchecking enabled by default
set lazyredraw " prevents vim from redrawing the screen after every macro execution
" tabs and indentation
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smartindent
set smarttab


" HIGHLIGHTING
" will highlight all matches :noh will turn it off
set hlsearch 
set incsearch

set linebreak
 
set history=100
filetype plugin on  " allow sensing the filetype
set formatoptions+=c
set listchars=tab:→\ ,eol:↲,nbsp:␣,space:·,trail:·,extends:⟩,precedes:⟨

set shortmess=aoOtI " avoid most 'Hit Enter …' messages
set viminfo='20,<1000,s1000

set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undo " sets undo directory to store undofile (below)
set undofile " activates persistent undos indipendent from session
set icon " terminal title -> filename

set scrolloff=999 " keeps cursor in the middle of the screen

" start at last place you were editing
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"au BufWritePost ~/.vimrc so ~/.vimrc


" MAPPINGS

" CONFIG OPENING MAPPINGS
" open vimrc by entering – vc
noremap vc :e ~/.vimrc<cr>
" open bash config by entering – bc
noremap bc :e ~/.remote_bash<cr>
" open tmux config by entering – tc
noremap tc :e ~/.tmux.conf<cr>

" NUMBER SETTINGS MAPPINGS
" switch on relative line numbers by entering – rl
noremap rl :set relativenumber<cr>
" switch off relative line numbers by entering – nr
noremap nr :set norelativenumber<cr> 
" switch on numbers by entering – nu
noremap nu :set nu<cr>
" switch off numbers by entering – nn
noremap nn :set nonu<cr>

" VISUAL MODE KEYBINDINGS
" makes dot command work in visual mode without tying the usually needed full command
vnoremap . :norm.<CR> 
" makes visual selected lines move down one line when pressing J 
vnoremap J :m '>+1<CR>gv=gv 
" makes visual selected lines move up one line when pressing K 
vnoremap K :m '<-2<CR>gv=gv

" BUFFER NAVIGATION
" jump back and forward through your open buffers by pressing ctrl-h and ctrl-l
noremap <C-H> :bprev<CR>
noremap <C-L> :bnext<CR>
" close window with current buffer (buffer delete)
noremap <C-D> :bd<CR>

" KEY MAPPINGS
" disable arrow keys (vi muscle memory)
noremap <up> :echoerr "Umm, use k instead"<CR>
noremap <down> :echoerr "Umm, use j instead"<CR>
noremap <left> :echoerr "Umm, use h instead"<CR>
noremap <right> :echoerr "Umm, use l instead"<CR>

" SPELL CHECKING MAPPINGS
" activate spell checking by typing – ss
noremap ss :set spell<cr>
" deactivate spell checking by typing – ns
noremap ns :set nospell<cr>
" jump back to last miss-spelled word by pressing – ctrl-s
noremap <C-S> :norm [s<cr>
" enter list of spelling suggestions by pressing – ctrl-z
noremap <C-Z> :norm z=<cr>
" ignore word and add to dictionary by pressing – ctrl-i
noremap <C-I> :norm zg<cr>

" MISC COMMAND MAPPINGS
" stop highlighting search pattern by pressing – ctrl-x
nmap <C-X> :noh<cr>

" ALL AVAILABLE DEFAULT COLORSCHEMES
" blue       default    desert     evening    koehler    murphy     peachpuff  shine      torte
" darkblue   delek      elflord    industry   morning    pablo      ron        slate      zellner
" FAVOURITES: koehler, delek, peachpuff, slate, zellner
colorscheme koehler

" NEOVIM SPECIFIC CONFIGS
if has('nvim') 
  set laststatus=0 noshowmode noruler
endif
