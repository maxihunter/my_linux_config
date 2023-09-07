runtime! debian.vim
if has("syntax")
  syntax on
endif
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

source $VIMRUNTIME/vimrc_example.vim

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

"general configuration
set number
set wrap
set bs=indent,eol,start
set linebreak
set ruler
set showcmd
set showmatch
set smartcase
set autoindent
set tabstop=4
"set tags=/mnt/hdd/src/*/tags

set hlsearch
set scrolloff=7

colorscheme desert 
set laststatus=2
set statusline=%w\ >>\ %f\ %3c:%5l(%L)\ %m%r\ %{GoodFileTime()}

function! GoodFileTime()
  let ext=tolower(expand("%:e"))
  let fname=tolower(expand('%<'))
  let filename=fname . '.' . ext
  let filename2=fname . ".o"
  let msg=""
  let msg=msg." ".strftime("Modified: %d %b %Y %H:%M:%S",getftime(filename))
  if getftime(filename) > getftime(filename2)
      let msg=msg." ***FILE NOT COMPILED"
  endif
  return msg
endfunction

function! FileTime()
  let ext=tolower(expand("%:e"))
  let fname=tolower(expand('%<'))
  let filename=fname . '.' . ext
  let msg=""
  let msg=msg." ".strftime("Modified %b,%d %y %H:%M:%S",getftime(filename))
  let filename=fname . ".o"
  let msg=msg." ".strftime("[BIN %b,%d %y %H:%M:%S]",getftime(filename))
  return msg
endfunction

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
hi StatusLine ctermfg=black ctermbg=white

set pastetoggle=<F4>

map <F2> :w<CR>
map <ESC><ESC> :q<CR>
map <F3> v
map <F9> :!<CR>
map <TAB> za
