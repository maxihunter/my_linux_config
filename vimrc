runtime! debian.vim
if has("syntax")
  syntax on
endif
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Your customised tags go first.
set tags+=~/tags,$DOC/tags
let parent_dir = expand("%:p:h")."/"
while match(parent_dir,"/",0)>-1 && isdirectory(parent_dir)
  let parent_tag = parent_dir."tags"
  if filereadable(parent_tag)
    exe ":set tags+=".parent_tag
  endif
  let parent_dir = substitute(parent_dir,"[^/]*/$","","")
endwhile
let parent_dir = getcwd()."/"
while match(parent_dir,"/",0)>-1 && isdirectory(parent_dir)
  let parent_tag = parent_dir."tags"
  if filereadable(parent_tag)
    exe ":set tags+=".parent_tag
  endif
  let parent_dir = substitute(parent_dir,"[^/]*/$","","")
endwhile
unlet parent_dir parent_tag

set number
set wrap
set bs=indent,eol,start
set linebreak
set ruler
set showcmd
syntax on
set autoindent
set tabstop=4
"set tags=/mnt/hdd/src/*/tags
set hlsearch

colorscheme blue
set laststatus=2
set statusline=%w\ >>\ %f\ %L\ %m%r

"setup folds
set foldmethod=indent
set foldnestmax=3
set foldlevel=3

set list
set listchars=tab:>-,eol:$,trail:~,extends:>,precedes:<
set expandtab
set shiftwidth=4
filetype plugin indent on
set viminfo='20,<1000
"set cursorline
"set cursorcolumn
"hi cursorline cterm=none ctermfg=none ctermbg=black

set pastetoggle=<F4>

map <F2> :w<CR>
map <ESC><ESC> :q<CR>
map <F3> v
map <F9> :!<CR>
map <TAB> za
