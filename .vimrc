call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
"end snippets
call plug#end()
"close vim and reopen and :PlugInstall to install new plugins

"environment
syntax on
filetype plugin indent on
set tabstop=2
set shiftwidth=2
set expandtab
set autoindent
set number
set clipboard=unnamed
set splitright
set splitbelow
set mouse=a
set hlsearch

"mappings
nnoremap ; :
vnoremap ; :
nnoremap <C-W>f <C-W>vgf
inoremap kj <ESC>
vnoremap kj <ESC>  
" copy relative path (src/foo.txt)
nnoremap <leader>cf :let @*=expand("%")<CR>
" copy absolute path (/something/src/foo.txt)
nnoremap <leader>cF :let @*=expand("%:p")<CR>
" copy filename (foo.txt)
nnoremap <leader>ct :let @*=expand("%:t")<CR>

"brace auto-completion and easy out
function! EmptyBrace(brace)
  if getline(".")[col(".")-1] == a:brace 
    return "\<RIGHT>"
  endif
  return a:brace 
endfunction

inoremap { {}<ESC>ha
inoremap <expr> } EmptyBrace("}") 

inoremap ( ()<ESC>ha
inoremap <expr> ) EmptyBrace(")")

inoremap [ []<ESC>ha
inoremap <expr> ] EmptyBrace("]")
"end brace auto-completion and easy out

"ale settings
nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

"enable following to save on battery power
"let g:ale_lint_on_text_change='never'
"  let g:ale_fixers = {
"    'javascript': ['eslint'],
"  }

"gitgutter settings
let g:gitgutter_enabled = 0

"coc.nvim settings
let g:coc_node_path = $HOME.'/.nvm/versions/node/v10.15.3/bin/node'

"dont let vim block when jumping around files using coc
set shortmess=aFc

nmap <silent> gd :call CocActionAsync('jumpDefinition', 'vsplit')<CR>
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"confirm completion on ctrl + space
inoremap <silent><expr> <c-space> coc#refresh()

nnoremap <silent> <Leader>K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

