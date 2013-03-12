"
"	vimrc by  <Bergwolf@gmail.com>
"

" term specific settings
"{{{
" Try to get the correct main terminal type
if &term =~ "xterm"
    let myterm = "xterm"
else
    let myterm =  &term
endif
let myterm = substitute(myterm, "cons[0-9][0-9].*$",  "linux", "")
let myterm = substitute(myterm, "vt1[0-9][0-9].*$",   "vt100", "")
let myterm = substitute(myterm, "vt2[0-9][0-9].*$",   "vt220", "")
let myterm = substitute(myterm, "\\([^-]*\\)[_-].*$", "\\1",   "")

" Here we define the keys of the NumLock in keyboard transmit mode of xterm
" which misses or hasn't activated Alt/NumLock Modifiers.  Often not defined
" within termcap/terminfo and we should map the character printed on the keys.
if myterm == "xterm" || myterm == "kvt" || myterm == "gnome"
    " keys in insert/command mode.
    map! <ESC>Oo  :
    map! <ESC>Oj  *
    map! <ESC>Om  -
    map! <ESC>Ok  +
    map! <ESC>Ol  ,
"    map! <ESC>OM  
    map! <ESC>Ow  7
    map! <ESC>Ox  8
    map! <ESC>Oy  9
    map! <ESC>Ot  4
    map! <ESC>Ou  5
    map! <ESC>Ov  6
    map! <ESC>Oq  1
    map! <ESC>Or  2
    map! <ESC>Os  3
    map! <ESC>Op  0
    map! <ESC>On  .
    " keys in normal mode
    map <ESC>Oo  :
    map <ESC>Oj  *
    map <ESC>Om  -
    map <ESC>Ok  +
    map <ESC>Ol  ,
"    map <ESC>OM  
    map <ESC>Ow  7
    map <ESC>Ox  8
    map <ESC>Oy  9
    map <ESC>Ot  4
    map <ESC>Ou  5
    map <ESC>Ov  6
    map <ESC>Oq  1
    map <ESC>Or  2
    map <ESC>Os  3
    map <ESC>Op  0
    map <ESC>On  .
endif

" xterm but without activated keyboard transmit mode
" and therefore not defined in termcap/terminfo.
if myterm == "xterm" || myterm == "kvt" || myterm == "gnome"
    " keys in insert/command mode.
    map! <Esc>[H  <Home>
    map! <Esc>[F  <End>
    " Home/End: older xterms do not fit termcap/terminfo.
    map! <Esc>[1~ <Home>
    map! <Esc>[4~ <End>
    " Up/Down/Right/Left
    map! <Esc>[A  <Up>
    map! <Esc>[B  <Down>
    map! <Esc>[C  <Right>
    map! <Esc>[D  <Left>
    " KP_5 (NumLock off)
    map! <Esc>[E  <Insert>
    " PageUp/PageDown
    map <ESC>[5~ <PageUp>
    map <ESC>[6~ <PageDown>
    map <ESC>[5;2~ <PageUp>
    map <ESC>[6;2~ <PageDown>
    map <ESC>[5;5~ <PageUp>
    map <ESC>[6;5~ <PageDown>
    " keys in normal mode
    map <ESC>[H  0
    map <ESC>[F  $
    " Home/End: older xterms do not fit termcap/terminfo.
    map <ESC>[1~ 0
    map <ESC>[4~ $
    " Up/Down/Right/Left
    map <ESC>[A  k
    map <ESC>[B  j
    map <ESC>[C  l
    map <ESC>[D  h
    " KP_5 (NumLock off)
    map <ESC>[E  i
    " PageUp/PageDown
    map <ESC>[5~ 
    map <ESC>[6~ 
    map <ESC>[5;2~ 
    map <ESC>[6;2~ 
    map <ESC>[5;5~ 
    map <ESC>[6;5~ 
endif

" xterm/kvt but with activated keyboard transmit mode.
" Sometimes not or wrong defined within termcap/terminfo.
if myterm == "xterm" || myterm == "kvt" || myterm == "gnome"
    " keys in insert/command mode.
    map! <Esc>OH <Home>
    map! <Esc>OF <End>
    map! <ESC>O2H <Home>
    map! <ESC>O2F <End>
    map! <ESC>O5H <Home>
    map! <ESC>O5F <End>
    " Cursor keys which works mostly
    " map! <Esc>OA <Up>
    " map! <Esc>OB <Down>
    " map! <Esc>OC <Right>
    " map! <Esc>OD <Left>
    map! <Esc>[2;2~ <Insert>
    map! <Esc>[3;2~ <Delete>
    map! <Esc>[2;5~ <Insert>
    map! <Esc>[3;5~ <Delete>
    map! <Esc>O2A <PageUp>
    map! <Esc>O2B <PageDown>
    map! <Esc>O2C <S-Right>
    map! <Esc>O2D <S-Left>
    map! <Esc>O5A <PageUp>
    map! <Esc>O5B <PageDown>
    map! <Esc>O5C <S-Right>
    map! <Esc>O5D <S-Left>
    " KP_5 (NumLock off)
    map! <Esc>OE <Insert>
    " keys in normal mode
    map <ESC>OH  0
    map <ESC>OF  $
    map <ESC>O2H  0
    map <ESC>O2F  $
    map <ESC>O5H  0
    map <ESC>O5F  $
    " Cursor keys which works mostly
    " map <ESC>OA  k
    " map <ESC>OB  j
    " map <ESC>OD  h
    " map <ESC>OC  l
    map <Esc>[2;2~ i
    map <Esc>[3;2~ x
    map <Esc>[2;5~ i
    map <Esc>[3;5~ x
    map <ESC>O2A  ^B
    map <ESC>O2B  ^F
    map <ESC>O2D  b
    map <ESC>O2C  w
    map <ESC>O5A  ^B
    map <ESC>O5B  ^F
    map <ESC>O5D  b
    map <ESC>O5C  w
    " KP_5 (NumLock off)
    map <ESC>OE  i
endif

if myterm == "linux"
    " keys in insert/command mode.
    map! <Esc>[G  <Insert>
    " KP_5 (NumLock off)
    " keys in normal mode
    " KP_5 (NumLock off)
    map <ESC>[G  i
endif

" This escape sequence is the well known ANSI sequence for
" Remove Character Under The Cursor (RCUTC[tm])
map! <Esc>[3~ <Delete>
map  <ESC>[3~    x
"}}}

" basic configurations
""{{{
" enable syntax highlighting
syntax on

" automatically indent lines (not default)
"set autoindent

" keep status bar
"set laststatus=2

" select case-insenitive search (not default)
" set ignorecase

" show cursor line and column in the status line
set ruler

" show matching brackets
set showmatch

" display mode INSERT/REPLACE/...
set showmode

" changes special characters in search patterns (default)
" set magic

" Required to be able to use keypad keys and map missed escape sequences
set esckeys

" get easier to use and more user friendly vim defaults
" CAUTION: This option breaks some vi compatibility. 
"          Switch it off if you prefer real vi compatibility
set nocompatible

" Complete longest common string, then each full match
" enable this for bash compatible behaviour
" set wildmode=longest,full

set number
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

" high light search
set hls

" no backups
set nobackup
set nowb
set noswapfile

" file type plugin
filetype plugin on
filetype indent on

" file encoding
set fenc=utf-8
set fencs=ucs-bom,utf-8,cp963,gb18030,iso8859-1,cp950,latinl

"}}}

" color settings
""{{{
if has("gui_running")
	set guioptions-=T
	let psc_style='cool'
	colorscheme desert
else
	set background=dark
	colorscheme desert
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
nmap wm		:WMToggle<cr>
nmap dk		d$
nmap <F6>	:cn<cr>
nmap <F7>	:cp<cr>
nnoremap <silent><F5>	:Grep<cr>
nmap zj		zf%
" fast quit
nmap qq	:q<cr>
nmap qa	:q<cr>:q<cr>:q<cr>:q<cr>:q<cr>:q<cr>

nmap <space> :
" fast save
nmap <leader>w :w<cr>
" remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm
" switch buffer
nmap <c-p>	<c-k><tab><cr>
nmap <c-n>	<c-k>b<cr>
" close other buffer
nmap <Leader>d	<c-k><tab>d<c-j><c-k>d<c-j><c-k>d<c-j><c-k>d<c-j><c-k>d<c-j>
" close current buffer
nmap <Leader>c	<c-k>d<cr><c-j>
nmap <c-->	<c-w>-

" comment and uncomment

"F3 for comment
vmap <F3> :s=^\(//\)*=//=g<cr>:noh<cr>
nmap <F3> :s=^\(//\)*=//=g<cr>:noh<cr>
imap <F3> <ESC>:s=^\(//\)*=//=g<cr>:noh<cr>
"F4 for uncomment
vmap <F4> :s=^\(//\)*==g<cr>:noh<cr>
nmap <F4> :s=^\(//\)*==g<cr>:noh<cr>
imap <F4> <ESC>:s=^\(//\)*==g<cr>:noh<cr>
"}}}

" Indent
"Auto indent"{{{
"set noai

"Smart indet
"set nosi
"set noci

"Wrap lines
set wrap
set textwidth=80
"set columns=80
set cindent
"set shiftwidth=3
set shiftwidth=8
set tabstop=8
"set expandtab

"}}}

" functions
" Highlight Current word {{{
function VIMRCWhere()
	if !exists("s:highlightcursor")
		match Todo /\k*\%#\k*/
		let s:highlightcursor=1
	else
		match None
		unlet s:highlightcursor
	endif
endfunction
	map <leader>r :call VIMRCWhere()<CR>

map <leader>h   :%!xxd<cr>
map <leader>H   :%!xxd -r<cr>

"}}}

" Signature for source files
" {{{
func! AddGPLSig()
	exec 'normal HO/*'
    exec 'normal oCopyright (C) 2012 <bergwolf@gmail.com>'
	exec 'normal o'
    exec 'normal oThis program is free software; you can redistribute it and/or modify it'
	exec 'normal ounder the terms of version 2 of the GNU General Public License as'
	exec 'normal opublished by the Free Software Foundation.'
	exec 'normal o'
    exec 'normal oThis program is distributed in the hope that it will be useful,'
    exec 'normal obut WITHOUT ANY WARRANTY; without even the implied warranty of'
    exec 'normal oMERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the'
    exec 'normal oGNU General Public License for more details.'
	exec 'normal o'
	exec 'normal oYou should have received a copy of the GNU General Public License'
	exec 'normal oalong with this program; if not, write to the Free Software'
	exec 'normal oFoundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA'
	exec 'normal o/'
endfunc

func! AddCodeSig()
	exec 'normal HO/*'
	exec 'normal oCopyright (C) 2012 Peng Tao <bergwolf@gmail.com>'
	exec 'normal o/'
endfunc

func! AddCStyleHeader()
        exec 'normal HO/* -*- mode: c; c-basic-offset: 3; indent-tabs-mode: nil; -*-'
        exec 'normal o * vim:expandtab:shiftwidth=3:tabstop=3:columns=89:'
        exec 'normal o/'
endfunc

map <Leader>u gg:call AddCStyleHeader()<CR>
map <Leader>s gg:call AddCodeSig()<CR>
map <Leader>g gg:call AddGPLSig()<CR>

let g:DoxygenToolkit_authorName="Bergwolf"
let g:DoxygenToolkit_briefTag_funcName="yes"
let g:DoxygenToolkit_versionString="1.0"
let g:DoxygenToolkit_licenseTag="Copyright (C) 2010 <bergwolf@gmail.com>"

"}}}

" recursively load custom .vimrc
" {{{
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
        exe 'source' ../../../.vim.custom
    elseif filereadable("../../../../.vim.custom")
        exe 'source' ../../../../.vim.custom
    elseif filereadable("../../../../../.vim.custom")
        exe 'source' ../../../../../.vim.custom
    elseif filereadable("../../../../../../.vim.custom")
        exe 'source' ../../../../../../.vim.custom
    elseif filereadable("../../../../../../../.vim.custom")
        exe 'source' ../../../../../../../.vim.custom
    elseif filereadable("../../../../../../../../.vim.custom")
        exe 'source' ../../../../../../../../.vim.custom
    endif
endfunction
"}}}
