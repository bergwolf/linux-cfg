"
" Bergwolf's .vimrc, based on
" https://github.com/fannheyward/vimrc/blob/master/vimrc
"
"1. git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
"2. :PluginInstall
"3. cd ~/.vim/bundle/YouCompleteMe/ ;./install.sh --clang-completer --system-libclang
"4. cp .ycm_extra_conf.py ~/
"

" Vundle goes first!!!
"{{{
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

Plugin 'tpope/vim-sensible'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'majutsushi/tagbar'
"Plugin 'kien/ctrlp.vim'
Plugin 'rking/ag.vim'
Plugin 'vim-scripts/TaskList.vim'
Plugin 'nacitar/a.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bronson/vim-trailing-whitespace'
Plugin 'fannheyward/rainbow_parentheses.vim'
Plugin 'vim-scripts/loremipsum'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'dyng/ctrlsf.vim'
Plugin 'mhinz/vim-startify'
Plugin 'fatih/vim-go'
Plugin 'bling/vim-airline'
Plugin 'kana/vim-textobj-user'
Plugin 'glts/vim-textobj-comment'
Plugin 'Julian/vim-textobj-brace'
Plugin 'Shougo/neocomplete.vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
"}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default config
map <silent> <leader>ee :e ~/.vimrc<cr>"{{{
map <silent> <leader>n :nohlsearch<cr>

nmap ? /\<\><Left><Left>

set guifont=Monaco:h15
set guifontwide=Monaco:h15
colorscheme desert
set background=dark

" Chinese encodingcoding
set encoding=utf-8
set fileencodings=utf-8,gbk,chinese,cp936,gb18030,utf-16le,utf-16,big5,euc-jp,euc-kr,latin-1
set fileencoding=utf-8

"set undofile
"set undodir=~/.undodir
"set undolevels=1000

set number
setlocal noswapfile
set smartindent       "set smart indent
set tabstop=8
set shiftwidth=8
set nofoldenable
set showmatch
set matchtime=2
set matchpairs+=<:>
set hlsearch
set ignorecase smartcase
set completeopt=longest,menu
let do_syntax_sel_menu=1
set updatetime=200

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! %!sudo tee > /dev/null %

" some autocmd
autocmd FileType html,javascript,css setlocal shiftwidth=2 tabstop=2

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete

:command W w
:command Q q
:command Qa qa
:command Wa wa
:command Wqa wqa
:command WQa wqa

"" Recommended key-mappings. For no inserting <CR> key.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-n>\<C-y>" : "\<CR>"
endfunction

" Plugin config.
" CtrlP
" let g:ctrlp_custom_ignore = '\v[\/](bower_components|node_modules|vendor|target|dist|_site|nginx_runtime|build|logs|data)|(\.(swp|ico|git|svn))$'
" set wildignore+=*.pyc,*.sqlite,*.sqlite3
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
" set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
" set wildignore+=*/bower_components/*,*/node_modules/*
" set wildignore+=*/nginx_runtime/*,*/build/*,*/logs/*

" CtrlSF
:com! -n=* F CtrlSF <args>
:com! -n=0 FOpen CtrlSFOpen
"let g:ctrlsf_auto_close = 0

" Tasklist
let g:tlTokenList = ['TODO' , 'WTF', 'FIX']

" rainbow_parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadSquare " []
au Syntax * RainbowParenthesesLoadBraces " {}
"au Syntax * RainbowParenthesesLoadChevrons " <>

" Tagbar
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1

" YCM
nnoremap <buffer> <silent> gd :YcmCompleter GoTo<cr>
let g:ycm_complete_in_comments = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_server_log_level = 'error'
let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'

" UltiSnips
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" Vim-go
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
"}}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" My own configurations...
"{{{
set foldmethod=marker

" auto format
"set formatoptions=croq
set formatoptions=tobm1

" No sound on errors.
set noerrorbells
set novisualbell
set vb t_vb=

" allow backspace to delete everything in insert mode
set bs=2

" no backups
set nobackup
set nowb
set noswapfile

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

"}}}

" plugin configurations
"{{{
" taglist
let Tlist_Show_One_File=1
let Tlist_Exit_OnlyWindow=1
let Tlist_WinWidth=20
let Tlist_Use_Horiz_Window=0
let Tlist_Use_Right_Window=1
let Tlist_Sort_Type='name'

" window manager
"let g:winManagerWindowLayout='FileExplorer|TagList'
let g:winManagerWindowLayout='TagList'

" minibuffer
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" vim Grep
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn'

" Latex Suit
set grepprg=grep\ -nH\ $*
let g:Tex_DefaultTargetFormat="pdf"
let g:Tex_ViewRule_pdf='xpdf'
"}}}

" maps
"{{{
nmap wm     :WMToggle<cr>
nmap dk     d$
nmap <F6>   :cn<cr>
nmap <F7>   :cp<cr>
nnoremap <silent><F5>   :Grep<cr>
nmap zj     zf%
" fast quit
nmap qq :q<cr>
nmap qa :q<cr>:q<cr>:q<cr>:q<cr>:q<cr>:q<cr>

nmap <space> :
" fast save
nmap <leader>w :w<cr>
" remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" switch buffer
nmap <c-p>  <c-k><tab><cr>
nmap <c-n>  <c-k>b<cr>
" close other buffer
nmap <Leader>d  <c-k><tab>d<c-j><c-k>d<c-j><c-k>d<c-j><c-k>d<c-j><c-k>d<c-j>
" close current buffer
nmap <Leader>c  <c-k>d<cr><c-j>
nmap <c-->  <c-w>-

" vim-go setting
" Show a list of interfaces which is implemented by the type under your cursor
" with <leader>s
au FileType go nmap <Leader>s <Plug>(go-implements)

" Show type info for the word under your cursor with <leader>i (useful if you
" have disabled auto showing type info via g:go_auto_type_info)
au FileType go nmap <Leader>i <Plug>(go-info)

" Open the relevant Godoc for the word under the cursor with <leader>gd or open
" it vertically with <leader>gv
au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)

" Run commands, such as go run with <leader>r for the current file or go build
" and go test for the current package with <leader>b and <leader>t. Display a
" beautiful annotated source code to see which functions are covered with <leader>c.
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

" By default the mapping gd is enabled which opens the target identifier in current
" buffer. You can also open the definition/declaration in a new vertical, horizontal
" tab for the word under your cursor:
au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

" Rename the identifier under the cursor to a new name
au FileType go nmap <Leader>e <Plug>(go-rename)

" vim-oracle-go setting
"
au FileType go nmap gc :GoOracleCallers<cr>


" My own vim-go mappings:
au FileType go nmap <C-\>g :GoDef<CR>
au FileType go nmap <C-\>s :GoDoc<CR>
au FileType go nmap <C-\>t :GoTest<CR>
au FileType go nmap <C-\>e :GoErrCheck<CR>
au FileType go nmap <C-\>l :GoLint<CR>
" oracle mappings:
au FileType go nmap <C-\>d :GoOracleDescribe<CR>
au FileType go nmap <C-\>i :GoOracleImplements<CR>
au FileType go nmap <C-\>cr :GoOracleCallers<CR>
au FileType go nmap <C-\>ce :GoOracleCallees<CR>
au FileType go nmap <C-\>cg :GoOracleCallgraph<CR>
au FileType go nmap <C-\>cp :GoOracleChannelPeers<CR>

"}}}

" recursively load custom .vimrc
"{{{
au BufNewFile,BufRead * call CheckForCustomConfiguration()

function! CheckForCustomConfiguration()
    " Check for .vim.custom recursively in current or upper directories
    if filereadable(".vim.custom")
        exe 'source .vim.custom'
    elseif filereadable("../.vim.custom")
        exe 'source ../.vim.custom'
    elseif filereadable("../../.vim.custom")
        exe 'source ../../.vim.custom'
    elseif filereadable("../../../.vim.custom")
        exe 'source ../../../.vim.custom'
    elseif filereadable("../../../../.vim.custom")
        exe 'source ../../../../.vim.custom'
    elseif filereadable("../../../../../.vim.custom")
        exe 'source ../../../../../.vim.custom'
    elseif filereadable("../../../../../../.vim.custom")
        exe 'source ../../../../../../.vim.custom'
    elseif filereadable("../../../../../../../.vim.custom")
        exe 'source ../../../../../../../.vim.custom'
    elseif filereadable("../../../../../../../../.vim.custom")
        exe 'source ../../../../../../../../.vim.custom'
    endif
endfunction
"}}}
