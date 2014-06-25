if has("gui_running")
    colorscheme ir_black
    set guioptions=egmrt
    set transparency=3
"    set lines=55
"    set columns=80
    
    " color tweaks
    autocmd ColorScheme * hi CursorLine guibg=#2D2D2D
    autocmd ColorScheme * hi CursorColumn guibg=#2D2D2D

endif

" use 256 colors in terminal 
set t_Co=256

if has("multi_byte")
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8                     " better default than latin1
  setglobal fileencoding=utf-8           " change default file encoding when writing new files
endif

set smartindent
set autoindent
set expandtab
set shiftwidth=2
set softtabstop=2
set showtabline=2

set wildmenu
set ruler
set number
set hlsearch
set incsearch
set showmatch

set cursorcolumn  " highlight the current column

" Change mapleader
let mapleader=","

" files that get ignored by, for example Command-T
set wildignore+=.git,*.o,*.a,checksums/*,*.beam

if has("autocmd")
  filetype plugin indent on
end

" treat Arduino files like c++
au BufNewFile,BufReadPost *.ino,*.pde set filetype=cpp

" Rust plugin
set runtimepath+=$HOME/.vim/rust-vim
au BufRead,BufNewFile *.rs setfiletype rust

" nginx plugin
au BufRead,BufNewFile *nginx*conf setfiletype nginx

" vim-ruby: https://github.com/vim-ruby/vim-ruby/wiki/VimRubySupport
set nocompatible
syntax on

hi CursorColumn cterm=NONE ctermbg=103

" smart paste:  http://vim.wikia.com/wiki/Smart_paste
:nnoremap <D-v> "+P=']
:inoremap <D-v> <D-o>"+P<C-o>=']

" VimOrganize
au! BufRead,BufWrite,BufWritePost,BufNewFile *.org 
au BufEnter *.org            call org#SetOrgFileType()

" Vagrantfiles are just Ruby
au BufRead,BufNewFile Vagrantfile set ft=ruby

" go syntax hilighting
au BufRead,BufNewFile *.go set filetype=go

" Marked.app
:nnoremap <leader>m :silent !open -a Marked.app '%:p'<cr>

" ControlP mappings
nnoremap <leader>f :CtrlP<CR>
nnoremap <leader>b :CtrlPBuffer<CR>
nnoremap <leader>m :CtrlPMRUFiles<CR>
nnoremap <leader>t :CtrlPTag<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" From Brandon

set cursorline " Highlight current line
set history=1000 " Increase history from 20 default to 1000
set hlsearch " Highlight searches
set magic " Enable extended regexes.
set scrolloff=3 " Start scrolling three lines before horizontal border of window.
set showmode " Show the current mode.
set showtabline=2 " Always show tab bar.
set splitbelow " New window goes below
set splitright " New windows goes right
set title " Show the filename in the window titlebar.
set ttyfast " Send more characters at a given time.
set wildchar=<TAB> " Character for CLI expansion (TAB-completion).
set wildmode=list:longest " Complete only until point of ambiguity.
set wrapscan " Searches wrap around end of file

" Execute open rspec buffer
function! RunSpec(args)
  let cmd = ":! rspec --color % -cfn " . a:args
  execute cmd 
endfunction
 
" Mappings
" run one rspec example or describe block based on cursor position
map <leader>rs :call RunSpec("-l " . <C-r>=line('.')<CR>)
" run full rspec file
map <leader>RS :call RunSpec("")

" End From Brandon
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

