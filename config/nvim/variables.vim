"{ Global Variable
"{{ Builtin variables
" Disable Python2 support
let g:loaded_python_provider=0

" Path to Python 3 interpreter (must be an absolute path), make startup
" faster. See https://neovim.io/doc/user/provider.html.
" if executable('python')
"    if g:is_win
"         let g:python3_host_prog=substitute(exepath('python'), '.exe$', '', 'g')
"     elseif g:is_linux || g:is_mac
"         let g:python3_host_prog='/usr/bin/python3'
"     endif
" else
"     echoerr 'Python 3 executable not found! You must install Python 3 and set its PATH correctly!'
" endif

let g:python3_host_prog='/usr/bin/python3'
" Custom mapping <leader> (see `:h mapleader` for more info)
let mapleader = ','
"}}

"{{ Disable loading certain plugins
" Whether to load netrw by default, see
" https://github.com/bling/dotvim/issues/4
" let g:loaded_netrw       = 0
" let g:loaded_netrwPlugin = 0
let g:netrw_liststyle = 3

" Do not load tohtml.vim
let g:loaded_2html_plugin = 1

" Do not load zipPlugin.vim, gzip.vim and tarPlugin.vim (all these plugins are
" related to checking files inside compressed files)
let g:loaded_zipPlugin = 1
let loaded_gzip = 1
let g:loaded_tarPlugin = 1

" Do not use builtin matchit.vim and matchparen.vim since we use vim-matchup
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
"}}
"}
