" Name:         Essential
" Author:       João Pesce <joao@pesce.cc>
" Maintainer:   João Pesce <joao@pesce.cc>
" License:      Vim License (see `:help license`)
" Last Updated: Tue Mar 12 18:57:10 2024

set background=dark

hi clear
let g:colors_name = 'essential'

" Custom groups to reuse by linking
hi Accent           ctermfg=16          ctermbg=NONE    cterm=NONE
hi AccentBold       ctermfg=16          ctermbg=NONE    cterm=bold
hi AccentInverted   ctermfg=Black       ctermbg=16      cterm=NONE

hi Default          ctermfg=White       ctermbg=NONE    cterm=NONE
hi DefaultInverted  ctermfg=Black       ctermbg=White   cterm=NONE
hi DefaultBold      ctermfg=White       ctermbg=NONE    cterm=bold
hi DefaultItalic    ctermfg=White       ctermbg=NONE    cterm=italic
hi DefaultBoldItalic ctermfg=White      ctermbg=NONE    cterm=bold,italic

hi Secondary        ctermfg=LightGrey   ctermbg=NONE    cterm=NONE
hi SecondaryItalic  ctermfg=LightGrey   ctermbg=NONE    cterm=italic

hi Tertiary         ctermfg=8           ctermbg=NONE    cterm=NONE
hi TertiaryItalic   ctermfg=8           ctermbg=NONE    cterm=italic

hi Quaternary       ctermfg=236         ctermbg=NONE    cterm=NONE
hi Quintenary       ctermfg=234         ctermbg=NONE    cterm=NONE

hi Elevation        ctermfg=NONE        ctermbg=234     cterm=NONE

hi Reverse          cterm=reverse

" Color scheme
hi Terminal         ctermfg=LightGrey   ctermbg=Black   cterm=NONE

hi Normal           ctermfg=NONE        ctermbg=NONE    cterm=NONE
hi! link StorageClass Normal
hi! link Structure Normal
hi! link Typedef Normal
hi! link Identifier Normal
hi! link Function Normal
hi! link Type Normal

hi! link Comment Tertiary

hi! link String Accent
hi! link Boolean String
hi! link Float String
hi! link Number String
hi! link Character String

hi! link Statement Secondary
hi! link Constant Statement
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

hi! link PMenu Elevation
hi! link PMenuSel Reverse
hi! link PMenuSbar Elevation
hi PMenuThumb ctermfg=NONE ctermbg=LightGray cterm=NONE
hi! link WildMenu PMenuSel

hi TabLine     ctermfg=LightGray ctermbg=NONE cterm=NONE
hi TabLineFill ctermfg=NONE ctermbg=NONE cterm=NONE
hi TabLineSel  ctermfg=NONE ctermbg=NONE cterm=NONE
" Buffers that are open in other windows
hi! link BufTabLineActive TabLine

hi ToolbarLine ctermfg=NONE ctermbg=NONE cterm=NONE
hi ToolbarButton ctermfg=NONE ctermbg=NONE cterm=NONE

hi! link StatusLine Secondary
hi! link StatusLineNC Tertiary
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
hi Todo ctermfg=White ctermbg=NONE cterm=bold

hi Search    ctermfg=NONE ctermbg=237 cterm=NONE
hi IncSearch ctermfg=Black ctermbg=16 cterm=NONE

hi Ignore      ctermfg=8 ctermbg=NONE cterm=NONE
hi EndOfBuffer ctermfg=Black ctermbg=NONE cterm=NONE

hi Conceal ctermfg=LightGray ctermbg=NONE cterm=NONE

hi NonText ctermfg=8 ctermbg=NONE cterm=NONE

hi! link lineNr Tertiary
hi! link CursorLineNR LineNr
hi! link SignColumn LineNr
hi! link StatusColumnBorder Quaternary
hi! link FoldColumn LineNr

hi! link Visual Elevation
hi! link CursorLine Visual
hi! link CursorColumn Visual
hi! link ColorColumn Visual
hi! link QuickFixLine Visual

hi! link Folded Default
hi MatchParen ctermfg=NONE        ctermbg=NONE cterm=underline
hi MoreMsg    ctermfg=DarkGreen   ctermbg=NONE cterm=NONE
hi Directory  ctermfg=DarkCyan    ctermbg=NONE cterm=NONE
hi Underlined ctermfg=DarkCyan    ctermbg=NONE cterm=underline

hi DiffAdd    ctermfg=DarkGreen   ctermbg=NONE cterm=NONE
hi DiffChange ctermfg=DarkYellow  ctermbg=NONE cterm=NONE
hi DiffText   ctermfg=Black       ctermbg=DarkYellow cterm=NONE
hi DiffDelete ctermfg=DarkRed     ctermbg=NONE cterm=NONE

hi SpellBad   ctermfg=DarkRed     ctermbg=NONE cterm=NONE
hi SpellCap   ctermfg=DarkYellow  ctermbg=NONE cterm=NONE
hi SpellRare  ctermfg=DarkYellow  ctermbg=NONE cterm=NONE
hi SpellLocal ctermfg=DarkYellow  ctermbg=NONE cterm=NONE

" LSP
hi! link DiagnosticError Tertiary

hi! link DiagnosticVirtualTextError Tertiary
hi! link DiagnosticVirtualTextWarn  Tertiary
hi! link DiagnosticVirtualTextInfo  Tertiary
hi! link DiagnosticVirtualTextHint  Tertiary

hi DiagnosticSignError ctermfg=DarkRed    ctermbg=NONE cterm=NONE
hi DiagnosticSignWarn  ctermfg=DarkYellow ctermbg=NONE cterm=NONE
hi DiagnosticSignInfo  ctermfg=DarkCyan   ctermbg=NONE cterm=NONE
hi DiagnosticSignHint  ctermfg=DarkCyan   ctermbg=NONE cterm=NONE

" JSON
hi! link jsonKeyword Normal

" Vim
hi! link vimHiAttrib Normal

" CSS
hi! link cssVendor Normal

" Git
hi diffLine          ctermfg=LightGrey ctermbg=NONE cterm=NONE
hi diffAdded         ctermfg=DarkGreen ctermbg=NONE cterm=NONE
hi diffRemoved       ctermfg=DarkRed   ctermbg=NONE cterm=NONE
hi gitcommitOverflow ctermfg=DarkRed   ctermbg=NONE cterm=NONE

" Telescope
hi! link TelescopeBorder Tertiary

" fzf-lua
hi! link FzfLuaBorder Tertiary

" Neo-tree
hi NeoTreeRootName           ctermfg=DarkCyan ctermbg=NONE cterm=bold
hi! link NeoTreeMessage      Tertiary
hi! link NeoTreeDimText      Tertiary
hi! link NeoTreeGitAdded     DiffAdd
hi! link NeoTreeGitModified  DiffChange
hi! link NeoTreeGitDeleted   DiffDelete
hi! link NeoTreeGitRenamed   DiffChange
hi! link NeoTreeGitUntracked DiffAdd
hi! link NeoTreeGitUnstaged  DiffChange
hi! link NeoTreeGitConflict  Error
hi! link NeoTreeGitStaged    DiffAdd

" Mini tabline
hi! link MiniTablineCurrent         Normal
hi! link MiniTablineVisible         Tertiary
hi! link MiniTablineHidden          Tertiary
hi! link MiniTablineModifiedCurrent DefaultItalic
hi! link MiniTablineModifiedVisible TertiaryItalic
hi! link MiniTablineModifiedHidden  TertiaryItalic

" Markdown
hi! link markdownH1                DefaultBold
hi! link markdownH2                DefaultBold
hi! link markdownH3                DefaultBold
hi! link markdownH4                DefaultBold
hi! link markdownH5                DefaultBold
hi! link markdownH6                DefaultBold
hi! link markdownHeadingDelimiter  DefaultBold
hi! link markdownHeadingRule       DefaultBold
hi! link markdownBold              DefaultBold
hi! link markdownItalic            DefaultItalic
hi! link markdownBoldItalic        DefaultBoldItalic
hi! link markdownCode              Secondary
hi! link markdownCodeBlock         Secondary
hi! link markdownCodeDelimiter     Tertiary
hi! link markdownBlockquote        SecondaryItalic
hi! link markdownRule              Tertiary
hi! link markdownListMarker        Secondary
hi! link markdownOrderedListMarker Secondary
hi! link markdownUrl               Underlined
hi! link markdownLinkText          Accent
hi! link markdownLink              Underlined
hi! link markdownIdDeclaration     Accent
hi! link markdownId                Accent

" Treesitter markup
hi! link @markup.heading           DefaultBold
hi! link @markup.heading.1         DefaultBold
hi! link @markup.heading.2         DefaultBold
hi! link @markup.heading.3         DefaultBold
hi! link @markup.heading.4         DefaultBold
hi! link @markup.heading.5         DefaultBold
hi! link @markup.heading.6         DefaultBold
hi! link @markup.heading.marker    DefaultBold
hi! link @markup.strong            DefaultBold
hi! link @markup.italic            DefaultItalic
hi! link @markup.raw               Secondary
hi! link @markup.raw.block         Secondary
hi! link @markup.raw.delimiter     Tertiary
hi! link @markup.quote             SecondaryItalic
hi! link @markup.list              Secondary
hi! link @markup.list.checked      Tertiary
hi! link @markup.list.unchecked    Secondary
hi! link @markup.link              Accent
hi! link @markup.link.url          Underlined
hi! link @markup.link.label        Accent

" Snacks indent
hi! link SnacksIndent      Quaternary
hi! link SnacksIndentScope Tertiary
