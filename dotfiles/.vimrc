"#################################################################
" Author: AISK11

" Packages installed:
" sudo apt install vim
"#################################################################

"" Turn off all sound:
set noerrorbells
set novisualbell
set t_vb=
set tm=500

"" Copy indent on new line:
set autoindent
	"" Do not replace tabs with spaces:
set noexpandtab
"" Tab = 4 chars:set tabstop=4
set shiftwidth=4

"" Number lines:
"set number

"" Colors:
syntax enable
"colorscheme murphy

"" Always show the status line:
set laststatus=2
"" Statusline:
set statusline=%F\ %p%%\ [%l:%c]\ %M\ %R

"" Turn backup off:
set nobackup
set nowb
set noswapfile

"" Show other bracket:
set showmatch

"" Highlight search results:
set hlsearch

"" Python commands:
let python_highlight_all = 1
