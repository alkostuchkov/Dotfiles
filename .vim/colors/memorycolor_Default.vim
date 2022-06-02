" Supporting code -------------------------------------------------------------
" Initialisation: {{{

highlight clear

if exists("syntax_on")
  syntax reset
endif

let g:colors_name='memorycolor'

" }}}
" Global Settigns: {{{

let s:invert_tabline = 'inverse,'

"}}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
let s:italic = 'italic,'
let s:underline = 'underline,'
let s:undercurl = 'undercurl,'
let s:inverse = 'inverse,'

" }}}
" Setup Colors: {{{

let s:vim_bg          = ['bg', 'bg']
let s:vim_fg          = ['fg', 'fg']
let s:none            = ['NONE', 'NONE']

let s:white           = ['#f0f0f0', 234]
let s:bright_gray     = ['#c2b19d', 123]
let s:gray            = ['#6b8299', 123]

let s:aqua            = ['#00b3b3', 123]
let s:blue            = ['#66b2ff', 123]
let s:green           = ['#00e673', 123]
let s:orange          = ['#e6ac74', 234]
let s:bright_pink     = ['#ff6666', 234]
let s:pink            = ['#ff66ff', 234]
let s:red             = ['#e60073', 234]
let s:violet          = ['#b366ff', 234]
let s:bright_yellow   = ['#f0b16c', 234]
let s:yellow          = ['#e6e600', 234]

let s:bg0             = ['#26394d', 123]
let s:bg1             = ['#203040', 123]
let s:bg2             = ['#152535', 123]

let s:tab = ['#b05f5f', 123]
let s:tab2 = ['#a75353', 123]

let s:fg = s:orange

"}}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:gruvbox_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:gruvbox_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Common Hi Groups: {{{

"}}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg, s:bg0)

set background=dark

" Screen line that the cursor is
call s:HL('CursorLine', s:none, s:bg1)
" Screen column that the cursor is
hi! link CursorColumn CursorLine
" Line number of CursorLine
call s:HL('CursorLineNr', s:fg, s:bg2)

" Highlighted screen columns
call s:HL('ColorColumn', s:red, s:bg1)

" Tab pages line filler
call s:HL('TabLineFill', s:gray, s:bg1)
" Not active tab page label
hi! link TabLine TabLineFill
" Active tab page label
call s:HL('TabLineSel', s:fg, s:bg2)

" Match paired bracket under the cursor
call s:HL('MatchParen', s:none, s:bg1, s:bold)

" Concealed element: \lambda → λ
call s:HL('Conceal', s:yellow, s:none)


call s:HL('NonText', s:none, s:bg0)

" Type :set all to see some of them
call s:HL('SpecialKey', s:white, s:none, s:bold)

call s:HL('Visual', s:none, s:bg2)

call s:HL('Search',    s:bg2, s:yellow)
call s:HL('IncSearch', s:bg2, s:blue)

" TODO Don't understand, what it is
call s:HL('Underlined', s:blue, s:none, s:underline)

" The column separating vertically split windows
call s:HL('VertSplit', s:gray, s:gray)

call s:HL('StatusLine',   s:none, s:bg2)
call s:HL('StatusLineNC', s:none, s:yellow)

" Current match in wildmenu completion
call s:HL('WildMenu', s:none, s:bg2, s:inverse)
" Directory names, special names in listing
call s:HL('Directory', s:none, s:none, s:bold)

" Titles for output from :set all, :autocmd, etc.
call s:HL('Title', s:green, s:none, s:bold)

" Error messages on the command line
call s:HL('ErrorMsg', s:red, s:none, s:bold)
" More prompt: -- More --
call s:HL('MoreMsg', s:yellow, s:none, s:bold)
" Current mode message: -- INSERT --
call s:HL('ModeMsg', s:yellow, s:none, s:bold)
" 'Press enter' prompt and yes/no questions
call s:HL('Question', s:orange, s:none, s:bold)
" Warning messages
call s:HL('WarningMsg', s:red, s:none, s:bold)

"}}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:gray, s:bg2)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:bg2)

" Line used for closed folds
call s:HL('Folded', s:white, s:bg2, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg2)

"}}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:red, s:pink, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

call s:HL('Comment', s:gray)
call s:HL('String', s:green)
call s:HL('Todo', s:bg1, s:orange)
call s:HL('Function', s:violet)
call s:HL('Number', s:red)
call s:HL('Attribute', s:pink)
call s:HL('Operator', s:white)

"}}}
" Completion Menu: {{{

" Popup menu: normal item
call s:HL('Pmenu', s:fg, s:bg0)
" Popup menu: selected item
call s:HL('PmenuSel', s:blue, s:bg2, s:bold)
" Popup menu: scrollbar
call s:HL('PmenuSbar', s:none, s:bg1)
" Popup menu: scrollbar thumb
call s:HL('PmenuThumb', s:none, s:bg2)

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
call s:HL('DiffChange', s:bg0, s:blue)
call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
"call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
"call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}

" Plugin specific -------------------------------------------------------------
" GitGutter: {{{

call s:HL('GitGutterAdd', s:green, s:bg2)
call s:HL('GitGutterChange', s:aqua, s:bg2)
call s:HL('GitGutterDelete', s:red, s:bg2)
call s:HL('GitGutterChangeDelete', s:aqua, s:bg2)

" }}}
" NERDTree: {{{

call s:HL('NERDTreeDir', s:none, s:bg0, s:bold)
"call s:HL('NERDTreeSlash', s:blue, s:bg0, s:bold)

call s:HL('NERDTreeOpenable', s:none, s:bg0, s:bold)
call s:HL('NERDTreeClosable', s:blue, s:bg0, s:bold)

call s:HL('NERDTreeFile', s:none, s:bg0)
call s:HL('NERDTreeExecFile', s:yellow, s:bg0)

call s:HL('NERDTreeUp', s:gray, s:bg0)
call s:HL('NERDTreeCMD', s:green, s:bg0)
call s:HL('NERDTreeHelp', s:none, s:bg0)

call s:HL('NERDTreeToggleOn', s:green)
call s:HL('NERDTreeToggleOff', s:red)

" }}}

" Filetype specific
" Vim: {{{

call s:HL('vimCommentTitle', s:blue, s:none, s:italic)
call s:HL('vimHighlight', s:yellow)
call s:HL('vimLet', s:yellow)
call s:HL('vimCommand', s:yellow)
call s:HL('vimHiGroup', s:orange)
call s:HL('vimBracket', s:yellow)
call s:HL('vimNotation', s:yellow)

"}}}
" Python: {{{

call s:HL('pythonBuiltin', s:yellow)
call s:HL('pythonInclude', s:yellow)
call s:HL('pythonException', s:yellow)
"hi! link pythonBuiltinObj GruvboxOrange
"hi! link pythonBuiltinFunc GruvboxOrange
"hi! link pythonDecorator GruvboxRed
"hi! link pythonImport GruvboxBlue
"hi! link pythonRun GruvboxBlue
"hi! link pythonCoding GruvboxBlue
"hi! link pythonOperator GruvboxRed
"hi! link pythonException GruvboxRed
"hi! link pythonExceptions GruvboxPurple
"hi! link pythonBoolean GruvboxPurple
"hi! link pythonDot GruvboxFg3
"hi! link pythonConditional GruvboxRed
"hi! link pythonRepeat GruvboxRed
"hi! link pythonDottedName GruvboxGreenBold

"}}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
