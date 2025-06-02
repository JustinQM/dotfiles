" set leader
let mapleader = " "

" tab settings
set shiftwidth=4 smarttab
set expandtab
set tabstop=8 softtabstop=0

" remap esc to jk
imap jk <Esc>

" syntax stuff
syntax on
set relativenumber
set number

" Searching
set ignorecase          " ignore case…
set smartcase           " …but be smart if you use capitals
set hlsearch            " highlight all search matches
set incsearch           " incremental live-search

" tab completion
set wildmode=longest,list,full
set wildmenu

" configure tab bar to not be ugly
hi TabLineFill ctermfg=Black ctermbg=Black

" autoindent
set smartindent

"AsyncRun
let g:asyncrun_open = 8
nnoremap <silent> <leader>r :<CR>:AsyncRun<Space>

" Quickfix list mappings
nnoremap <silent> <leader>co :copen<CR>        " open the quickfix window
nnoremap <silent> <leader>cc :cclose<CR>       " close the quickfix window
nnoremap <silent> <leader>cn :cnext<CR>        " jump to next item
nnoremap <silent> <leader>cp :cprevious<CR>    " jump to previous item

" Glutentags config
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_ctags_auto_set_tags = 1
set tags=./.tags;,.tags

"Generate tags by hand when needed
command! -nargs=0 BuildTags
      \ execute 'silent! !ctags -R -f .tags .' |
      \ echo '>> .tags rebuilt'

nnoremap <silent> <leader>tt :BuildTags<CR>

" annoying curly brace error
let c_no_curly_error=1
