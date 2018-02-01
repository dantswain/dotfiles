call plug#begin('~/.vim/plugged')

" general
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer' }
Plug 'jiangmiao/auto-pairs'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ervandew/supertab'
Plug 'LucHermitte/lh-vim-lib'
Plug 'LucHermitte/local_vimrc'

" terraform
Plug 'hashivim/vim-terraform'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'

" Ruby
Plug 'vim-ruby/vim-ruby'

" Thrift
Plug 'solarnz/thrift.vim'

" Python
Plug 'Vimjas/vim-python-pep8-indent', { 'for': 'python' }

Plug 'w0rp/ale'

call plug#end()

set nocompatible
set backspace=indent,eol,start
set cursorline
set number
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2

" delete comment character when joining lines
set formatoptions+=j

" wildmenu (the autocomplete menu at the bottom when you type :e)
set wildmenu
set wildignore+=*~

" use teh mouse, allow it to handle resizing panes in tmux - see
" http://superuser.com/questions/549930/cant-resize-vim-splits-inside-tmux 
set mouse+=a
if has("mouse_sgr")
  set ttymouse=sgr
else
  set ttymouse=xterm2
end

" otherwise this is stupid slow
set re=1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale
"set nocompatible
"filetype off
"
"let &runtimepath.=',~/.vim/plugged/ale'
"
"filetype plugin on
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ale_linters = {
      \  'python': ['pylint'],
      \}

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

map <c-b> :CtrlPBuffer<CR>

au BufRead,BufNewFile Jenkinsfile set filetype=groovy

let mapleader = ","

" close a buffer without losing the split
nnoremap <leader>d :bp\| bd #<CR>

" auto-wrap and let me know when i go over 80 columns
" see http://stackoverflow.com/questions/235439/vim-80-column-layout-concerns 
set tw=79
if exists('+colorcolumn')
  set colorcolumn=80,100
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

colorscheme slate

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" YCM and Ultisnips config from
" http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" " Ultisnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

"" local_vimrc
call lh#local_vimrc#munge('whitelist', $HOME.'/src/')
