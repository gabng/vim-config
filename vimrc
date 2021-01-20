" .vimrc settings

" Use vim settings, rather then vi settings
" This must be first, because it changes other options as a side effect
set nocompatible

let mapleader=" "   " Change the mapleader from \ to space

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off

" set the runtime path to include Vundle and initialize
if has('win32') || has('win64')
    set rtp+=~/vimfiles/bundle/Vundle.vim
    call vundle#begin('~/vimfiles/bundle')
else
    set rtp+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
endif

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-fugitive'
Plugin 'hari-rangarajan/CCTree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
"Plugin 'ervandew/supertab'
Plugin 'majutsushi/tagbar'
Plugin 'Valloric/ListToggle'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'kien/ctrlp.vim'
Plugin 'bling/vim-airline'
Plugin 'mhinz/vim-signify'
Plugin 'mfukar/robotframework-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'pboettch/vim-cmake-syntax'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set vim file access encodings
" See http://vim.wikia.com/wiki/Working_with_Unicode
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set Unicode if possible
" First, check that the necessary capabilities are compiled-in
if has("multi_byte")
    if &termencoding == ""
        let &termencoding=&encoding
    endif
    set encoding=utf-8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=utf-8,big5,gb18030,gbk,gb2312,enc-kr,utf-bom,ucs-bom,iso8859-1,cp936
    "set tenc=utf8
endif
set encoding=utf-8 "YouCompleteMe requires this

""""""""""""""""""""""""""""""""""""""""""""""""""""
" GNU screen
""""""""""""""""""""""""""""""""""""""""""""""""""""
"if &term =~ "xterm"
    "restore screen after quitting
    "set t_ti=ESC7ESC[rESC[?47h t_te=ESC[?47lESC8
"    if has("terminfo")
"        let &t_Sf="\ESC[3%p1%dm"
"        let &t_Sb="\ESC[4%p1%dm"
"    else
"        let &t_Sf="\ESC[3%dm"
"        let &t_Sb="\ESC[4%dm"
"    endif
"endif

" Fix keys in GNU screen
" Make Vim recognize xterm escape sequences for Page and Arrow
" keys combined with modifiers such as Shift, Control, and Alt.
" See http://www.reddit.com/r/vim/comments/1a29vk/_/c8tze8p
if &term =~ '^screen'
    " Page keys http://sourceforge.net/p/tmux/tmux-code/ci/master/tree/FAQ
    execute "set t_kP=\e[5;*~"
    execute "set t_kN=\e[6;*~"

    " Arrow keys http://unix.stackexchange.com/a/34723
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Omni Completion
""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin on
set omnifunc=syntaxcomplete#Complete    " Enable Omni Completion
set completeopt=menuone,longest,preview " Popup menu even when there is one match, insert the longest common test of all matches
"set completeopt=menuone,menu,longest

""""""""""""""""""""""""""""""""""""""""""""""""""""
" GUI size
""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running")
    set columns=85
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colour
""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark " adapt colours for background
if has("gui_running")
    if has("win32") || has("win64")
        set guifont=Anonymice_Powerline:h11
    else
        set guifont=Monospace\ 8
    endif
    set lines=100   " height = 100 lines
    colors wombat

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""
    let g:airline_powerline_fonts = 1
else
    if &t_Co == 256
        colors 256_asu1dark
    endif
endif

" If supports colour
if &t_Co > 2 || has("gui_running")
    "filetype plugin on
    syntax enable   " Enable syntax colouring
    "syntax on       " Enable syntax colouring
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Search
""""""""""""""""""""""""""""""""""""""""""""""""""""
set hls         " Turn on highlight search
"set incsearch   " Turn on incremental search
set ic          " Turn on ignore case while doing search
set sc          " Turn on smart case, don't ignores case if search pattern contains upper-case
set so=3        " Set scrolloff to to show number of lines before and after the search match
"Turn off Vim's default regex characters
"nnoremap / /\v
"vnoremap / /\v

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indentation and tab width
" See http://vim.wikia.com/wiki/Indenting_source_code
""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype indent on  " Enable auto-indent for supported file types
set ai              " Set auto indent so a new line will copy the indentation from previous line
set ts=4            " Set tab stop (width of TAB)
set sts=4           " Set soft tab stop for indentation without hard tabs (should be same as shift width)
set sw=4            " Set shift width for >>, << or == and auto-indent
set shiftround      " Use multiple of shiftwidth when indenting with '>' and '<'
set et              " Turn on expand tab to insert 'softtabstop' amount of spaces for TAB
set sta             " Set smart tab to insert tabs on the start of a line according to shiftwidth, not tabstop

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Buffers
""""""""""""""""""""""""""""""""""""""""""""""""""""
set hidden              " Set hidden buffer to allow switching between unsaved buffers (hides buffers instead of closing them)
set switchbuf=usetab    " Set switch buffer to search for opened files in existing tabs or windows first

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folds
""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldmethod=syntax   " Set fold method to follow the file type syntax
set fdls=9999           " Set starting fold level when opening a buffer
" Set vim to save and restore the fold level when a file is opened and closed
set viewdir=$HOME/.vimviews// " Set directory for saving view files
if has("autocmd")
    autocmd BufWritePost,BufLeave,WinLeave ?* mkview
    autocmd BufWinEnter ?* silent loadview
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix backspace and delete problems
" See http://vim.wikia.com/wiki/Backspace_and_delete_problems
""""""""""""""""""""""""""""""""""""""""""""""""""""
set backspace=indent,eol,start " Allow backspacing over everything in insert mode

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc settings
" See http://stevelosh.com/blog/2010/09/coming-home-to-vim/
" http://nvie.com/posts/how-i-boosted-my-vim/
""""""""""""""""""""""""""""""""""""""""""""""""""""
set vb                          " Use visual bell and don't beep
set noerrorbells                " Don't beep on errors
set ruler                       " Show line/column in bottom right corner
set laststatus=2                " Always show the status line at the bottom
set showmode                    " Show the current working mode
set showcmd                     " Show information about current command
set ttyfast                     " Set fast terminal connection to improve redrawing
set lazyredraw                  " Don't update the display while executing macros
set wildmenu                    " Enable command completion
set wildmode=list:longest,full  " Return longest command completion with list of options
" Ignore these filenames during enhanced command line completion.
"set wildignore+=*.aux,*.out,*.toc " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif " binary images
"set wildignore+=*.luac          " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc           " Python byte code
"set wildignore+=*.spl          " compiled spelling word lists
set wildignore+=*.sw?,*~$       " Vim swap files
if has('unnamedplus')
    set clipboard=unnamedplus   " Set yanking to '+' register which is the clipbard to allow interaction with other apps
else
    set clipboard=unnamed       " Set yanking to the unamed register
endif
set splitbelow                  " Horizontal split windows at bottom
set nomodeline                  " Disable mode lines (security measure)
set showmatch                   " Enable show matching brackets
"set nu                         " Turn line numbering on
"set nobackup                   " Do not write backup files (~)
"set noswapfile                 " Do not write swap files (.swp)
"set autochdir                  " Set automatically change to directory of current buffer
set number
set relativenumber
set undofile                    " Make undo information persistent so it can be used after closing and reopening a file
set undodir=~/tmp,/tmp
set backupdir=$TEMP,~/tmp,/tmp  " Set backup file directory (~)
set directory=$TEMP,~/tmp,/tmp  " Set swap file directory (.swp)
"set backup
set pastetoggle=<F2>            " Use F2 to switch to paste mode for pasting

" Toggle show/hide invisible chars
nnoremap <leader>i :set list!<cr>

" Toggle line numbers
nnoremap <leader>N :setlocal number!<bar>setlocal relativenumber!<cr>

" Remap <F1> help key to <ESC> in insert and command line modes
noremap! <F1> <ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Look these tag files in opened file's directory, then work up tree to root until one is found
set tags=./tags;/
set tags+=./tags.linux;/
set tags+=./tags.windows;/

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Cscope + CCTree
" See http://nitin.mydoast.com/my-vimrc-file-for-windows-with-cscope-plugin/
""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set cscopetag       " use both cscope and ctag for ‘ctrl-]’, ‘:ta’, and ‘vim -t’
    set csto=0          " check cscope for definition of a symbol before checking ctags. Set to 1 to reverse search order
    set nocscopeverbose " show msg when any other cscope db added
    if $CSCOPE_DB != ""
        cs add $CSCOPE_DB
        "CCTreeLoadDB $CSCOPE_DB
    elseif filereadable("cscope.out")
        cs add cscope.out
        "CCTreeLoadDB cscope.out
    endif
    "nmap <F11> :silent !find . -iname "*.c" -o -iname "*.cpp" -o -name "*.h" -o -iname "*.hpp" -fprintf cscope.files "\"\%h/\%f\"\n"<cr>
    nmap <F11> :silent !find . -iname "*.c" -o -iname "*.cpp" -o -name "*.h" -o -iname "*.hpp" > cscope.files<cr>
                \:silent !cscope -b -q -i cscope.files -f cscope.out<cr>
                \:silent cs kill -1<cr>
                \:silent cs add cscope.out<cr><cr>
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""
" YouCompleteMe
""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_always_populate_location_list = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_extra_conf_globlist = ['~/ws/*', 'C:\ws\*']

""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.DS_Store$']
let NERDTreeShowHidden=1

""""""""""""""""""""""""""""""""""""""""""""""""""""
" SuperTab
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Let SuperTab decide which completion mode to use to play well with OmniCompletion
"let g:SuperTabDefaultCompletionType = "<C-X><C-O>"
"let g:SuperTabDefaultCompletionType = "context"
"let g:SuperTabContextDefaultCompletionType = "<c-p>"
"let g:SuperTabCompletionContexts = ['s:ContextText', 's:ContextDiscover']
"let g:SuperTabContextDiscoverDiscovery = ["&omnifunc:<c-x><c-o>"]

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tagbar
""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F8> :TagbarToggle<cr>

