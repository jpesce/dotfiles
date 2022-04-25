
" Name:         Essential
" Author:       João Pesce <joao@pesce.cc>
" Maintainer:   João Pesce <joao@pesce.cc>
" License:      Vim License (see `:help license`)
" Last Updated: Mon Jul  5 09:18:33 2021

set background=dark

hi clear
let g:colors_name = 'essential2'

hi! link lCursor Cursor

hi Terminal ctermfg=LightGrey ctermbg=Black cterm=NONE

hi Normal ctermfg=NONE ctermbg=NONE cterm=NONE
hi! link StorageClass Normal
hi! link Structure Normal
hi! link Typedef Normal
hi! link Identifier Normal
hi! link Function Normal
hi! link Constant Normal
hi! link Type Normal

hi Comment ctermfg=LightGrey ctermbg=NONE cterm=NONE

hi Constant ctermfg=NONE ctermbg=NONE cterm=italic
hi! link Boolean Constant
hi! link Float Constant
hi! link Number Constant
hi! link Character Constant
hi! link String Constant
hi! link String Constant

hi Statement ctermfg=NONE ctermbg=NONE cterm=bold
hi! link Conditional Statement
hi! link Repeat Statement
hi! link Label Statement
hi! link Operator Statement
hi! link Keyword Statement
hi! link Exception Statement
hi! link PreProc Statement
hi! link Define Statement
hi! link Include Statement
hi! link Macro Statement
hi! link PreCondit Statement
hi! link Special Statement
hi! link SatatementChar Satatement
hi! link Tag Satatement
hi! link Delimiter Satatement
hi! link SatatementComment Satatement
hi! link Debug Satatement

hi! link PopupSelected Normal
hi PMenu ctermfg=NONE ctermbg=8 cterm=NONE
hi PMenuSel ctermfg=NONE ctermbg=8 cterm=bold
hi PMenuSbar ctermfg=NONE ctermbg=8 cterm=NONE
hi PMenuThumb ctermfg=NONE ctermbg=LightGray cterm=NONE
hi! link WildMenu PMenuSel

hi TabLine ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel ctermfg=NONE ctermbg=NONE cterm=bold

hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton ctermfg=NONE ctermbg=NONE cterm=NONE

hi StatusLine ctermfg=LightGray ctermbg=NONE cterm=NONE
hi StatusLineNC ctermfg=8 ctermbg=NONE cterm=NONE
hi! link StatusLineTerm StatusLine
hi! link StatusLineTermNC StatusLineNC

hi VertSplit ctermfg=8 ctermbg=NONE cterm=NONE
hi Title ctermfg=NONE ctermbg=NONE cterm=bold

hi Error ctermfg=DarkRed ctermbg=NONE cterm=NONE
hi! link ErrorMsg Error
hi! link RedrawDebugRecompose Error
hi! link NvimInternalError Error

hi WarningMsg ctermfg=DarkYellow ctermbg=NONE cterm=NONE
hi! link RedrawDebugClear WarningMsg

hi! link Question WarningMsg
hi Todo ctermfg=DarkYellow ctermbg=NONE cterm=NONE

hi Search ctermfg=DarkYellow ctermbg=Black cterm=NONE
hi IncSearch ctermfg=Black ctermbg=DarkYellow cterm=NONE

hi Ignore ctermfg=8 ctermbg=NONE cterm=NONE
hi EndOfBuffer ctermfg=Black ctermbg=NONE cterm=NONE

hi Conceal ctermfg=LightGray ctermbg=NONE cterm=NONE

hi NonText ctermfg=8 ctermbg=NONE cterm=NONE

hi LineNr ctermfg=LightGrey ctermbg=NONE cterm=NONE
hi! link CursorLineNR LineNr
hi! link SignColumn LineNr
hi! link FoldColumn LineNr

hi Visual ctermfg=NONE ctermbg=8 cterm=NONE
hi! link CursorLine Visual
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

" LSP
hi DiagnosticError ctermfg=LightGrey ctermbg=NONE cterm=NONE
hi! link DiagnosticError DiagnosticWarn
hi! link DiagnosticError DiagnosticInfo
hi! link DiagnosticError DiagnosticHint

hi DiagnosticSignError ctermfg=DarkRed ctermbg=NONE cterm=NONE
hi DiagnosticSignWarn ctermfg=DarkYellow ctermbg=NONE cterm=NONE
hi DiagnosticSignInfo ctermfg=DarkCyan ctermbg=NONE cterm=NONE
hi DiagnosticSignHint ctermfg=DarkCyan ctermbg=NONE cterm=NONE

" JSON
hi! link jsonKeyword Normal

" Vim
hi! link vimHiAttrib Normal

" CSS
hi! link cssVendor Normal

" Git
hi diffLine    ctermfg=LightGrey ctermbg=NONE cterm=NONE
hi diffAdded   ctermfg=DarkGreen ctermbg=NONE cterm=NONE
hi diffRemoved ctermfg=DarkRed   ctermbg=NONE cterm=NONE
