vim.cmd("let g:netrw_liststyle = 3") -- Explorer style

local g = vim.g -- global
local opt = vim.opt -- local
local wo = vim.wo -- window-scoped
local bo = vim.bo -- buffer-scoped
local api = vim.api

-- line numbers
wo.number = true
wo.relativenumber = true

bo.textwidth = 79
wo.colorcolumn = "+1"
-- vim.cmd([[highlight ColorColumn ctermbg=233]])
wo.cursorline = true
wo.cursorcolumn = true
g.whichwrap = "<,>,[,],h,l" -- не останавливаться курсору на конце строки

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
bo.autoindent = true -- copy indent from current line when starting new one
bo.shiftwidth = 2 -- 2 spaces for indent width
bo.tabstop = 2 -- 2 spaces for tabs (prettier default)
bo.expandtab = true -- expand tab to spaces
-- bo.smartindent = true
-- bo.softtabstop = 2

bo.syntax = "ON"
-- Данная вариация работает как wrap,... но переносит строчки не посимвольно, а по словам
wo.wrap = true
wo.linebreak = true
g.nolist = true

g.mouse = "a"
g.noexrc = true -- не читаем файл конфигурации из текущей директории
g.showtabline = 2 -- постоянно выводим строку с табами
g.tabpagemax = 20 -- максимальное количество открытых табов
g.history = 50
g.undolevels = 50
g.noerrorbells = true -- instead of beeping
g.wildmenu = true -- красивое автодополнение
g.cmdheight = 2 -- Give more space for displaying messages.
g.scrolloff = 3 -- when scrolling, keep cursor 3 lines away from screen border
g.showmatch = true -- for brackets

-- split windows
g.splitbelow = true -- split horizontal window to the bottom
g.splitright = true -- split vertical window to the right

-- search settings
g.hlsearch = true
g.incsearch = true
g.ignorecase = true -- ignore case when searching
g.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- Disable backup and swap files - they trigger too many events for file system watchers
g.nobackup = true
g.nowritebackup = true
g.noswapfile = true

-- backspace
-- Influences the working of <BS>, <Del>, CTRL-W and CTRL-U in Insert mode
g.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register


-- statusline
g.showmode = true -- показывать текущий режим
g.showcmd = true -- показывать незавершенные команды в статусбаре
g.laststatus = 2 -- always show statusline
-- g.statusline = "%#DiffText#\ %M\ %F%r%h%w\ %y%=%#TabLineSel#\ HEX=%02.2B\ %{&encoding}[%{&fileformat}]\ %l:%c/%L\ %p%%\ [%n]"

-- Encoding
g.encoding = "utf8" -- кодировка по дефолту
g.termencoding = "utf8" -- Кодировка вывода на терминал
g.fileencodings = "utf8,cp1251,koi8r,cp866" -- Возможные кодировки файлов (автоматическая перекодировка)

-- Run commands in normal mode with switched cyrillic --------------------------
g.langmap = "ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"
g.iminsert = 0 -- Язык ввода при старте Вима - Английский
g.imsearch = 0 -- Аналогично настраивается режим поиска

g.autochdir = true -- текущий каталог всегда совпадает с содержимым активного окна
g.browsedir = "current" -- browsedir    "last", "buffer" or "current": which directory used for the file browser

g.termguicolors = true
g.background = "dark" -- colorschemes that can be light or dark will be made dark
wo.signcolumn = "yes" -- show sign column so that text doesn't shift
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
