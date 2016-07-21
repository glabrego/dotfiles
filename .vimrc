"".vimrc

set nocompatible                   " don't need to maintain compatibility with vi

" plugin management
"
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-vinegar'
Plugin 'kien/ctrlp.vim'

Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-commentary'
Plugin 'Raimondi/delimitMate'
Plugin 'SirVer/UltiSnips'
Plugin 'honza/vim-snippets'

Plugin 'tpope/vim-rails'
Plugin 'scrooloose/nerdtree'

Plugin 'mileszs/ack.vim'
Plugin 'rking/ag.vim'

Plugin 'majutsushi/tagbar'
Plugin 'godlygeek/tabular'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'airblade/vim-gitgutter'

call vundle#end()
filetype plugin indent on

" basic settings
"
set incsearch                      " show match for partly typed search command
set ignorecase                     " ignore case when using a search pattern
set smartcase                      " override 'ignorecase' when pattern has upper case characters

set scrolloff=5                    " number of screen lines to show around the cursor
set nowrap                         " don't wrap long lines
set lazyredraw                     " don't redraw while executing macros
set list                           " show invisibles
set listchars=tab:»·,trail:·       " show extra space characters
set number                         " show the line number for each line
set relativenumber                 " show the relative line number for each line
set numberwidth=5                  " number of columns to use for the line number

syntax enable                      " enable syntax highlighting
colorscheme badwolf                " set default colorscheme

" some colorscheme adjustments
highlight VertSplit ctermfg=235 ctermbg=235

set hlsearch                       " highlight all matches for the last used search pattern
" set cursorline                     " highlight the screen line of the cursor

set laststatus=2                   " always use a status line for the last window
set hidden                         " don't unload a buffer when no longer shown in a window
set splitbelow                     " a new window is put below the current one
set splitright                     " a new window is put right of the current one

set ttyfast                        " terminal connection is fast

set showcmd                        " show (partial) command keys in the status line
set noshowmode                     " don't display the current mode in the status line
set ruler                          " show cursor position below each window
set visualbell                     " use a visual bell instead of beeping

set clipboard=unnamed              " use the * register

set backspace=start,eol,indent     " allow backspace over everything when in insert mode
set showmatch                      " when inserting a bracket, briefly jump to its match
set matchtime=2                    " tenth of a second to show a match for 'showmatch'

set expandtab                      " expand <tab> to spaces in insert mode
set shiftwidth=2                   " number of spaces used for each step of (auto)indent
set softtabstop=2                  " number of spaces to insert for a <tab>

set ttimeout                       " allow timing out halfway into a key code
set ttimeoutlen=100                " time in msec for 'ttimeout'

set nowritebackup                  " don't write a backup file before overwriting a file
set nobackup                       " don't keep a backup after overwriting a file
set autoread                       " automatically read a file when it was modified outside of vim

set noswapfile                     " don't use a swap file for this buffer

set history=100                    " how many command lines are remembered

" key mappings & plugin-specific settings
"
" set space as leader
map <space> <leader>

" disable arrow keys
nnoremap <Left> :echoe "use h"<CR>
nnoremap <Down> :echoe "use j"<CR>
nnoremap <Up> :echoe "use k"<CR>
nnoremap <Right> :echoe "use l"<CR>

" quicker split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" " Clear highlight
nmap \q :nohlsearch<CR>

" open a new empty buffer
nmap <leader>N :enew<cr>

" move to the next buffer
nmap <leader>l :bnext<CR>

" move to the previous buffer
nmap <leader>h :bprevious<CR>

" close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>

" show all open buffers and their status
nmap <leader>bl :ls<CR>

"Toggles NERDTree
nmap <silent> <Leader>n :NERDTreeToggle<CR>

"Tagbar
nmap <silent> <Leader>tt :TagbarToggle<CR>

" index tags
nnoremap <Leader>ct :!ctags -R .<CR>

" ENTER to remove any search highlighting
nnoremap <silent> <CR> :nohl<CR><CR>

" ctrlp
nnoremap <silent> <Leader>f :CtrlP<CR>
nnoremap <silent> <Leader>b :CtrlPBuffer<CR>
nnoremap <silent> <Leader>r :CtrlPMRUFiles<CR>
nnoremap <silent> <Leader>t :CtrlPTag<CR>

if executable('ag')
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " use ag in ctrlp for listing files
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that ctrlp doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" airline
let g:airline_left_sep = '>'                      " set left separator
let g:airline_right_sep = '<'                     " set right separator
let g:airline#extensions#tabline#enabled = 1      " enable list of buffers
let g:airline#extensions#tabline#fnamemod = ':t'  " show filename only
let g:airline#extensions#tagbar#enabled = 0       " disable tagbar integration (speed up startup time)
let g:airline_detect_modified=1

" make ultisnips and youcompleteme play well together
let g:ycm_key_list_select_completion=['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion=['<C-p>', '<Up>']

let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" autocmd
"
if has("autocmd")
  autocmd BufWritePre * :%s/\s\+$//e              " remove trailing spaces on save
endif

if has("gui")
    "tell the term has 256 colors
    set t_Co=256

    if has("gui_gnome")
        set term=gnome-256color
    else
        set term=xterm-256color
        set guitablabel=%M%t
    endif
else
    "dont load csapprox if there is no gui support - silences an annoying warning
    let g:CSApprox_loaded = 1
endif

"" .vimrc ends here
