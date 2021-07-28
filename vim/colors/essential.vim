" Name:         Essential
" Author:       João Pesce <joao@pesce.cc>
" Maintainer:   João Pesce <joao@pesce.cc>
" License:      Vim License (see `:help license`)
" Last Updated: Wed Apr 21 20:27:16 2021

" Generated by Colortemplate v2.1.0

set background=dark

hi clear
let g:colors_name = 'essential'

let s:t_Co = exists('&t_Co') && !empty(&t_Co) && &t_Co > 1 ? &t_Co : 2
let s:italics = (&t_ZH != '' && &t_ZH != '[7m') || has('gui_running')

if (has('termguicolors') && &termguicolors) || has('gui_running')
  let g:terminal_ansi_colors = ['#1a1d23', '#e06c75', '#98c379', '#e5c07b', '#61afef', '#c678dd', '#56b6c2', '#abb2bf', '#767676', '#ff6400', '#64ff00', '#ffff64', '#0064ff', '#ff64ff', '#64ffff', '#e0e0ed']
  hi Terminal guifg=#abb2bf guibg=#1a1d23 gui=NONE cterm=NONE
  hi Normal guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Comment guifg=#767676 guibg=NONE gui=italic cterm=italic
  hi! link lCursor Cursor
  hi! link StorageClass Normal
  hi! link Structure Normal
  hi! link Typedef Normal
  hi! link Identifier Normal
  hi! link Function Normal
  hi! link Constant Normal
  hi! link Type Normal
  hi Constant guifg=#56b6c2 guibg=NONE gui=NONE cterm=NONE
  hi! link Boolean Constant
  hi! link Float Constant
  hi! link Number Constant
  hi! link Character Constant
  hi! link String Constant
  hi Statement guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi! link Conditional Statement
  hi! link Repeat Statement
  hi! link Label Statement
  hi! link Operator Statement
  hi! link Keyword Statement
  hi! link Exception Statement
  hi PreProc guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi! link Define PreProc
  hi! link Include PreProc
  hi! link Macro PreProc
  hi! link PreCondit PreProc
  hi Special guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi! link SpecialChar Special
  hi! link Tag Special
  hi! link Delimiter Special
  hi! link SpecialComment Special
  hi! link Debug Special
  hi! link PopupSelected Normal
  hi PMenu guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PMenuSel guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi PMenuSbar guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PMenuThumb guifg=NONE guibg=#1a1d23 gui=NONE cterm=NONE
  hi TabLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineFill guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi ToolbarLine guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi WildMenu guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi StatusLine guifg=#abb2bf guibg=NONE gui=NONE cterm=NONE
  hi StatusLineNC guifg=#767676 guibg=NONE gui=NONE cterm=NONE
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLineNC
  hi VertSplit guifg=#1a1d23 guibg=NONE gui=NONE cterm=NONE
  hi Title guifg=NONE guibg=NONE gui=bold ctermfg=NONE ctermbg=NONE cterm=bold
  hi Error guifg=#e06c75 guibg=NONE gui=NONE cterm=NONE
  hi! link ErrorMsg Error
  hi WarningMsg guifg=#e5c07b guibg=NONE gui=NONE cterm=NONE
  hi! link Question WarningMsg
  hi Todo guifg=#e5c07b guibg=NONE gui=NONE cterm=NONE
  hi Search guifg=#e5c07b guibg=#1a1d23 gui=NONE cterm=NONE
  hi IncSearch guifg=#1a1d23 guibg=#e5c07b gui=NONE cterm=NONE
  hi Ignore guifg=#1a1d23 guibg=NONE gui=NONE cterm=NONE
  hi! link EndOfBuffer Ignore
  hi NonText guifg=#767676 guibg=NONE gui=NONE cterm=NONE
  hi LineNr guifg=#767676 guibg=NONE gui=NONE cterm=NONE
  hi! link SignColumn LineNr
  hi! link FoldColumn LineNr
  hi Visual guifg=#1a1d23 guibg=#abb2bf gui=NONE cterm=NONE
  hi! link CursorLine Visual
  hi! link CursorLineNR Visual
  hi! link CursorColumn Visual
  hi! link ColorColumn Visual
  hi! link QuickFixLine Visual
  hi MatchParen guifg=NONE guibg=NONE gui=underline ctermfg=NONE ctermbg=NONE cterm=underline
  hi Folded guifg=NONE guibg=NONE gui=NONE ctermfg=NONE ctermbg=NONE cterm=NONE
  hi MoreMsg guifg=#98c379 guibg=NONE gui=NONE cterm=NONE
  hi Directory guifg=#56b6c2 guibg=NONE gui=NONE cterm=NONE
  hi Underlined guifg=#56b6c2 guibg=NONE gui=underline cterm=underline
  hi DiffAdd guifg=#98c379 guibg=NONE gui=NONE cterm=NONE
  hi DiffChange guifg=#e5c07b guibg=NONE gui=NONE cterm=NONE
  hi DiffText guifg=#e5c07b guibg=NONE gui=NONE cterm=NONE
  hi DiffDelete guifg=#e06c75 guibg=NONE gui=NONE cterm=NONE
  hi SpellBad guifg=#e06c75 guibg=NONE gui=NONE cterm=NONE
  hi SpellCap guifg=#e5c07b guibg=NONE gui=NONE cterm=NONE
  hi SpellRare guifg=#e5c07b guibg=NONE gui=NONE cterm=NONE
  hi SpellLocal guifg=#e5c07b guibg=NONE gui=NONE cterm=NONE
  hi! link jsonKeyword Normal
  if !s:italics
    hi Comment gui=NONE cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 256
  hi Terminal ctermfg=7 ctermbg=0 cterm=NONE
  hi Normal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Comment ctermfg=8 ctermbg=NONE cterm=italic
  hi! link lCursor Cursor
  hi! link StorageClass Normal
  hi! link Structure Normal
  hi! link Typedef Normal
  hi! link Identifier Normal
  hi! link Function Normal
  hi! link Constant Normal
  hi! link Type Normal
  hi Constant ctermfg=6 ctermbg=NONE cterm=NONE
  hi! link Boolean Constant
  hi! link Float Constant
  hi! link Number Constant
  hi! link Character Constant
  hi! link String Constant
  hi Statement ctermfg=NONE ctermbg=NONE cterm=bold
  hi! link Conditional Statement
  hi! link Repeat Statement
  hi! link Label Statement
  hi! link Operator Statement
  hi! link Keyword Statement
  hi! link Exception Statement
  hi PreProc ctermfg=NONE ctermbg=NONE cterm=bold
  hi! link Define PreProc
  hi! link Include PreProc
  hi! link Macro PreProc
  hi! link PreCondit PreProc
  hi Special ctermfg=NONE ctermbg=NONE cterm=bold
  hi! link SpecialChar Special
  hi! link Tag Special
  hi! link Delimiter Special
  hi! link SpecialComment Special
  hi! link Debug Special
  hi! link PopupSelected Normal
  hi PMenu ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PMenuSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PMenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PMenuThumb ctermfg=NONE ctermbg=0 cterm=NONE
  hi TabLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=NONE ctermbg=NONE cterm=NONE
  hi WildMenu ctermfg=NONE ctermbg=NONE cterm=bold
  hi StatusLine ctermfg=7 ctermbg=NONE cterm=NONE
  hi StatusLineNC ctermfg=8 ctermbg=NONE cterm=NONE
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLineNC
  hi VertSplit ctermfg=0 ctermbg=NONE cterm=NONE
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Error ctermfg=1 ctermbg=NONE cterm=NONE
  hi! link ErrorMsg Error
  hi WarningMsg ctermfg=3 ctermbg=NONE cterm=NONE
  hi! link Question WarningMsg
  hi Todo ctermfg=3 ctermbg=NONE cterm=NONE
  hi Search ctermfg=3 ctermbg=0 cterm=NONE
  hi IncSearch ctermfg=0 ctermbg=3 cterm=NONE
  hi Ignore ctermfg=0 ctermbg=NONE cterm=NONE
  hi! link EndOfBuffer Ignore
  hi NonText ctermfg=8 ctermbg=NONE cterm=NONE
  hi LineNr ctermfg=8 ctermbg=NONE cterm=NONE
  hi! link SignColumn LineNr
  hi! link FoldColumn LineNr
  hi Visual ctermfg=0 ctermbg=7 cterm=NONE
  hi! link CursorLine Visual
  hi! link CursorLineNR Visual
  hi! link CursorColumn Visual
  hi! link ColorColumn Visual
  hi! link QuickFixLine Visual
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=underline
  hi Folded ctermfg=NONE ctermbg=NONE cterm=NONE
  hi MoreMsg ctermfg=2 ctermbg=NONE cterm=NONE
  hi Directory ctermfg=6 ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=6 ctermbg=NONE cterm=underline
  hi DiffAdd ctermfg=2 ctermbg=NONE cterm=NONE
  hi DiffChange ctermfg=3 ctermbg=NONE cterm=NONE
  hi DiffText ctermfg=3 ctermbg=NONE cterm=NONE
  hi DiffDelete ctermfg=1 ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=1 ctermbg=NONE cterm=NONE
  hi SpellCap ctermfg=3 ctermbg=NONE cterm=NONE
  hi SpellRare ctermfg=3 ctermbg=NONE cterm=NONE
  hi SpellLocal ctermfg=3 ctermbg=NONE cterm=NONE
  hi! link jsonKeyword Normal
  if !s:italics
    hi Comment cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

if s:t_Co >= 8
  hi Terminal ctermfg=LightGrey ctermbg=Black cterm=NONE
  hi Normal ctermfg=NONE ctermbg=NONE cterm=NONE
  hi Comment ctermfg=DarkGrey ctermbg=NONE cterm=italic
  hi! link lCursor Cursor
  hi! link StorageClass Normal
  hi! link Structure Normal
  hi! link Typedef Normal
  hi! link Identifier Normal
  hi! link Function Normal
  hi! link Constant Normal
  hi! link Type Normal
  hi Constant ctermfg=DarkCyan ctermbg=NONE cterm=NONE
  hi! link Boolean Constant
  hi! link Float Constant
  hi! link Number Constant
  hi! link Character Constant
  hi! link String Constant
  hi Statement ctermfg=NONE ctermbg=NONE cterm=bold
  hi! link Conditional Statement
  hi! link Repeat Statement
  hi! link Label Statement
  hi! link Operator Statement
  hi! link Keyword Statement
  hi! link Exception Statement
  hi PreProc ctermfg=NONE ctermbg=NONE cterm=bold
  hi! link Define PreProc
  hi! link Include PreProc
  hi! link Macro PreProc
  hi! link PreCondit PreProc
  hi Special ctermfg=NONE ctermbg=NONE cterm=bold
  hi! link SpecialChar Special
  hi! link Tag Special
  hi! link Delimiter Special
  hi! link SpecialComment Special
  hi! link Debug Special
  hi! link PopupSelected Normal
  hi PMenu ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PMenuSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi PMenuSbar ctermfg=NONE ctermbg=NONE cterm=NONE
  hi PMenuThumb ctermfg=NONE ctermbg=Black cterm=NONE
  hi TabLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
  hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=bold
  hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
  hi ToolbarButton ctermfg=NONE ctermbg=NONE cterm=NONE
  hi WildMenu ctermfg=NONE ctermbg=NONE cterm=bold
  hi StatusLine ctermfg=LightGrey ctermbg=NONE cterm=NONE
  hi StatusLineNC ctermfg=DarkGrey ctermbg=NONE cterm=NONE
  hi! link StatusLineTerm StatusLine
  hi! link StatusLineTermNC StatusLineNC
  hi VertSplit ctermfg=Black ctermbg=NONE cterm=NONE
  hi Title ctermfg=NONE ctermbg=NONE cterm=bold
  hi Error ctermfg=DarkRed ctermbg=NONE cterm=NONE
  hi! link ErrorMsg Error
  hi WarningMsg ctermfg=DarkYellow ctermbg=NONE cterm=NONE
  hi! link Question WarningMsg
  hi Todo ctermfg=DarkYellow ctermbg=NONE cterm=NONE
  hi Search ctermfg=DarkYellow ctermbg=Black cterm=NONE
  hi IncSearch ctermfg=Black ctermbg=DarkYellow cterm=NONE
  hi Ignore ctermfg=Black ctermbg=NONE cterm=NONE
  hi! link EndOfBuffer Ignore
  hi NonText ctermfg=DarkGrey ctermbg=NONE cterm=NONE
  hi LineNr ctermfg=DarkGrey ctermbg=NONE cterm=NONE
  hi! link SignColumn LineNr
  hi! link FoldColumn LineNr
  hi Visual ctermfg=Black ctermbg=LightGrey cterm=NONE
  hi! link CursorLine Visual
  hi! link CursorLineNR Visual
  hi! link CursorColumn Visual
  hi! link ColorColumn Visual
  hi! link QuickFixLine Visual
  hi MatchParen ctermfg=NONE ctermbg=NONE cterm=underline
  hi Folded ctermfg=NONE ctermbg=NONE cterm=NONE
  hi MoreMsg ctermfg=DarkGreen ctermbg=NONE cterm=NONE
  hi Directory ctermfg=DarkCyan ctermbg=NONE cterm=NONE
  hi Underlined ctermfg=DarkCyan ctermbg=NONE cterm=underline
  hi DiffAdd ctermfg=DarkGreen ctermbg=NONE cterm=NONE
  hi DiffChange ctermfg=DarkYellow ctermbg=NONE cterm=NONE
  hi DiffText ctermfg=DarkYellow ctermbg=NONE cterm=NONE
  hi DiffDelete ctermfg=DarkRed ctermbg=NONE cterm=NONE
  hi SpellBad ctermfg=DarkRed ctermbg=NONE cterm=NONE
  hi SpellCap ctermfg=DarkYellow ctermbg=NONE cterm=NONE
  hi SpellRare ctermfg=DarkYellow ctermbg=NONE cterm=NONE
  hi SpellLocal ctermfg=DarkYellow ctermbg=NONE cterm=NONE
  hi! link jsonKeyword Normal
  if !s:italics
    hi Comment cterm=NONE
  endif
  unlet s:t_Co s:italics
  finish
endif

" Background: dark
" Color: black         #1a1d23                 00          Black
" Color: red           #e06c75                 01          DarkRed
" Color: green         #98c379                 02          DarkGreen
" Color: yellow        #e5c07b                 03          DarkYellow
" Color: blue          #61afef                 04          DarkBlue
" Color: magenta       #c678dd                 05          DarkMagenta
" Color: cyan          #56b6c2                 06          DarkCyan
" Color: white         #abb2bf                 07          LightGrey
" Color: brightblack   #767676                 08          DarkGrey
" Color: brightred     rgb(255, 100,   0)      09          LightRed
" Color: brightgreen   rgb(100, 255,   0)      10          LightGreen
" Color: brightyellow  rgb(255, 255, 100)      11          LightYellow
" Color: brightblue    rgb(  0, 100, 255)      12          LightBlue
" Color: brightmagenta rgb(255, 100, 255)      13          LightMagenta
" Color: brightcyan    rgb(100, 255, 255)      14          LightCyan
" Color: brightwhite   #e0e0ed                 15          White
" Color: almostblack   #242424                 236         DarkGrey
" Color: darkgray      #464646                 239         DarkGrey
" Term colors: black red green yellow blue magenta cyan white
" Term colors: brightblack brightred brightgreen brightyellow
" Term colors: brightblue brightmagenta brightcyan brightwhite
" vim: et ts=2 sw=2
