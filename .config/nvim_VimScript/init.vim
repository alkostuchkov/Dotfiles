"##############################################################################
" General settings
"##############################################################################
" set nocompatible " no vi-compatible (Nvim is always "nocompatible".)

" Automatic reloading config file (for NERDCommenter) -------------------------
autocmd! VimEnter * :source ~/.config/nvim/init.vim
autocmd VimEnter,TabEnter *.py,*.lua,*.html,*.css,*.txt :ColorHighlight
" Не автокомментировать новые линии при переходе на новую строку
autocmd BufEnter * set fo-=c fo-=r fo-=o
" autocmd! VimEnter * :redraw

" To ALWAYS use the clipboard for ALL operations (instead of '+' or '*') ------
" set clipboard+=unnamedplus

" Showing line numbers and length ---------------------------------------------
set number
set relativenumber
" set linespace=3
set wrap linebreak nolist  "Данная вариация работает как wrap,... но
" переносит строчки не посимвольно, а по словам
set textwidth=79   "width of document (used by gd)
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
" set autoindent   "при начале новой строки, отступ копируется из предыдущей
set smartindent

set mouse=a
set noexrc   "не читаем файл конфигурации из текущей директории
set showtabline=2   "постоянно выводим строку с табами
set tabpagemax=20  "максимальное количество открытых табов
set history=50
set undolevels=50
set noerrorbells "instead of beeping
set wildmenu   "красивое автодополнение
set cmdheight=2 "Give more space for displaying messages.
set scrolloff=3 "when scrolling, keep cursor 3 lines away from screen border
set showmatch "for brackets
highlight MatchParen cterm=underline ctermbg=Cyan ctermfg=none
highlight MatchParen gui=underline guibg=Cyan guifg=none

" Allow plugins by file type (required for plugins!) --------------------------
filetype plugin on
filetype indent on
" filetype plugin indent on

syntax on "Enable syntax highlighting

" remove ugly vertical lines on window division
" set fillchars+=vert:\

" Real programmers don't use TABs but spaces ----------------------------------
set tabstop=2
set softtabstop=2
set shiftwidth=2
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
set statusline+=\ HEX=%02.2B
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
" colorscheme ayu
" colorscheme darcula
" colorscheme memorycolor
" colorscheme OceanicNext
" colorscheme OceanicMaterial
colorscheme Everforest
" colorscheme gruvbox-material

"##############################################################################
" Plugins used by vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"##############################################################################
call plug#begin('~/.config/nvim/plugged')
    "#########################################
    " Code/project navigation
    "#########################################
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
    Plug 'vifm/vifm.vim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'DreamMaoMao/yazi.nvim'

    "#########################################
    " Code completion
    "#########################################
    Plug 'ycm-core/YouCompleteMe'

    "#########################################
    " Other
    "#########################################
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    Plug 'chrisbra/Colorizer'
    Plug 'luochen1990/rainbow'
    " Plug 'nvim-treesitter/nvim-treesitter'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

"##############################################################################
" NERDTree Settings
"##############################################################################
noremap <C-F12> :NERDTreeToggle<CR>

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
" ranbow Settings
"##############################################################################
"set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1

"##############################################################################
" Colorizer Settings
"##############################################################################
" :let g:colorizer_auto_filetype='css,html,py,lua'
" :let g:colorizer_auto_color = 1

"##############################################################################
" YouCompleteMe Settings
"##############################################################################
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:python3_host_prog = '~/Projects/Python/Virtualenvironments/poetry_venvs/py3.10.x_pynvim/.venv/bin/python3'
" :nnoremap fd  :YcmCompleter GoToDefinition<CR>
" :nnoremap bb <C-o>
" let g:loaded_youcompleteme = 1
" let g:ycm_global_ycm_extra_conf = '~/.ycm_extra_conf.py'
" let g:ycm_extra_conf_globlist = ['!~/*']
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_min_num_of_chars_for_completion = 1

" for python
" let g:ycm_semantic_triggers = {'python': ['re!from\s+\S+\s+import\s']}

"##############################################################################
" Mappings
"##############################################################################
" <Leader> key ----------------------------------------------------------------
" let mapleader = " "
let mapleader = " "
let maplocalleader = " "

" Removes highlight of your last search ---------------------------------------
noremap <C-c>h :nohlsearch<CR>
vnoremap <C-c>h :nohlsearch<CR>
inoremap <C-c>h :nohlsearch<CR>

" Bind Ctrl+<movement> keys to move around the windows ------------------------
noremap <C-M-j> <C-w>j
noremap <C-M-k> <C-w>k
noremap <C-M-l> <C-w>l
noremap <C-M-h> <C-w>h
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
nnoremap <Leader>ev :tabnew ~/.config/nvim/init.vim<CR>
nnoremap <Leader>sv :source ~/.config/nvim/init.vim<CR>
nnoremap <Leader>eg :tabnew ~/.config/nvim/ginit.vim<CR>
nnoremap <Leader>sg :source ~/.config/nvim/ginit.vim<CR>

nnoremap <Leader>gy :Yazi<CR>

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
" Save
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>a

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

" Like in a terminal
" Go to BOL and EOL -----------------------------------------------------------
inoremap <C-a> <ESC>I
inoremap <C-e> <ESC>A
" nnoremap <C-a> 0
" nnoremap <C-e> $

" Delete to EOL ---------------------------------------------------------------
nnoremap <C-k> D$
inoremap <C-k> <ESC> D$a

" Delete to BOL ---------------------------------------------------------------
nnoremap <C-u> d0
inoremap <C-u> <ESC> d0i

" Movements -------------------------------------------------------------------
" By a char
inoremap <C-f> <ESC> la
inoremap <C-b> <ESC> hi
" By a word
inoremap <M-f> <ESC> wa
inoremap <M-b> <ESC> bi

" Deleting --------------------------------------------------------------------
" By a char
inoremap <C-d> <ESC> xi
" By a word
inoremap <C-w> <ESC> dbi
inoremap <M-d> <ESC> dea

" Return from insert mode to normal -------------------------------------------
inoremap jj <ESC>
" inoremap <M-;> <ESC>

" Insert a new line above/below -----------------------------------------------
nnoremap <M-a> O<Esc>
nnoremap <M-Enter> o<Esc>
inoremap <M-a> <Esc>O
inoremap <M-Enter> <Esc>o

" Aligning --------------------------------------------------------------------
" left
inoremap <C-c>l <Esc>:left<CR>a
nnoremap <C-c>l :left<CR>
" right
inoremap <C-c>r <Esc>:right<CR>a
nnoremap <C-c>r :right<CR>
" center
" inoremap <C-c>c <Esc>:center<CR>a
" nnoremap <C-c>c :center<CR>

nnoremap Q <nop>
nnoremap <Enter> <nop>

" Switching colorscheme -------------------------------------------------------
" let g:oeanic_next_terminal_italic = 1
" let g:palenight_terminal_italics=1
" let g:oceanic_italic_comments = 1
" let g:tokyonight_enable_italic = 1
" let g:tokyonight_style = 'night' " available: night, storm
" let g:solarized_termcolors=256
map <F1> :colorscheme OceanicNext<CR>
map <F2> :colorscheme gruvbox<CR>
map <F3> :colorscheme Everforest<CR>
map <F4> :colorscheme palenight<CR>
map <F5> :colorscheme tokyonight<CR>
map <F6> :colorscheme ayu<CR>
map <F7> :colorscheme onedark<CR>
map <F8> :colorscheme darcula<CR>
map <F9> :colorscheme memorycolor<CR>
" map <F9> :colorscheme base16-flat_Cobalt2<CR>
" colorscheme predawn
" colorscheme nord
" colorscheme ayu
" colorscheme oceanicnext
" colorscheme material-theme
" colorscheme onehalfdark
" colorscheme solarized
" colorscheme cobalt2

" Copy/Cut/Past from/to system buffer -----------------------------------------
vnoremap <C-x> "+d
vnoremap <C-c> "*y :let @+=@*<CR>
map <C-p> "+p

" Highlight hex colors toggle -------------------------------------------------
noremap <F12> :ColorToggle<CR>

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

