"".vimrc

" vim-plug (https://github.com/junegunn/vim-plug) settings
" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" plugin management
call plug#begin()
 Plug 'vim-airline/vim-airline'        " Status bar for vim
 Plug 'vim-airline/vim-airline-themes' " Status bar themes for vim
 Plug 'tpope/vim-surround'             " Edit surroundings of code, trading parentheses for brackets and etc
 Plug 'tpope/vim-commentary'           " Comment code faster
 Plug 'Raimondi/delimitMate'           " Auto-close parentheses, brackets and etc
 Plug 'godlygeek/tabular'              " Auto text alignment
 Plug 'christoomey/vim-tmux-navigator' " Better vim-tmux integration for pane navigation
 Plug 'glabrego/vim-colorschemes'      " My updated version of flazz/vim-colorschemes
 Plug 'elixir-lang/vim-elixir'         " Elixir syntax support
 Plug 'scrooloose/nerdtree'            " File and directories navigation
 Plug 'fatih/vim-go'                   " Support for Golang
 Plug 'elixir-lang/vim-elixir'         " Support for Elixir lang
 Plug 'slashmili/alchemist.vim'        " Integration with Elixir tools
 Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
 Plug 'junegunn/fzf.vim'
 Plug 'tpope/vim-repeat'               " Enable '.' to repeat plugins commands
 Plug 'tmhedberg/matchit'
call plug#end()

filetype plugin indent on

" basic settings
filetype off
set nocompatible                   " don't need to maintain compatibility with vi
set incsearch                      " show match for partly typed search command
set ignorecase                     " ignore case when using a search pattern
set smartcase                      " override 'ignorecase' when pattern has upper case characters
set scrolloff=3                    " number of screen lines to show around the cursor
set lazyredraw                     " don't redraw while executing macros
set list                           " show invisibles
set listchars=tab:»·,trail:·       " show extra space characters
set number                         " show the line number for each line
set relativenumber
set numberwidth=5                  " number of columns to use for the line number
set inccommand=nosplit             " show a preview of strings manipulation

" wrap and linebreak settings
set showbreak=↪                    " set showbreak icon
set wrap
set linebreak
set nolist
syntax enable                      " enable syntax highlighting

" colorscheme settings and adjustments
colorscheme solarized              " set default colorscheme
set background=light

set hlsearch                       " highlight all matches for the last used search pattern
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

" double ESC to save
map <Esc><Esc> :w<CR>

" shorcuts to my vimrc
nmap <leader>vr :tabe $MYVIMRC<cr>
nmap <leader>so :source $MYVIMRC<cr>

" navigate wrapped lines
nmap k gk
nmap j gj

" disable arrow keys
nnoremap <Left> :echoe "use h"<CR>
nnoremap <Down> :echoe "use j"<CR>
nnoremap <Up> :echoe "use k"<CR>
nnoremap <Right> :echoe "use l"<CR>

" quicker split navigation
nnoremap <leader>j <C-W><C-J>
nnoremap <leader>k <C-W><C-K>
nnoremap <leader>l <C-W><C-L>
nnoremap <leader>h <C-W><C-H>
nnoremap <leader>= <C-W><C-=>
nnoremap <leader>o <C-W><C-o>

" quicker insert mode navigation
inoremap <C-H> <Left>
inoremap <C-L> <Right>
inoremap <C-J> <Down>
inoremap <C-K> <Up>

" Clear highlight
nmap <leader>q :nohlsearch<CR>

" open a new empty buffer
nmap <leader>N :enew<cr>

" open new tab
nmap <leader>t :tabnew<cr>

" move between tabs
nmap <leader>l :bnext<cr>
nmap <leader>h :bprevious<cr>

" close the current buffer and move to the previous one
nmap <leader>bq :bp <BAR> bd #<CR>

" show all open buffers and their status
nmap <leader>bl :ls<CR>

"Toggles NERDTree
nmap <silent> <Leader>n :NERDTreeToggle <CR>

" NERDTree settings
let NERDTreeQuitOnOpen = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" ENTER to remove any search highlighting
nnoremap <silent> <CR> :nohl<CR><CR>

" RipGrep
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>p :Find<CR>

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" Map SwitchRelativeNumber
nmap <silent> - :call SwitchRelativeNumber()<CR>

" Switch between relativenumber and normal number
function SwitchRelativeNumber()
  set rnu!
endfunction

" Map for SwitchBackgroundColor
nmap <silent> _ :call SwitchBackgroundColor()<CR>

" Switch between light and dark themes
function SwitchBackgroundColor()
  if &background ==  'dark'
    set background=light
  else
    set background=dark
  endif
endfunction

" RipGrep

if executable('ag')
  " use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " use ag in ctrlp for listing files
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that ctrlp doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" airline theme settings
let g:airline_theme='solarized'                  " set airline theme
let g:airline_powerline_fonts = 1                 " enable powerline symbols
let g:airline#extensions#tabline#enabled = 1      " enable list of buffers
let g:airline#extensions#tabline#fnamemod = ':t'  " show filename only
let g:airline#extensions#tagbar#enabled = 0       " disable tagbar integration (speed up startup time)
let g:airline_detect_modified=1

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

" alternate vim cursor when using tmux with iterm
if exists('$ITERM_PROFILE')
  if exists('$TMUX')
    let &t_SI = "\<Esc>[3 q"
    let &t_EI = "\<Esc>[0 q"
  else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
  endif
end

"" .vimrc ends here
