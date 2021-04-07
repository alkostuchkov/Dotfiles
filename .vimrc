"###############################################################################
" General settings
"###############################################################################
set nocompatible " no vi-compatible
" let &keywordprg=':help'

" let &pythonthreedll='C:\Python34\libs\python34.dll'

" Automatic reloading .vimrc
autocmd! VimEnter * :source $MYVIMRC  "for NERDCommenter

" Showing line numbers and length
set number
set relativenumber
set wrap linebreak nolist  "Данная вариация работает как wrap,... но переносит строчки не посимвольно, а по словам
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

" Indents
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

" Allow plugins by file type (required for plugins!)
filetype plugin on
filetype indent on
" filetype plugin indent on

syntax on "Enable syntax highlighting

" remove ugly vertical lines on window division
" set fillchars+=vert:\

" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase

" Disable backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile

" Show whitespaces and other symbols
" set listchars=eol:¬,tab:>·,trail:~,extends:>,precedes:<,space:␣
" set list

" При редактировании файла всегда переходить на последнюю известную
" позицию курсора. Если позиция ошибочная - не переходим.
autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Statusline
set showmode   "показывать текущий режим
set showcmd   "показывать незавершенные команды в статусбаре
set laststatus=2   "always show statusline
"set statusline=%#title#%F%m%r%h%w\ %y%=[HEX=\%02.2B]\ [%{&encoding}]\ [%{&fileformat}]\ [POS=%l,%c,\ %p%%]\ [LEN=%L]      "формат строки состояния

" Encoding
set encoding=utf8   "кодировка по дефолту
set termencoding=utf8   "Кодировка вывода на терминал
set fileencodings=utf8,cp1251,koi8r,cp866   "Возможные кодировки файлов (автоматическая перекодировка)

" Run commands in normal mode with switched cyrillic
set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" Переключение раскладок средствами Vim по Ctr+^
set keymap=russian-jcukenwin
set iminsert=0  "Язык ввода при старте Вима - Английский
set imsearch=0  "Аналогично настраивается режим поиска

set autochdir  "текущий каталог всегда совпадает с содержимым активного окна
set browsedir=current "browsedir    "last", "buffer" or "current": which directory used for the file browser

" Show whitespaces by red color
" MUST be inserted BEFORE the colorscheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

"###############################################################################
" Colorscheme and GUI Settings
"###############################################################################
set t_Co=256
set background=dark
colorscheme gruvbox
" colorscheme predawn
" colorscheme monokai
" let g:solarized_termcolors=256
" colorscheme solarized
" colorscheme darcula

" GUI
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
    " set gfn=JetBrains_Mono_Regular:h12:cRUSSIAN:qDRAFT
    " set guifont=Source\ Code\ Pro\ 14
    " set guifont=mononoki\ 14.5
    " set guifont=Fira\ Code\ Light\ 14

    " set guifont=Operator\ Mono\ Light\ 16
    " set guifont=Trim\ Mono\ Regular\ 13

    " set guifont=Menlo\ for\ Powerline\ 13.5
    " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 13
    " set guifont=MesloLGS\ NF\ 13
    " set guifont=Consolas\ for\ Powerline\ 14.5
    " set guifont=SF\ Mono\ 13.5
    " set guifont=RobotoMono\ Nerd\ Font\ 14
    " set guifont=Hack\ 13.5
    " set guifont=UbuntuMono\ Nerd\ Font\ 16
    " set guifont=Sarasa\ Mono\ SC\ Nerd\ Light\ 15
    " set guifont=Iosevka\ Fixed\ SS12\ 15
    set guifont=Sarasa\ Mono\ SC\ Nerd\ 16
    " set guifont=JetBrainsMono\ Regular\ 14
    " set guifont=JetBrainsMonoNL\ Light\ 14
    " set guifont=SauceCodePro\ Nerd\ Font\ 16

    " set guifont=JetBrainsMono\ ExtraLight\ 14
    " set guifont=Monaco\ 13
    " set guifont=Ligamonacop\ 13
" else
    " colorscheme herald
endif

"###############################################################################
" Plugins used by vim
" Specify a directory for plugins
" - For Neovim: stdpath('data') . '/plugged'
" - Avoid using standard Vim directory names like 'plugin'
"###############################################################################
call plug#begin('~/.vim/plugged')
    "#########################################
    " Code/project navigation
    "#########################################
    Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

    " Code and files fuzzy finder
    " Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    " Plug 'junegunn/fzf.vim'

    " Consoles as buffers (neovim has its own consoles as buffers)
    " Plug 'rosenfeld/conque-term'
    " Vim-terminal
    " Plug 'tc50cal/vim-terminal'
    " XML/HTML tags navigation (neovim has its own)
    " Plug 'vim-scripts/matchit.zip'
    " Class/module browser
    " Plug 'majutsushi/tagbar'

    "#########################################
    " Code completion
    "#########################################
    " Plug 'davidhalter/jedi-vim'
    " Plug 'farfanoide/vim-kivy'
    " Plug 'pzxbc/vim-kv'
    " Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'ycm-core/YouCompleteMe', { 'do': './install.py' }
    " Plug 'ycm-core/YouCompleteMe', { 'for': 'python' }

    " Async autocompletion
    " Plug 'Shougo/deoplete.nvim'
    " Python autocompletion
    " Plug 'deoplete-plugins/deoplete-jedi'
    " Linters
    Plug 'neomake/neomake'

    "#########################################
    " Debugging
    "#########################################
    " Plug 'vim-vdebug/vdebug'

    "#########################################
    " Other
    "#########################################
    Plug 'gruvbox-community/gruvbox'
    " Plug 'itchyny/lightline.vim'
    Plug 'vim-airline/vim-airline'
    " Plug 'vim-airline/vim-airline-themes'
    Plug 'preservim/nerdcommenter'
    Plug 'tpope/vim-surround'
    " Plug 'gko/vim-coloresque'
    " Plug 'etdev/vim-hexcolor'
    Plug 'ap/vim-css-color'

    " Nice icons in the file explorer and file type status line.
    " Plug 'ryanoasis/vim-devicons'
    " Completion from other opened files
    " Plug 'Shougo/context_filetype.vim'
    " Pending tasks list
    " Plug 'fisadev/FixedTaskList.vim'
    " Git/mercurial/others diff icons on the side of the file lines
    " Plug 'mhinz/vim-signify'
    " Yank history navigation
    " Plug 'vim-scripts/YankRing.vim'

" Tell vim-plug we finished declaring plugins, so it can load them
call plug#end()

"###############################################################################
" NERDTree Settings
"###############################################################################
noremap <F12> :NERDTreeToggle<CR>
" open nerdtree with the current file selected
nmap ,t :NERDTreeFind<CR>
" let g:NERDTreeMinimalUI = 1
" let g:NERDTreeDirArrows = 1
" let g:NERDTreeIgnore = ['\.pyc$', '\.pyo$', '__pycache__'] "don;t show these file types
" let g:WebDevIconsUnicodeDecorateFolderNodes = 1 "Enable folder icons
" let g:DevIconsEnableFoldersOpenClose = 1
" highlight! link NERDTreeFlags NERDTreeDir   "Fix directory colors
" " Remove expandable arrow
" let g:WebDevIconsNerdTreeBeforeGlyphPadding = ""
" let g:WebDevIconsUnicodeDecorateFolderNodes = v:true
" let NERDTreeDirArrowExpandable = "\u00a0"
" let NERDTreeDirArrowCollapsible = "\u00a0"
" let NERDTreeNodeDelimiter = "\x07"

" Autorefresh on tree focus
function! NERDTreeRefresh()
    if &filetype == "nerdtree"
        silent exe substitute(mapcheck("R"), "<CR>", "", "")
    endif
endfunction

autocmd BufEnter * call NERDTreeRefresh()

"###############################################################################
" NERDCommenter Settings
"###############################################################################
map <Leader>/ <plug>NERDCommenterToggle
let g:NERDSpaceDelims = 1 " Add spaces after comment delimiters by default
let g:NERDCompactSexyComs = 1 " Use compact syntax for prettified multi-line comments
let g:NERDCommentEmptyLines = 1 " Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDTrimTrailingWhitespace = 1 " Enable trimming of trailing whitespace when uncommenting
let g:NERDToggleCheckAllLines = 1 " Enable NERDCommenterToggle to check all selected lines is commented or not
" let g:NERDDefaultAlign = 'left' " Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDCreateDefaultMappings = 0 " Cancel NERD's default mappings

"###############################################################################
" YouCompleteMe Settings
"###############################################################################
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

"###############################################################################
" jedi-vim Settings
"###############################################################################
" let g:jedi#usages_command = "<leader>z"
" " automatically starts the completion, if you type a dot
" let g:jedi#popup_on_dot = 1
" " Disable choose first function/method at autocomplete
" let g:jedi#popup_select_first = 0
" " make jedi-vim use tabs when going to a definition
" let g:jedi#use_tabs_not_buffers = 1
" " displays function call signatures in insert mode in real-time, highlighting the current argument
" " 1 - pop-up in the buffer (default)
" " 2 - in Vim's command line aligned with the function call
" let g:jedi#show_call_signatures = "1"
" noremap <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

"###############################################################################
" Airline Settings
"###############################################################################
let g:airline_section_c = '%F%m%r%h%w %y'
let g:airline_powerline_fonts = 1  "Включить поддержку Powerline шрифтов
let g:airline_section_x = 'HEX=%02.2B'
let g:airline_section_y = '%{&encoding}[%{&fileformat}]'
let g:airline_section_z = "\ue0a1 %l,%c/%L %p%%"
let g:airline_extensions = []
let g:Powerline_symbols='unicode'  "Поддержка unicode
let g:airline#extensions#keymap#enabled = 0  "Не показывать текущий маппинг
let g:airline#extensions#xkblayout#enabled = 0  "Про это позже расскажу

" TODO: check these settings
" let g:airline_powerline_fonts = 0
" let g:airline_theme = 'bubblegum'
" let g:airline#extensions#whitespace#enabled = 0

" To use fancy symbols wherever possible, change this setting from 0 to 1
" and use a font from https://github.com/ryanoasis/nerd-fonts in your terminal
" (if you aren't using one of those fonts, you will see funny characters here.
" Turst me, they look nice when using one of those fonts).
" let fancy_symbols_enabled = 0
" " Fancy Symbols!!
" if fancy_symbols_enabled
    " let g:webdevicons_enable = 1
"
    " " custom airline symbols
    " if !exists('g:airline_symbols')
       " let g:airline_symbols = {}
    " endif
    " let g:airline_left_sep = ''
    " let g:airline_left_alt_sep = ''
    " let g:airline_right_sep = ''
    " let g:airline_right_alt_sep = ''
    " let g:airline_symbols.branch = '⭠'
    " let g:airline_symbols.readonly = '⭤'
    " let g:airline_symbols.linenr = '⭡'
" else
    " let g:webdevicons_enable = 0
" endif

"###############################################################################
" Lightline Settings
"###############################################################################
let g:lightline = {
    \ 'colorscheme': 'wombat',
    \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'modified', 'filename' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'format_encoding' ],
      \              [ 'charhex',  ] ]
    \ },
      \ 'component': {
      \   'filename': '%F%m%r%h%w %y',
      \   'charhex': 'HEX=%02.2B',
      \   'format_encoding': '%{&encoding}[%{&fileformat}]',
      \   'lineinfo': '%l,%c/%L %p%%'
      \ },
\ }

"###############################################################################
" deoplete Settings
"###############################################################################
" needed so deoplete can auto select the first suggestion
set completeopt+=noinsert
" comment this line to enable autocompletion preview window
" (displays documentation related to the selected completion option)
" disabled by default because preview makes the window flicker
set completeopt-=preview

" autocompletion of files and commands behaves like shell
" (complete only the common part, list the options that match)
set wildmode=list:longest

" " Use deoplete.
" let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option({
" \   'ignore_case': v:true,
" \   'smart_case': v:true,
" \})
" " complete with words from any opened file
" let g:context_filetype#same_filetypes = {}
" let g:context_filetype#same_filetypes._ = '_'

"###############################################################################
" TaskList Settings
"###############################################################################
" show pending tasks list
map <F2> :TaskList<CR>

"###############################################################################
" Neomake Settings
"###############################################################################
" " Run linter on write
" autocmd! BufWritePost * Neomake
"
" " Check code as python3 by default
" let g:neomake_python_python_maker = neomake#makers#ft#python#python()
" let g:neomake_python_flake8_maker = neomake#makers#ft#python#flake8()
" let g:neomake_python_python_maker.exe = 'python3 -m py_compile'
" let g:neomake_python_flake8_maker.exe = 'python3 -m flake8'
"
" " Disable error messages inside the buffer, next to the problematic line
" let g:neomake_virtualtext_current_error = 0

"###############################################################################
" Signify Settings
"###############################################################################
" " this first setting decides in which order try to guess your current vcs
" " UPDATE it to reflect your preferences, it will speed up opening files
" let g:signify_vcs_list = ['git', 'hg']
" " mappings to jump to changed blocks
" nmap <leader>sn <plug>(signify-next-hunk)
" nmap <leader>sp <plug>(signify-prev-hunk)
" " nicer colors
" highlight DiffAdd           cterm=bold ctermbg=none ctermfg=119
" highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
" highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
" highlight SignifySignAdd    cterm=bold ctermbg=237  ctermfg=119
" highlight SignifySignDelete cterm=bold ctermbg=237  ctermfg=167
" highlight SignifySignChange cterm=bold ctermbg=237  ctermfg=227

"###############################################################################
" Yankring Settings
"###############################################################################
let g:yankring_history_dir='~/.vim/dirs'
" let g:yankring_history_dir='C:\Documents and Settings\VCHD7-WS-AKP2\vimfiles\dirs\'

"###############################################################################
" Tagbar Settings
"###############################################################################
" toggle tagbar display
map <F6> :TagbarToggle<CR>
" autofocus on tagbar open
let g:tagbar_autofocus = 1

"###############################################################################
" Python IDE Setup
"###############################################################################
" Settings for ctrlp
" let g:ctrlp_max_height = 30
" set wildignore+=*.pyc
" set wildignore+=*_build/*
" set wildignore+=*/coverage/*

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
" function! OmniPopup(action)
    " if pumvisible()
        " if a:action == 'j'
            " return "\<C-N>"
        " elseif a:action == 'k'
            " return "\<C-P>"
        " endif
    " endif
    " return a:action
" endfunction
"
" inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
" inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


"###############################################################################
" Mappings
"###############################################################################
" <Leader> key
let mapleader = " "
let maplocalleader = "\\"

" Let Meta key (Alt) to be usefull in terminal
let c='a'
while c <= 'z'
  exec "set <M-".c.">=\e".c
  exec "imap \e".c." <M-".c.">"
  let c = nr2char(1+char2nr(c))
endw

" Removes highlight of your last search
noremap <C-c>h :nohlsearch<CR>
vnoremap <C-c>h :nohlsearch<CR>
inoremap <C-c>h :nohlsearch<CR>

" Bind Ctrl+<movement> keys to move around the windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
set splitbelow   "новое окно появляется снизу

" Resize windows
noremap <C-c>= :resize +5<CR>
noremap <C-c>- :resize -5<CR>
noremap <C-c>. :vertical resize +5<CR>
noremap <C-c>, :vertical resize -5<CR>
inoremap <C-c>= <Esc>:resize +5<CR>a
inoremap <C-c>- <Esc>:resize -5<CR>a
inoremap <C-c>. <Esc>:vertical resize +5<CR>a
inoremap <C-c>, <Esc>:vertical resize -5<CR>a

" Switch file encoding
set wcm=<Tab>   "WTF? but all work
menu Encoding.cp1251     :e ++enc=cp1251<CR>
menu Encoding.koi8-r     :e ++enc=koi8-r<CR>
menu Encoding.cp866      :e ++enc=cp866<CR>
menu Encoding.utf-8      :e ++enc=utf-8 <CR>
noremap <F9> :emenu Encoding.<TAB>

" Edit & Apply changes in .vimrc
nnoremap <Leader>ev :tabnew $MYVIMRC<CR>
nnoremap <Leader>sv :source $MYVIMRC<CR>

" Move line up/down
nnoremap <M-k> :m .-2<CR>==
nnoremap <M-j> :m .+1<CR>==
inoremap <M-k> <Esc>:m .-2<CR>==gi
inoremap <M-j> <Esc>:m .+1<CR>==gi
vnoremap <M-k> :m '<-2<CR>gv=gv
vnoremap <M-j> :m '>+1<CR>gv=gv

" Easier moving of code blocks (doesn't lose selection)
vnoremap < <gv
vnoremap > >gv

" Execute Python script
" noremap <F5> <Esc>:w<CR>:! python3 %<CR>
" inoremap <F5> <Esc>:w<CR>:! python3 %<CR>a
noremap <F10> <Esc>:w<CR>:! python3 %<CR>
inoremap <F10> <Esc>:w<CR>:! python3 %<CR>a

" Open, Save, Update & Quit
noremap <C-o> :browse confirm e <CR>
" Close buffer without saving
map <Esc><Esc> :q!<CR>
" Quit all windows without saving
noremap <Leader>q :qa!<CR>
" noremap <C-s> :w!<CR>
noremap <C-z> :update<CR>
vnoremap <C-z> <C-C>:update<CR>
inoremap <C-z> <C-O>:update<CR>
" Save file and Save as ...
noremap <F2> :w!<CR>
noremap <F3> :saveas
" Save & Quit
noremap <F4> :x!<CR>

" Auto adding by Shift-Tab
"inoremap <S-Tab> <C-n>

" Open new tab
nnoremap <C-t>t :tabnew<CR>
inoremap <C-t>t <Esc>:tabnew<CR>a

" Switch between tabs
nnoremap <F8> :tabn <CR>
nnoremap <F7> :tabp <CR>

" Aligning
" center
" inoremap <C-c>c <Esc>:center<CR>a
" nnoremap <C-c>c :center<CR>
" left
" inoremap <C-c>, <Esc>:left<CR>a
" nnoremap <C-c>, :left<CR>
inoremap <C-c>l <Esc>:left<CR>a
nnoremap <C-c>l :left<CR>
" right
" inoremap <C-c>. <Esc>:right<CR>a
" nnoremap <C-c>. :right<CR>
inoremap <C-c>r <Esc>:right<CR>a
nnoremap <C-c>r :right<CR>

" Copy/Cut/Past from/to system buffer
vnoremap <C-c> "+y
vnoremap <C-x> "+d
" map <C-p> "+p
map <C-p> "+P
vnoremap <C-c> "*y :let @+=@*<CR>
" vnoremap <C-c>y "+y
" vnoremap <C-c>x "+d
" nnoremap <C-c>p "+p
" nnoremap <C-c>P "+P  " P - paste before

" Surround the selection in "", '', ()
vnoremap <Leader>" <ESC>`<i"<ESC>`>la"<ESC>
vnoremap <Leader>' <ESC>`<i'<ESC>`>la'<ESC>
vnoremap <Leader>( <ESC>`<i(<ESC>`>la)<ESC>

" Go to BOL and EOL
inoremap <M-h> <ESC>0i
inoremap <M-l> <ESC>$a
nnoremap <S-h> 0
nnoremap <S-l> $

" Return from insert mode to normal
" inoremap jk <ESC>
" inoremap ii <ESC>l
inoremap jj <ESC>

" Несколько удобных биндингов для с, c++, java, python
augroup filetype_coding
    autocmd!
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
    au FileType python inoremap :: <END>:<CR>
    au FileType python inoremap (: ():<CR>
    au FileType python inoremap #ifn if __name__ == "__main__":<CR>
    au FileType python inoremap #t # TODO:  <Esc>i
    au FileType python inoremap #f # FIXME:  <Esc>i
augroup END

" Биндинги для LaTeX
" augroup filetype_latex
    " autocmd!
    " au FileType tex inoremap %- %---------------------------------------------------------------------------<CR>
    " au FileType tex inoremap %= %===========================================================================<CR>
    " au FileType tex inoremap { {}<Left>
    " au FileType tex inoremap \bei \begin{itemize}<CR>
    " au FileType tex inoremap \ei \end{itemize}<CR>
    " au FileType tex inoremap \bee \begin{enumerate}<CR>
    " au FileType tex inoremap \ee \end{enumerate}<CR>
    " au FileType tex inoremap \it \item
" augroup END

" bindings for JetBrains IDEs
" inoremap :: <END>:<CR>
" inoremap (: ():<CR>

" New line
inoremap '' <END><CR>







