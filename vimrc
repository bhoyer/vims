" Needed on some linux distros.
" see http://www.adamlowe.me/2009/12/vim-destroys-all-other-rails-editors.html
filetype off 
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()


set nocompatible
set transparency=15
set incsearch

set number
set ruler
syntax on

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set list listchars=tab:\ \ ,trail:·

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc

" Status bar
set laststatus=2


"----------------"
" |Git-fugitive| "
"----------------"
" These keybindings are all modified from the git-vim plugin:
" http://github.com/motemen/git-vim/blob/master/plugin/git.vim
nnoremap <Leader>gd :Gdiff!<Enter>
"nnoremap <Leader>gD :GitDiff --cached<Enter>
nnoremap <Leader>gs :Gstatus<Enter>
nnoremap <Leader>gl :Glog<Enter>
"nnoremap <Leader>ga :Gadd<Enter>
nnoremap <Leader>ga :Git add %<CR><CR>
nnoremap <Leader>gc :Gcommit<Enter>
nnoremap <Leader>gC :Gcommit -v<Enter>
"nnoremap <Leader>gp :GitPullRebase<Enter>


"-----------"
" Git stuff "
"-----------"
set laststatus=2
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P


"source vimrc whenever written to disk
if has("autocmd") 
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

let mapleader=","
nmap <leader>v :tabedit $MYVIMRC <CR>

" NERDTree configuration
let NERDTreeIgnore=['\.rbc$', '\~$']
map <Leader>n :NERDTreeToggle<CR>

" toggles NERDTree on and off
map <f2> :NERDTreeToggle<cr>


" Command-T configuration
let g:CommandTMaxHeight=20

" ZoomWin configuration
map <Leader>z :ZoomWin<CR>

" CTags
map <Leader>rt :!ctags --extra=+f -R *<CR><CR>

" Remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

function s:setupWrapping()
  set wrap
  set wm=2
  set textwidth=72
endfunction

function s:setupMarkup()
  call s:setupWrapping()
  map <buffer> <Leader>p :Mm <CR>
endfunction

" make and python use real tabs
au FileType make                                     set noexpandtab
au FileType python                                   set noexpandtab

" Thorfile, Rakefile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Rakefile,Thorfile,config.ru}    set ft=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

au BufRead,BufNewFile *.txt call s:setupWrapping()

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" load the plugin and indent settings for the detected filetype
filetype plugin indent on

" Opens an edit command with the path of the currently edited file filled in
" Normal mode: <Leader>e
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" Opens a tab edit command with the path of the currently edited file filled in
" Normal mode: <Leader>t
map <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Use modeline overrides
set modeline
set modelines=10

" Default color scheme
color desert

" Include user's local vim config
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
