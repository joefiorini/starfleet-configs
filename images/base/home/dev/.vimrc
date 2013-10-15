" setup Pathogen
call pathogen#helptags()
call pathogen#infect()

set nocompatible              "don't need to keep compatibility with Vi

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

"Set colorscheme with options
let g:solarized_termcolors=256
let g:solarized_termtrans=1
colorscheme solarized         "use a colorscheme that's cli friendly
set background=dark           "make vim use colors that look good on a dark background

syntax on                     "turn on syntax highlighting

set showcmd                   "show incomplete cmds down the bottom
set showmode                  "show current mode down the bottom

set splitright                "open vsplits to the right

set incsearch                 "find the next match as we type the search
set hlsearch                  "hilight searches by default
set ignorecase                "case insesitive searches
set smartcase                 "case sensitive search if term contains uppercase characters
set smartindent               "auto indent when adding a curly brace, etc.


set nowrap                    "dont wrap lines
set linebreak                 "wrap lines at convenient points

set shiftwidth=2              "number of spaces to use in each autoindent step
set tabstop=2                 "two tab spaces
set softtabstop=2             "number of spaces to skip or insert when <BS>ing or <Tab>ing
set expandtab                 "spaces instead of tabs for better cross-editor compatibility
set cindent                   "recommended seting for automatic C-style indentation
set autoindent                "automatic indentation in non-C files
set wrap                      "wrap entire words, don't break them; much easier to read!

set mouse=a                   "enable the mouse; I like being able to scroll

set hidden                    "allow hiding buffers with unsaved changes

set scrolloff=3               "add some breathing room at top and bottom of screen

set wildmenu                  "make tab completion act more like bash
set wildmode=list:longest
set completeopt=menu,longest

set switchbuf=useopen         "don't reopen already opened buffers

set cmdheight=2               "make the command line a little taller to hide "press enter to viem more" text

set shell=/bin/sh             "make sure Vim sources my .zshrc

set ofu=syntaxcomplete#Complete "Turn on omnicomplete

au FileType json setlocal equalprg=python\ -m\ json.tool

"custom status line (across the bottom of the screen)
" See http://vimdoc.sourceforge.net/htmldoc/options.html#'statusline' for more
" details on statusline
set statusline=%F%m%r%h%w\ [TYPE=%Y]\ \ \ \ \ \ \ \ \ \ \ \ [POS=%2l,%2v][%p%%]\ \ \ \ \ \ \ \ \ \ \ \ [LEN=%L]
set laststatus=2

set grepprg=ack
function! Ack(args)
    let grepprg_bak=&grepprg
    set grepprg=ack\ -H\ --nocolor\ --nogroup
    execute "silent! grep " . a:args
    botright copen
    let &grepprg=grepprg_bak
endfunction

command! -nargs=* -complete=file Ack call Ack(<q-args>)

"set the kind of invisible characters to show
" for tabs, trailing spaces, non breaking spaces
set lcs=tab:→.,trail:•,nbsp:%

"show invisible characters. Use "set nolist" to turn off.
set list

"don't clutter my directories with swap files
set nobackup
set nowritebackup
set noswapfile


"----------------------
"   Key Mappings      |
"----------------------

" Make Y consistent with C and D
nnoremap Y y$

" Make <c-l> clear the highlight as well as redraw
nnoremap <C-L> :nohls<CR><C-L>

" Make <c-l> print the path to file being edited in ex mode
cmap <c-l> <c-r>=expand("%")<CR>

" <C-c> in insert mode doesn't fire insertleave, which is a problem in <C-v>
"   mode; this makes <C-c> fire insertleave
inoremap <C-c> <ESC>

" Rerun the last command
nnoremap <Leader>. :<Up><CR>

" Make omnicomplete a bit easier
imap <Leader>o <C-x><C-o>

" Buffer navigation
map <Leader><Leader> <C-^>
map <Leader>] :bnext<CR>
map <Leader>[ :bprev<CR>
map <Leader>ls :buffers<CR>

" Finally quit hitting :Q instead of :q
cmap Q<CR> q

cmap <C-T> <C-B>map <Leader>t :<C-E><lt>CR>

" For unimpaired plugin
nmap <C-j> ]e
nmap <C-k> [e
vmap <C-j> ]egv
vmap <C-k> [egv

" from Gary Bernhardt: don't close splits when deleting buffers
cnoremap <expr> bd (getcmdtype() == ':' ? 'Bclose' : 'bd')

" Quickly delete trailing spaces and tab characters
fun! ClearAllTrailingSpaces()
  %s/\s\+$//
  %s/\t/  /g
endfun

" and map it to <Leader>c
nmap <Leader>c :call ClearAllTrailingSpaces()<CR>

function! ScrubQuotes()
  %s/“/"/g
  %s/”/"/g
  %s/‘/'/g
  %s/’/'/g
endfunction

nmap <LEADER>g :call ScrubQuotes()<CR>

" Make ',e' (in normal mode) give a prompt for opening files
" in the same dir as the current buffer's file.
cnoremap %% <C-R>=expand("%:h")<cr>/
map <leader>e :e %%
map <leader>a :tabe %%
map <leader>n :Rename 
map <leader>k :!mkdir -p %%

" Customizations to make tabular plugin easier to use from https://gist.github.com/287147
inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a

function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction

" Add Handlebars support to Vim Commentary
autocmd Syntax handlebars set commentstring={{!\ %s\ }}
