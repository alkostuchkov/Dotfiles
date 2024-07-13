autocmd! UIEnter * let g:gui = filter(nvim_list_uis(),{k,v-> v.chan==v:event.chan})[0].rgb
" GUI -------------------------------------------------------------------------
set wak=no   "используем ALT как обычно, а не для вызова пункта меню
"убираем меню и тулбар
set guioptions-=m
set guioptions-=T
"убираем скроллбары
set guioptions-=r
set guioptions-=l
" "используем консольные диалоги вместо графических
set guioptions+=c
" "прячем курсор
" set mousehide

" " GuiFont Monoid\ Nerd\ Font\ Mono:h15:w400
" GuiFont! Sarasa Mono SC Nerd:h19:l
GuiFont! Sarasa Mono SC Nerd:h20
" GuiFont! Iosevka:h19
" GuiFont! mplus Nerd Font:h20
" GuiFont! CaskaydiaCove Nerd Font Mono:h18
" GuiFont UbuntuMono Nerd Font:h20
" set guifont=mplus\ Nerd\ Font\ 18  " for nvim-gtk

set background=dark
" colorscheme ayu
" colorscheme darcula
" colorscheme memorycolor
" colorscheme OceanicNext
" colorscheme OceanicMaterial
colorscheme Everforest
" colorscheme gruvbox-material
