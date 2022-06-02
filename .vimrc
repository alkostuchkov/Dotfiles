"##############################################################################
" General settings
"##############################################################################
set nocompatible " no vi-compatible

" Automatic reloading config file (for NERDCommenter) -------------------------
autocmd! VimEnter * :source $MYVIMRC  
" autocmd! VimEnter * :redraw

" Showing line numbers and length ---------------------------------------------
set number
set relativenumber
" set linespace=3
set wrap linebreak nolist  "Данная вариация работает как wrap,... но
" переносит строчки не посимвольно, а по словам
set tw=79   "width of document (used by gd)
set fo-=t   "don't automatically wrap text when typing
set colorcolumn=80
highlight ColorColumn ctermbg=233
set cursorline     "highlight current line
set cursorcolumn   "highlight current column
set whichwrap=<,>,[,],h,l  "не останавливаться курсору на конце строки

set ttimeoutlen=20  "Понижаем задержку ввода escape последовательностей
let &t_SI.="\e[5 q"  "SI = режим вставки
let &t_SR.="\e[3 q"  "SR = режим замены
let &t_EI.="\e[1 q"  "EI = нормальный режим
"Где 1 - это мигающий прямоугольник
"2 - обычный прямоугольник
"3 - мигающее подчёркивание
"4 - просто подчёркивание
"5 - мигающая вертикальная черта
"6 - просто вертикальная черта

" Indents ---------------------------------------------------------------------
set autoindent   "при начале новой строки, отступ копируется из предыдущей
set smartindent

set noex   "не читаем файл конфигурации из текущей директории
set stal=2   "постоянно выводим строку с табами
set tpm=20  "максимальное количество открытых табов
set history=50
set undolevels=50
set noerrorbells "instead of beeping
set wildmenu   "красивое автодополнение
set cmdheight=2 "Give more space for displaying messages.
set scrolloff=3 "when scrolling, keep cursor 3 lines away from screen border

" Allow plugins by file type (required for plugins!) --------------------------
filetype plugin on
filetype indent on
filetype plugin indent on

syntax on "Enable syntax highlighting

" remove ugly vertical lines on window division
" set fillchars+=vert:\

" Real programmers don't use TABs but spaces ----------------------------------
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Search -----------------------------------------------------------------------
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable backup and swap files - they trigger too many events ----------------
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Show whitespaces and other symbols ------------------------------------------
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" set list

" Go to the last editing position ---------------------------------------------
" При редактировании файла всегда переходить на последнюю известную
" позицию курсора. Если позиция ошибочная - не переходим.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Statusline ------------------------------------------------------------------
set showmode   "показывать текущий режим
set showcmd   "показывать незавершенные команды в статусбаре
set laststatus=2   "always show statusline
"set statusline=%#title#%F%m%r%h%w\ %y%=[HEX=\%02.2B]\ [%{&encoding}]\ [%{&fileformat}]\ [POS=%l,%c,\ %p%%]\ [LEN=%L]      "формат строки состояния

set statusline=
set statusline+=%#DiffText# " :hi to choose the color
set statusline+=\ %M\ %F%r%h%w\ %y
set statusline+=%= " Right side settings
set statusline+=%#TabLineSel#
set statusline+=HEX=%02.2B
set statusline+=\ %{&encoding}[%{&fileformat}]
set statusline+=\ %l:%c/%L\ %p%%
set statusline+=\ [%n]

"##############################################################################
" Encoding
"##############################################################################
set encoding=utf8   "кодировка по дефолту
set termencoding=utf8   "Кодировка вывода на терминал
set fileencodings=utf8,cp1251,koi8r,cp866   "Возможные кодировки файлов (автоматическая перекодировка)

" Run commands in normal mode with switched cyrillic --------------------------
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" Переключение раскладок средствами Vim по Ctr+^ ------------------------------
set keymap=russian-jcukenwin
set iminsert=0  "Язык ввода при старте Вима - Английский
set imsearch=0  "Аналогично настраивается режим поиска

set autochdir  "текущий каталог всегда совпадает с содержимым активного окна
set browsedir=current "browsedir    "last", "buffer" or "current": which directory used for the file browser

" Show whitespaces by red color -----------------------------------------------
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

"##############################################################################
" Colorscheme and GUI Settings
"##############################################################################
if has("termguicolors")
    set termguicolors
else
    set t_Co=256
endif

set background=dark
colorscheme OceanicNext

" GUI -------------------------------------------------------------------------
set wak=no   "используем ALT как обычно, а не для вызова пункта меню
if has("gui_running")
    "убираем меню и тулбар
    set guioptions-=m
    set guioptions-=T
    "убираем скроллбары
    set guioptions-=r
    set guioptions-=l
    "используем консольные диалоги вместо графических
    set guioptions+=c
    "антиалиасинг для шревтоф
    set antialias
    "прячем курсор
    set mousehide
    "Так не выводятся ненужные escape последовательности в :shell
    set noguipty
    " set guifont=Source_Code_Pro:h13:cRUSSIAN:qDRAFT
    " set guifont=mplus\ Nerd\ Font\ 16.5
    " set guifont=Iosevka\ 16
    " set guifont=Cascadia\ Code\ PL\ SemiLight\ 17
    " set guifont=Cascadia\ Mono\ PL\ 16.5
    " set guifont=Recursive\ Mono\ Casual\ Static\ Medium\ 17
    set guifont=Recursive\ Mono\ Casual\ Static\ 16
endif

"##############################################################################
" Plugins used by vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"##############################################################################
call plug#begin('~/.vim/plugged')
    "#########################################
    " Code/project navigation
    "#########################################
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'vifm/vifm.vim'
    " Code and files fuzzy finder
    " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    " Plug 'junegunn/fzf.vim'

    "#########################################
    " Code completion
    "#########################################
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
    " Plug 'ycm-core/YouCompleteMe', { 'for': 'python' }
    Plug 'ycm-core/YouCompleteMe'
    Plug 'rust-lang/rust.vim'
    Plug 'ivanceras/rust-vim-setup'

    "#########################################
    " Other
    "#########################################
    " Plug 'gruvbox-community/gruvbox'
    " Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    " Plug 'etdev/vim-hexcolor'
    Plug 'ap/vim-css-color'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

"##############################################################################
" NERDTree Settings
"##############################################################################
noremap <F12> :NERDTreeToggle<CR>

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

"##############################################################################
" NERDCommenter Settings
"##############################################################################
map <Leader>/ <plug>NERDCommenterToggle
" map <C-c>/ <plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDCreateDefaultMappings = 0 " Cancel NERD's default mappings
" let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation

"##############################################################################
" rust.vim Settings
"##############################################################################
" :help :RustFmt
let g:rustfmt_autosave = 1

"##############################################################################
" YouCompleteMe Settings
"##############################################################################
" For Rust autocompletion
let g:ycm_rust_src_path="~/.config/nvim/Developer/rust-master/src/"
" :nnoremap fd  :YcmCompleter GoToDefinition<CR>
" :nnoremap bb <C-o>
" let g:loaded_youcompleteme = 1
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_extra_conf_globlist = ['!~/*']
" let g:ycm_python_binary_path = 'python3'
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_min_num_of_chars_for_completion = 1

" for python
" let g:ycm_semantic_triggers = {'python': ['re!from\s+\S+\s+import\s']}

"##############################################################################
" Mappings
"##############################################################################
" <Leader> key ----------------------------------------------------------------
" let mapleader = " "
let mapleader = ","
let maplocalleader = "\\"

" Let Meta key (Alt) to be usefull in terminal
let c='a'
while c <= 'z'
  exec "set <M-".c.">=\e".c
  exec "imap \e".c." <M-".c.">"
  let c = nr2char(1+char2nr(c))
endw

" Removes highlight of your last search ---------------------------------------
noremap <C-c>h :nohlsearch<CR>
vnoremap <C-c>h :nohlsearch<CR>
inoremap <C-c>h :nohlsearch<CR>

" Bind Ctrl+<movement> keys to move around the windows ------------------------
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
set splitbelow   "новое окно появляется снизу

" Resize windows --------------------------------------------------------------
noremap <Up> :resize +2<CR>
noremap <Down> :resize -2<CR>
noremap <Left> :vertical resize -2<CR>
noremap <Right> :vertical resize +2<CR>

inoremap <Up> <Esc>:resize +2<CR>a
inoremap <Down> <Esc>:resize -2<CR>a
inoremap <Left> <Esc>:vertical resize -2<CR>a
inoremap <Right> <Esc>:vertical resize +2<CR>a

" Switch file encoding --------------------------------------------------------
set wcm=<Tab>   "WTF? but all work
menu Encoding.cp1251     :e ++enc=cp1251<CR>
menu Encoding.koi8-r     :e ++enc=koi8-r<CR>
menu Encoding.cp866      :e ++enc=cp866<CR>
menu Encoding.utf-8      :e ++enc=utf-8 <CR>
noremap <F11> :emenu Encoding.<TAB>

" Edit & Apply changes in config file -----------------------------------------
nnoremap <Leader>ev :tabnew $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Move line up/down -----------------------------------------------------------
nnoremap <M-k> :m .-2<CR>==
nnoremap <M-j> :m .+1<CR>==
inoremap <M-k> <Esc>:m .-2<CR>==gi
inoremap <M-j> <Esc>:m .+1<CR>==gi
vnoremap <M-k> :m '<-2<CR>gv=gv
vnoremap <M-j> :m '>+1<CR>gv=gv

" Easier moving of code blocks (doesn't lose selection) -----------------------
vnoremap < <gv
vnoremap > >gv

" Execute Python script -------------------------------------------------------
nnoremap <F10> <Esc>:w<CR>:! python3 %<CR>
inoremap <F10> <Esc>:w<CR>:! python3 %<CR>a

" Open, Save, Update & Quit ---------------------------------------------------
nnoremap <C-o> :browse confirm e <CR>
" Close buffer without saving
map <Esc><Esc> :q!<CR>
" Quit all windows without saving
nnoremap <Leader>q :qa!<CR>

" Tabs ------------------------------------------------------------------------
" Open new tab
nnoremap <Leader>tn :tabnew<CR>
inoremap <Leader>tn <Esc>:tabnew<CR>a

" Switch between tabs
" nnoremap <F8> :tabfirst <CR>
" nnoremap <F9> :tablast <CR>
nnoremap <M-{> :tabfirst <CR>
nnoremap <M-}> :tablast <CR>
nnoremap <M-[> :tabp <CR>
nnoremap <M-]> :tabn <CR>
nnoremap <M-1> 1gt
nnoremap <M-2> 2gt
nnoremap <M-3> 3gt
nnoremap <M-4> 4gt
nnoremap <M-5> 5gt
nnoremap <M-6> 6gt
nnoremap <M-7> 7gt
nnoremap <M-8> 8gt
nnoremap <M-9> 9gt

" Go to BOL and EOL -----------------------------------------------------------
inoremap <M-h> <ESC>0i
inoremap <M-l> <ESC>$a
nnoremap <S-h> 0
nnoremap <S-l> $

" Return from insert mode to normal -------------------------------------------
inoremap jj <ESC>
" inoremap <M-;> <ESC>

" New line --------------------------------------------------------------------
inoremap nl <END><CR>

" Aligning --------------------------------------------------------------------
" center
" inoremap <C-c>c <Esc>:center<CR>a
" nnoremap <C-c>c :center<CR>
" left
inoremap <C-c>l <Esc>:left<CR>a
nnoremap <C-c>l :left<CR>
" right
inoremap <C-c>r <Esc>:right<CR>a
nnoremap <C-c>r :right<CR>

nnoremap Q <nop>

" Switching colorscheme -------------------------------------------------------
" let g:oeanic_next_terminal_italic = 1
" let g:palenight_terminal_italics=1
" let g:oceanic_italic_comments = 1
" let g:tokyonight_enable_italic = 1
" let g:tokyonight_style = 'night' " available: night, storm
" let g:solarized_termcolors=256
map <F1> :colorscheme OceanicNext<CR>
map <F2> :colorscheme gruvbox<CR>
map <F3> :colorscheme gruvbox-material<CR>
map <F4> :colorscheme palenight<CR>
map <F5> :colorscheme tokyonight<CR>
map <F6> :colorscheme onehalfdark<CR>
map <F7> :colorscheme onedark<CR>
map <F8> :colorscheme darcula<CR>
map <F9> :colorscheme memorycolor<CR>
" map <F9> :colorscheme base16-flat_Cobalt2<CR>
" colorscheme predawn
" colorscheme nord
" colorscheme ayu
" colorscheme oceanicnext
" colorscheme material-theme
" colorscheme onedark
" colorscheme solarized
" colorscheme cobalt2

" Несколько удобных биндингов для с, c++, java, python ------------------------
augroup filetype_coding
    autocmd!
    au FileType python inoremap :: <END>:<CR>
    au FileType python inoremap (: ():<CR>
    au FileType python inoremap #ifn if __name__ == "__main__":<CR>
    au FileType python inoremap #t # TODO:  <Esc>i
    au FileType python inoremap #f # FIXME:  <Esc>i
    " au FileType c,cpp,cc,h,java inoremap {<CR> {<CR>}<Esc>O
    " au FileType c,cpp,cc,h,java inoremap #M int main(int argc, char * argv[])<CR>{<CR>return 0;<CR>}<CR><Esc>2kO
    " au FileType c,cpp,cc,h,java inoremap #m int main()<CR>{<CR>return 0;<CR>}<CR><Esc>2kO
    " au FileType c,cpp,cc,h,java inoremap #d #define
    " au FileType c,cpp,cc,h,java inoremap #e #endif /*  */<Esc>hhi
    " au FileType c,cpp,cc,h,java inoremap #" #include ""<Esc>i
    " au FileType c,cpp,cc,h,java inoremap #< #include <><Esc>i
    " au FileType c,cpp,cc,h,java inoremap #f /* FIXME:  */<Esc>hhi
    " au FileType c,cpp,cc,h,java inoremap #t /*TODO:  */<Esc>hhi
    " au FileType c,cpp,cc,h,java inoremap ;; <END>;<CR>
    " au FileType c,cpp,cc,h,java inoremap (; ();<CR>
    " au FileType c,cpp,cc,h,java inoremap ({ () {<CR>}<Esc>O
    " au FileType c,cpp,cc,h,java inoremap /*<Space> /*  */<Esc>3ha
    " au FileType c,cpp,cc,h,java inoremap ` <END>;
    " au FileType c,cpp,cc,h,java inoremap ' ''<Left>
    " au FileType c,cpp,cc,h,java inoremap " ""<Left>
    " au FileType c,cpp,cc,h,java inoremap ( ()<Left>
    " au FileType c,cpp,cc,h,java inoremap [ []<Left>
    " au FileType c,cpp,cc,h,java,python inoremap nl <END><CR>
    " au FileType c,cpp,cc,h,java,python inoremap ~ <END>:
augroup END

" Copy/Cut/Past from/to system buffer -----------------------------------------
vnoremap <C-x> "+d
vnoremap <C-c> "*y :let @+=@*<CR>
map <C-p> "+p

" Surround the selection in "", '', () ----------------------------------------
" vnoremap <Leader>" <ESC>`<i"<ESC>`>la"<ESC>
" vnoremap <Leader>' <ESC>`<i'<ESC>`>la'<ESC>
" vnoremap <Leader>( <ESC>`<i(<ESC>`>la)<ESC>

