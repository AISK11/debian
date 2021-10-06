"#################################################################
" Author: AISK11

" Packages installed:
" sudo apt install vim
"#################################################################

""""""""""""""""""""""
"       SOUND        "
""""""""""""""""""""""
"" Turn off all sound:
set noerrorbells
set novisualbell
set t_vb=
set tm=500

""""""""""""""""""""""
"      BACKUPS       "
""""""""""""""""""""""
"" Turn backup off:
set nobackup
set nowb
set noswapfile

""""""""""""""""""""""
"   TAB and SPACES   "
""""""""""""""""""""""
"" Preserve indentation on new line:
set autoindent
"" Do not replace tabs with spaces:
set noexpandtab
"" Tab = 4 chars:set tabstop=4
set shiftwidth=4

"""""""""""""""""""""""
"     STATUSLINE      "
"""""""""""""""""""""""
"" Always show the status line:
set laststatus=2
"" Statusline:
set statusline=%F\ %p%%\ [%l:%c]\ %M\ %R

""""""""""""""""""""""
"      SCROLLING     "
""""""""""""""""""""""
"" Start scrolling, N lines before reach end:
set scrolloff=4

""""""""""""""""""""""
"       SEARCH       "
""""""""""""""""""""""
"" Highlight search results:
set hlsearch

""""""""""""""""""""""
"    LINE NUMBERS    "
""""""""""""""""""""""
"" Number lines:
"set number

""""""""""""""""""""""
" PROGRAMMING SYNTAX "
""""""""""""""""""""""
"" Enable syntax highlighting:
syntax on

""""""""""""""""""""""
" HIGHLIGHT BRACKETS "
""""""""""""""""""""""
"" Show other bracket:
set showmatch

""""""""""""""""""""""
"    COLOR THEME     "
""""""""""""""""""""""
"colorscheme murphy

""""""""""""""""""""""
"      PLUGINS       "
""""""""""""""""""""""
"" Install with command:
"" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
""""""""""""""""""""""

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'hdima/python-syntax'
Plug 'nvie/vim-flake8'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"""" Plug 'hdima/python-syntax':
"" Apply plugin highlighting on '*.py' files:
let python_highlight_all = 1

"""" Plug 'nvie/vim-flake8':
"" Change key (def: F7 -> F3) to check python code for syntax errors:
"autocmd FileType python map <buffer> <F3> :call flake8#Flake8()<CR>
