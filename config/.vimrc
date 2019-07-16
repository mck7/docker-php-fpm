syntax enable
filetype off

set paste
set nocompatible
set background=dark

"{{{ Base config stuff
  syntax on
  set nocompatible
  set vb t_vb=
  set number
  set ruler
  set nobackup
  set nowb
  set noswapfile
  set ls=2
  set background=dark
"}}}

"{{{ Tabs and Whitespace
  set nocompatible
  set shiftwidth=2
  set tabstop=2
  set softtabstop=2
  set smarttab
  set ai
  set si
  set expandtab
  set autoindent
  set smartindent
  set list
  set listchars=tab:>-,trail:~,extends:>,precedes:<
"}}}

"{{{ UI Options
  set number
  set showcmd
  set nocursorline
  filetype indent plugin on
  set wildmenu
  set showmatch
  set hlsearch
"}}}

"{{{ Autogroups
augroup configgroup
    autocmd!
    autocmd VimEnter * highlight clear SignColumn
    autocmd FileType php setlocal expandtab
    autocmd FileType php setlocal list
    autocmd FileType php setlocal listchars=tab:+\ ,eol:-
    autocmd FileType php setlocal formatprg=par\ -w80\ -T4
    autocmd BufEnter *.zsh-theme setlocal filetype=zsh
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2
augroup END
"}}}
