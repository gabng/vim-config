" .vimrc settings

execute pathogen#infect()
execute pathogen#helptags()

" Set vi file access encodings
let &termencoding=&encoding
set fileencodings=utf-8,big5,gb18030,gbk,gb2312,enc-kr,utf-bom,ucs-bom,iso8859-1,cp936
set encoding=utf8
set tenc=utf8

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

" If terminal supports colour
if &t_Co > 2 || has("gui_running")
	filetype plugin on
	syntax enable " Enable syntax colouring
	syntax on " Enable syntax colouring
endif

set background=dark    " adapt colours for background
if has("gui_running")
	set guifont=Monospace\ 8
	set lines=100	  " height = 100 lines
	colors wombat
else
	if &t_Co == 256
		colors 256_asu1dark
	endif
endif

" Enable show matching brackets
set showmatch

" Set soft tab stop
set sts=4

" Set tab stop to 4
set ts=4

" Set shift width to 2
set sw=4

" Set smart tab
set sta

" Enable auto-indent
filetype indent on
set ai

" Turn on expand tab
set et

" Turn line numbering on
" set nu

" Turn on highlight search
set hls

" Turn on incremental search
" set incsearch

" Set hidden buffer to allow switching between unsaved buffers
set hidden

" Set switch buffer to search for opened files in existing tabs or windows
" first
set switchbuf=usetab

" Set fold method to follow the file type syntax
set foldmethod=syntax

" Set starting fold level when opening a buffer
set fdls=9999

" Set vim to save and restore the fold level when a file is opened and closed
au BufWinLeave ?* mkview
au BufWinEnter ?* silent loadview

" Turn on ignore case while doing search
"set ic
" Turn on smart case, ignores case of search if pattern is lower-case
"set sc

" Set automatically change to directory of current buffer
" set autochdir

" Set the taglist window to show on the right
let Tlist_Use_Right_Window = 1
" Set to exit vim if only the taglist window is left
let Tlist_Exit_OnlyWindow = 1

