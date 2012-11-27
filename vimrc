call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

set t_Co=256

set nocompatible
set ruler
set number
set autoindent
set shiftwidth=4
set nowrap
set textwidth=79
set formatoptions=qrn1

set laststatus=2
let g:Powerline_symbols = 'unicode'
" disable php auto folding
let g:DisableAutoPHPFolding = 1


set diffopt=filler
set diffopt+=iwhite
set hidden
set encoding=utf-8

set tabstop=4
set expandtab


set wildmenu
set wildmode=longest,list,full

set showcmd             " display incomplete commands

set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching
set smartcase           " no ignorecase if Uppercase char present

set visualbell t_vb=    " turn off error beep/flash
set novisualbell        " turn off visual bell

set backspace=indent,eol,start  " make that backspace key work the way it

"  space bar centers screen on current line,
" also center screen when jumping to next / prev search term
nmap <space> zz
nmap n nzz
nmap N Nzz

imap jk <Esc>

filetype plugin on
filetype plugin indent on

syntax enable
let php_sql_query=1

" make xml docs tidy
au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"


"if has("mouse")
"    set mouse=a
"endif


command WQ wq
command Wq wq
command W w
command Q q


noremap <C-h> :bprev<CR>
noremap <C-l> :bnext<CR>
noremap <C-k> <C-^>

"cntrl -J to split text to right of cursor onto new line and indent
nnoremap <C-J> i<CR><Esc>==k$

" line numbers
highlight LineNr ctermfg=grey ctermbg=black

" perl like regex searches
nnoremap / /\v
vnoremap / /\v

nnoremap <C-i> :set hls!<CR>

" use global substitute by default ie, s/all/thethings/g
set gdefault

" Disable arrow key nav,
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" Line nav ignores line wraps
nnoremap j gj
nnoremap k gk

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

imap <F7> <C-o>:setlocal spell! spelllang=en_us<CR>


map <F7> :setlocal spell! spelllang=en_us<CR>

map <Leader>o :call HandleURI()<CR><CR>
function! HandleURI()
    let s:uri = matchstr(getline("."), '[a-z]*:\/\/[^ >,;:]*')
    echo s:uri
    if s:uri != ""
        exec "!open \"" . s:uri . "\""
    else
        echo "No URI found in line."
    endif
endfunction
set cursorcolumn
set cursorline
"
hi CursorLine   ctermbg=white ctermbg=lightblue
hi CursorColumn ctermbg=white ctermbg=lightblue
nnoremap <Leader>h :set cursorline! cursorcolumn!<CR>

nmap <leader>js :!python -m json.tool<CR>


nmap <Leader>n :NERDTreeToggle<CR>
nmap <Leader>x :close<CR>
" print date
nmap <Leader>d :r!date "+\%Y.\%m.\%d"<CR>kdd
nmap <Leader>cd :cd %:p:h<CR>

nmap <Leader>vd :VCSDiff <CR>
nmap <Leader>vc :VCSCommit <CR>

nmap <leader>pu :wa\|!phpunit %<cr>



" select put text, via http://stackoverflow.com/a/4775281/955926
nnoremap <expr> gV "`[".getregtype(v:register)[0]."`]"

"nnoremap <F8> :setl noai nocin nosi inde=<CR>

" hide / show line numbers on active / inactive windows
augroup ToggleNumbers
        autocmd!
        autocmd WinEnter * set number
        autocmd WinLeave * set nonumber
augroup END


set clipboard=unnamed
"bracketd paste mode
"http://stackoverflow.com/questions/5585129/pasting-code-into-terminal-window-into-vim-on-mac-os-x
if &term =~ "xterm.*"
    let &t_ti = &t_ti . "\e[?2004h"
    let &t_te = "\e[?2004l" . &t_te
    function XTermPasteBegin(ret)
        set pastetoggle=<Esc>[201~
        set paste
        return a:ret
    endfunction
    map <expr> <Esc>[200~ XTermPasteBegin("i")
    imap <expr> <Esc>[200~ XTermPasteBegin("")
endif


set background=dark        " adapt colors for background
colorscheme xoria256


let g:syntastic_auto_jump=1
let g:syntastic_mode_map = { 'mode': 'passive'}

noremap <leader>sc :SyntasticCheck<cr>



  "nmap <Leader>a= :Tabularize /= <CR>
  "vmap <Leader>a= :Tabularize /= <CR>
  "nmap <Leader>a: :Tabularize /:\zs<CR>
  "vmap <Leader>a: :Tabularize /:\zs<CR>
  "nmap <Leader>a> :Tabularize /=><CR>
  "vmap <Leader>a> :Tabularize /=><CR>



let g:indent_guides_start_level = 2
let g:indent_guides_guide_size  = 1

" Strips the trailing whitespace from a file
" http://sartak.org/2011/03/end-of-line-whitespace-in-vim.html
function! <SID>StripTrailingWhitespaces()
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    %s/\s\+$//e
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap <silent> <Leader><space> :call <SID>StripTrailingWhitespaces()<CR>

"highligh trailing whitespace
autocmd InsertEnter * syn clear EOLWS | syn match EOLWS excludenl /\s\+\%#\@!$/
autocmd InsertLeave * syn clear EOLWS | syn match EOLWS excludenl /\s\+$/
highlight EOLWS ctermbg=red guibg=red


source ~/.vim/dbconnections

