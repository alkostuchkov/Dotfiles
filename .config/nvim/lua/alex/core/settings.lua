vim.cmd("let g:netrw_liststyle = 3") -- Explorer style

local g = vim.g                      -- global
local opt = vim.opt                  -- local
-- local wo = vim.wo                    -- window-scoped
-- local bo = vim.bo                    -- buffer-scoped
-- local api = vim.api

-- opt.linespace = 4 -- only for GUI (nvim-qt), for Consolas NF
-- line numbers
opt.number = on
opt.relativenumber = on

opt.textwidth = 79
opt.colorcolumn = "+1"
-- vim.cmd([[highlight ColorColumn ctermbg=233]])
opt.cursorline = on
opt.cursorcolumn = on
opt.whichwrap = "<,>,[,],h,l" -- не останавливаться курсору на конце строки

-- При редактировании файла всегда переходить на последнюю известную
-- позицию курсора. Если позиция ошибочная - не переходим.
vim.cmd([[
  autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
]])

vim.cmd([[
  let &t_SI.="\e[5 q"
  let &t_SR.="\e[3 q"
  let &t_EI.="\e[1 q"
]])
-- Где:
-- 1 - это мигающий прямоугольник
-- 2 - обычный прямоугольник
-- 3 - мигающее подчёркивание
-- 4 - просто подчёркивание
-- 5 - мигающая вертикальная черта
-- 6 - просто вертикальная черта

-- tabs & indentation
opt.autoindent = on -- copy indent from current line when starting new one
opt.smartindent = on
-- disable auto-comments on new line (2 lines below)
vim.cmd("autocmd BufEnter * set formatoptions-=cro")
vim.cmd("autocmd BufEnter * setlocal formatoptions-=cro")
-- opt.formatoptions:remove({ "c", "r", "o" }) -- doesn't work

opt.shiftwidth = 4   -- 2 spaces for indent width
opt.tabstop = 4      -- 2 spaces for tabs (prettier default)
opt.expandtab = on -- expand tab to spaces
opt.softtabstop = 4

opt.syntax = "ON"
-- Данная вариация работает как wrap,... но переносит строчки не посимвольно, а по словам
-- opt.wrap = on
-- opt.linebreak = on
-- g.nolist = on
opt.wrap = off

opt.mouse = "a"
g.noexrc = on     -- не читаем файл конфигурации из текущей директории
opt.showtabline = 2 -- постоянно выводим строку с табами
opt.tabpagemax = 20 -- максимальное количество открытых табов
opt.history = 50
opt.undolevels = 50
g.noerrorbells = on -- instead of beeping
opt.wildmenu = on   -- красивое автодополнение
-- opt.cmdheight = 2     -- Give more space for displaying messages.
opt.scrolloff = 3     -- when scrolling, keep cursor 3 lines away from screen border
opt.showmatch = on  -- for brackets

-- split windows
opt.splitbelow = on -- split horizontal window to the bottom
opt.splitright = on -- split vertical window to the right

-- search settings
opt.hlsearch = on
opt.incsearch = on
opt.ignorecase = on -- ignore case when searching
opt.smartcase = on  -- if you include mixed case in your search, assumes you want case-sensitive

-- Disable backup and swap files - they trigger too many events for file system watchers
g.nobackup = on
g.nowritebackup = on
opt.swapfile = off
-- g.noswapfile = on

-- backspace
-- Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register


-- statusline
opt.showmode = on -- показывать текущий режим
opt.showcmd = on  -- показывать незавершенные команды в статусбаре
opt.laststatus = 2  -- always show statusline
-- opt.statusline = "%#DiffText#\ %M\ %F%r%h%w\ %y%=%#TabLineSel#\ HEX=%02.2B\ %{&encoding}[%{&fileformat}]\ %l:%c/%L\ %p%%\ [%n]"

-- Encoding
opt.encoding = "utf8"                         -- кодировка по дефолту
g.termencoding = "utf8"                       -- Кодировка вывода на терминал
opt.fileencodings = "utf8,cp1251,koi8r,cp866" -- Возможные кодировки файлов (автоматическая перекодировка)

-- Run commands in normal mode with switched cyrillic --------------------------
opt.langmap =
"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
opt.iminsert = 0        -- Язык ввода при старте Вима - Английский
opt.imsearch = 0        -- Аналогично настраивается режим поиска

opt.autochdir = on    -- текущий каталог всегда совпадает с содержимым активного окна
g.browsedir = "current" -- browsedir    "last", "buffer" or "current": which directory used for the file browser

opt.termguicolors = on
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes"  -- show sign column so that text doesn't shift
-- vim.cmd([[highlight clear SignColumn]])

-- shorter messages
opt.shortmess:append("c")

-- fillchars
opt.fillchars = {
  vert = "│",
  fold = "⠀",
  eob = " ", -- suppress ~ at EndOfBuffer
  -- diff = "⣿", -- alternatives = ⣿ ░ ─ ╱
  msgsep = "‾",
  foldopen = "▾",
  foldsep = "│",
  foldclose = "▸"
}
