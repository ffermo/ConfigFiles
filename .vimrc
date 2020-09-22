"Plugin Manager
call plug#begin('~/.vim/plugged')

Plug 'https://github.com/morhetz/gruvbox.git'
Plug 'https://github.com/christoomey/vim-tmux-navigator.git'
Plug 'https://github.com/tpope/vim-obsession.git'
Plug 'https://github.com/jiangmiao/auto-pairs.git'
Plug 'https://github.com/ycm-core/YouCompleteMe'
"Plug 'https://github.com/tpope/vim-endwise.git'
"Plug 'https://github.com/rstacruz/vim-closer.git'

call plug#end()

"Color and editor theme
colorscheme gruvbox
set bg=dark
let g:gruvbox_contrast_dark = 'soft'
let g:gruvbox_contrast_light = 'soft'
let g:gruvbox_transparent_bg=1
let g:gruvbox_bold=0
let g:gruvbox_invert_selection=0

"Plugin options
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

hi Normal guibg=NONE ctermbg=NONE
highlight NonText ctermbg=NONE
set number
set relativenumber
set ic
highlight LineNr ctermfg=grey ctermbg=NONE
"Disable auto comment
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

"Tab indentations
set shiftwidth=4
set tabstop=4
set smartindent
set autoindent

"Allow saving of files as sudo when I forget to start vim as sudo.
cmap w!! w !sudo tee > /dev/null %
