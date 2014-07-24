" .vimrc settings

" Use vim settings, rather then vi settings
" This must be first, because it changes other options as a side effect
set nocompatible

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Configure Pathogen
""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off    " force reloading *after* pathogen loaded
execute pathogen#infect()
execute pathogen#helptags()

let mapleader=" "   " Change the mapleader from \ to space

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
    set encoding=utf8
    setglobal fileencoding=utf-8
    "setglobal bomb
    set fileencodings=utf-8,big5,gb18030,gbk,gb2312,enc-kr,utf-bom,ucs-bom,iso8859-1,cp936
    "set tenc=utf8
endif

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

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colour
""""""""""""""""""""""""""""""""""""""""""""""""""""
set background=dark " adapt colours for background
if has("gui_running")
    set guifont=Monospace\ 8
    set lines=100   " height = 100 lines
    colors wombat
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
nnoremap / /\v
vnoremap / /\v

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
"set wildignore+=*.luac         " Lua byte code
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.pyc           " Python byte code
"set wildignore+=*.spl          " compiled spelling word lists
set wildignore+=*.sw?,*~$       " Vim swap files
set clipboard=unnamedplus       " Set yanking to '+' register which is the clipbard to allow interaction with other apps
set nomodeline                  " Disable mode lines (security measure)
set showmatch                   " Enable show matching brackets
"set nu                         " Turn line numbering on
"set nobackup                   " Do not write backup files (~)
"set noswapfile                 " Do not write swap files (.swp)
"set autochdir                  " Set automatically change to directory of current buffer
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
nnoremap <leader>N :setlocal number!<cr>

" Remap <F1> help key to <ESC> in insert and command line modes
noremap! <F1> <ESC>

""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctags
""""""""""""""""""""""""""""""""""""""""""""""""""""
set tags=./tags;/   " Look in current directory for "tags", then work up tree to root until one is found

""""""""""""""""""""""""""""""""""""""""""""""""""""
" Taglist
""""""""""""""""""""""""""""""""""""""""""""""""""""
"let Tlist_Use_Right_Window = 1  " Set the taglist window to show on the right
"let Tlist_Exit_OnlyWindow = 1   " Set to exit vim if only the taglist window is left

""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDTreeIgnore=['\~$', '^\.git', '\.swp$', '\.DS_Store$']
let NERDTreeShowHidden=1

""""""""""""""""""""""""""""""""""""""""""""""""""""
" SuperTab
""""""""""""""""""""""""""""""""""""""""""""""""""""
" Let SuperTab decide which completion mode to use to play well with OmniCompletion
let g:SuperTabDefaultCompletionType = "context"

