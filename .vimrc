call plug#begin('~/.vim/plugged')
Plug 'pangloss/vim-javascript'
Plug 'othree/html5.vim'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"snippets
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'justinmk/vim-sneak'
"end snippets
Plug 'github/copilot.vim'
"help copilot
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-lua/plenary.nvim'
call plug#end()
"close vim and reopen and :PlugInstall to install new plugins

"environment
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
set cmdheight=2

syntax enable
let g:solarized_termcolors=256
set background=dark
colorscheme solarized

"enable jsdoc highlighting, from vim-javascript plugin
let g:javascript_plugin_jsdoc = 1

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
let g:ale_fixers = {
      \  'javascript': ['eslint'],
      \}

"gitgutter settings
let g:gitgutter_enabled = 1

"coc.nvim settings
let g:coc_node_path = $HOME.'/.nvm/versions/node/v16.15.0/bin/node'

"dont let vim block when jumping around files using coc
set shortmess=aFc

nmap <silent> gd :call CocActionAsync('jumpDefinition', 'vsplit')<CR>
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gc <Plug>(coc-declaration)

nnoremap <silent> <Leader>as <Plug>(coc-codeaction-selected)
nnoremap <silent> <Leader>rs <Plug>(coc-codeaction-refactor-selected)

"confirm completion on ctrl + space
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

"Use <tab> and <S-tab> to navigate completion list: >
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Insert <tab> when previous text is space, refresh completion if not.
inoremap <silent><expr> <TAB>
\ coc#pum#visible() ? coc#pum#next(1):
\ CheckBackspace() ? "\<Tab>" :
\ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

nnoremap <silent> <Leader>K :call <SID>show_documentation()<CR>
nnoremap <silent> <Leader>J :call <Plug>('definitionHover') 

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"SnipMate settings
let g:snipMate = { 'snippet_version' : 1 }

"Sneak settings
let g:sneak#s_next = 1 "enables s to go to next instance of match because I remapped ;

"Copilot settings
"confirm completion on <C-J>
imap <silent><script><expr> <C-J> copilot#Accept("")
let g:copilog_no_tab_map = v:true

"Telescope settings
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>
