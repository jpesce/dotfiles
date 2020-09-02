hi clear
syntax reset
let g:colors_name = "essential"

" ANSI colors
let s:red     = ["#f66b87", 01]
let s:green   = ["#a9dc76", 02]
let s:yellow  = ["#ffd966", 03]
let s:blue    = ["#79dce8", 04]
let s:magenta = ["#ab9df2", 05]
let s:cyan    = ["#fc9868", 06]
let s:black   = ["#211f22", 00]
let s:gray    = ["#817e82", 08]
let s:white   = ["#efebe3", 07]

" Supporting Monochromes
let s:almostblack = ["#312c35", 235]
let s:darkgray    = ["#544f5c", 238]

let s:none = ["NONE", "NONE"]

let s:base00 = s:black
let s:base01 = s:almostblack
let s:base02 = s:darkgray
let s:base03 = s:gray
let s:base04 = s:black
let s:base05 = s:white
let s:base08 = s:red
let s:base09 = s:magenta
let s:base0A = s:yellow
let s:base0B = s:green
let s:base0C = s:cyan
let s:base0D = s:blue

let s:base0E = s:base09
let s:base0F = s:base0C

fun <sid>hi(group, fg, bg, attr, guisp)
  if exists("a:fg[0]")    | exec "hi " . a:group . " guifg=" .   a:fg[0]                 | endif
  if exists("a:bg[0]")    | exec "hi " . a:group . " guibg=" .   a:bg[0]                 | endif
  if exists("a:fg[1]")    | exec "hi " . a:group . " ctermfg=" . a:fg[1]                 | endif
  if exists("a:bg[1]")    | exec "hi " . a:group . " ctermbg=" . a:bg[1]                 | endif
  if a:attr != ""         | exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr | endif
  if exists("a:guisp[0]") | exec "hi " . a:group . " guisp=" .   a:guisp[0]              | endif
endfun

let g:terminal_ansi_colors = [
              \ s:black[0], s:red[0], s:green[0], s:yellow[0],
              \ s:blue[0], s:magenta[0], s:cyan[0], s:white[0],
              \ s:gray[0], s:red[0], s:green[0], s:yellow[0],
              \ s:blue[0], s:magenta[0], s:cyan[0], s:white[0]
              \]

" Vim editor colors
call <sid>hi("Normal",        s:base05, [], "", [])
call <sid>hi("Bold",          [], [], "bold", [])
call <sid>hi("Debug",         s:base08, [], "", [])
call <sid>hi("Directory",     s:base0D, [], "", [])
call <sid>hi("Error",         s:base00, s:base08, "", [])
call <sid>hi("ErrorMsg",      s:base08, s:base00, "", [])
call <sid>hi("Exception",     s:base08, [], "", [])
call <sid>hi("FoldColumn",    s:base0C, s:base01, "", [])
call <sid>hi("Folded",        s:base03, s:base01, "", [])
call <sid>hi("Search",        s:base00, s:yellow,  "", [])
call <sid>hi("IncSearch",     s:base00, s:cyan, "none", [])
call <sid>hi("Italic",        [], [], "none", [])
call <sid>hi("Macro",         s:base08, [], "", [])
call <sid>hi("MatchParen",    s:base09, s:none, "italic", [])
call <sid>hi("ModeMsg",       s:base0B, [], "", [])
call <sid>hi("MoreMsg",       s:base0B, [], "", [])
call <sid>hi("Question",      s:base0D, [], "", [])
call <sid>hi("Substitute",    s:base00, s:yellow, "none", [])
call <sid>hi("TooLong",       s:base08, [], "", [])
call <sid>hi("Underlined",    s:base08, [], "", [])
call <sid>hi("Visual",        [], s:almostblack, "", [])
call <sid>hi("VisualNOS",     [], s:almostblack, "", [])
call <sid>hi("WarningMsg",    s:red, [], "", [])
call <sid>hi("WildMenu",      s:white, s:black, "", [])
call <sid>hi("Title",         s:base0D, [], "none", [])
call <sid>hi("Conceal",       s:base0D, s:base00, "", [])
call <sid>hi("Cursor",        s:black, s:white, "", [])
call <sid>hi("NonText",       s:base03, [], "", [])
call <sid>hi("LineNr",        s:darkgray, s:none, "", [])
call <sid>hi("SignColumn",    s:gray, s:none, "", [])
call <sid>hi("StatusLine",    s:darkgray, s:none, "underline", [])
call <sid>hi("StatusLineNC",  s:almostblack, s:none, "underline", [])
call <sid>hi("VertSplit",     s:darkgray, s:none, "none", [])
call <sid>hi("ColorColumn",   [], s:almostblack, "none", [])
call <sid>hi("CursorColumn",  [], s:almostblack, "none", [])
call <sid>hi("CursorLine",    s:none, s:almostblack, "none", [])
call <sid>hi("CursorLineNr",  s:gray, s:almostblack, "none", [])
call <sid>hi("QuickFixLine",  [], s:almostblack, "none", [])
call <sid>hi("EndOfBuffer",   s:black, s:none, "none", [])
"
" Popup Menu
call <sid>hi("PMenu",         s:gray, s:almostblack, "none", [])
call <sid>hi("PMenuSel",      [], s:darkgray, "", [])
call <sid>hi("PMenuSbar",     [], s:almostblack, "", [])
call <sid>hi("PMenuThumb",    [], s:gray, "", [])

" Tabline
call <sid>hi("TabLine",       s:gray, s:none, "none", [])
call <sid>hi("TabLineFill",   s:gray, s:none, "none", [])
call <sid>hi("TabLineSel",    s:white, s:none, "none", [])

" Standard syntax highlighting
call <sid>hi("Comment",      s:base03, [], "italic", [])
call <sid>hi("Operator",     s:base05, [], "none", [])
call <sid>hi("Character",    s:base08, [], "", [])
call <sid>hi("Identifier",   s:base08, [], "none", [])
call <sid>hi("Statement",    s:base08, [], "", [])
call <sid>hi("Constant",     s:base09, [], "", [])
call <sid>hi("Boolean",      s:base09, [], "", [])
call <sid>hi("Float",        s:base09, [], "", [])
call <sid>hi("Number",       s:base09, [], "", [])
call <sid>hi("Label",        s:base0A, [], "", [])
call <sid>hi("PreProc",      s:base0A, [], "", [])
call <sid>hi("Repeat",       s:base0A, [], "", [])
call <sid>hi("StorageClass", s:base0A, [], "", [])
call <sid>hi("Tag",          s:base0A, [], "", [])
call <sid>hi("Type",         s:base0A, [], "none", [])
call <sid>hi("Typedef",      s:base0A, [], "", [])
call <sid>hi("String",       s:base0B, [], "", [])
call <sid>hi("Special",      s:base0C, [], "", [])
call <sid>hi("Function",     s:base0D, [], "", [])
call <sid>hi("Include",      s:base0D, [], "", [])
call <sid>hi("Define",       s:base0E, [], "none", [])
call <sid>hi("Conditional",  s:base0E, [], "", [])
call <sid>hi("Keyword",      s:base0E, [], "", [])
call <sid>hi("Structure",    s:base0E, [], "", [])
call <sid>hi("Delimiter",    s:base0F, [], "", [])
call <sid>hi("SpecialChar",  s:base0F, [], "", [])

call <sid>hi("Todo",         s:yellow, s:base00, "italic", [])

" C highlighting
call <sid>hi("cOperator",   s:base0C, [], "", [])
call <sid>hi("cPreCondit",  s:base0E, [], "", [])

" C# highlighting
call <sid>hi("csType",                  s:base08, [], "", [])
call <sid>hi("csNewDecleration",        s:base08, [], "", [])
call <sid>hi("csClass",                 s:base0A, [], "", [])
call <sid>hi("csAttribute",             s:base0A, [], "", [])
call <sid>hi("csUnspecifiedStatement",  s:base0D, [], "", [])
call <sid>hi("csModifier",              s:base0E, [], "", [])
call <sid>hi("csContextualStatement",   s:base0E, [], "", [])

" CSS highlighting
call <sid>hi("cssBraces",      s:base05, [], "", [])
call <sid>hi("cssClassName",   s:base0E, [], "", [])
call <sid>hi("cssColor",       s:base0C, [], "", [])

" Diff highlighting
call <sid>hi("DiffAdd",       s:base0B, s:base01, "", [])
call <sid>hi("DiffChange",    s:base03, s:base01, "", [])
call <sid>hi("DiffDelete",    s:base08, s:base01, "", [])
call <sid>hi("DiffText",      s:base0D, s:base01, "", [])
call <sid>hi("DiffAdded",     s:base0B, s:base00, "", [])
call <sid>hi("DiffFile",      s:base08, s:base00, "", [])
call <sid>hi("DiffNewFile",   s:base0B, s:base00, "", [])
call <sid>hi("DiffLine",      s:base0D, s:base00, "", [])
call <sid>hi("DiffRemoved",   s:base08, s:base00, "", [])

" Git highlighting
call <sid>hi("gitcommitOverflow",       s:base08, [], "", [])
call <sid>hi("gitcommitSummary",        s:base0B, [], "", [])
call <sid>hi("gitcommitComment",        s:base03, [], "", [])
call <sid>hi("gitcommitUntracked",      s:base03, [], "", [])
call <sid>hi("gitcommitDiscarded",      s:base03, [], "", [])
call <sid>hi("gitcommitSelected",       s:base03, [], "", [])
call <sid>hi("gitcommitHeader",         s:base0E, [], "", [])
call <sid>hi("gitcommitSelectedType",   s:base0D, [], "", [])
call <sid>hi("gitcommitUnmergedType",   s:base0D, [], "", [])
call <sid>hi("gitcommitDiscardedType",  s:base0D, [], "", [])
call <sid>hi("gitcommitBranch",         s:base09, [], "bold", [])
call <sid>hi("gitcommitUntrackedFile",  s:base0A, [], "", [])
call <sid>hi("gitcommitUnmergedFile",   s:base08, [], "bold", [])
call <sid>hi("gitcommitDiscardedFile",  s:base08, [], "bold", [])
call <sid>hi("gitcommitSelectedFile",   s:base0B, [], "bold", [])

" GitGutter highlighting
call <sid>hi("GitGutterAdd",          s:base0B, s:base01, "", [])
call <sid>hi("GitGutterChange",       s:base0D, s:base01, "", [])
call <sid>hi("GitGutterDelete",       s:base08, s:base01, "", [])
call <sid>hi("GitGutterChangeDelete", s:base0E, s:base01, "", [])

" HTML highlighting
call <sid>hi("htmlBold",    s:base0A, [], "", [])
call <sid>hi("htmlItalic",  s:base0E, [], "", [])
call <sid>hi("htmlEndTag",  s:base05, [], "", [])
call <sid>hi("htmlTag",     s:base05, [], "", [])

" JavaScript highlighting
call <sid>hi("javaScript",        s:base05, [], "", [])
call <sid>hi("javaScriptBraces",  s:base05, [], "", [])
call <sid>hi("javaScriptNumber",  s:base09, [], "", [])

" pangloss/vim-javascript highlighting
call <sid>hi("jsOperator",          s:base0D, [], "", [])
call <sid>hi("jsStatement",         s:base0E, [], "", [])
call <sid>hi("jsReturn",            s:base0E, [], "", [])
call <sid>hi("jsThis",              s:base08, [], "", [])
call <sid>hi("jsClassDefinition",   s:base0A, [], "", [])
call <sid>hi("jsFunction",          s:base0E, [], "", [])
call <sid>hi("jsFuncName",          s:base0D, [], "", [])
call <sid>hi("jsFuncCall",          s:base0D, [], "", [])
call <sid>hi("jsClassFuncName",     s:base0D, [], "", [])
call <sid>hi("jsClassMethodType",   s:base0E, [], "", [])
call <sid>hi("jsRegexpString",      s:base0C, [], "", [])
call <sid>hi("jsGlobalObjects",     s:base0A, [], "", [])
call <sid>hi("jsGlobalNodeObjects", s:base0A, [], "", [])
call <sid>hi("jsExceptions",        s:base0A, [], "", [])
call <sid>hi("jsBuiltins",          s:base0A, [], "", [])

" Mail highlighting
call <sid>hi("mailQuoted1",  s:base0A, [], "", [])
call <sid>hi("mailQuoted2",  s:base0B, [], "", [])
call <sid>hi("mailQuoted3",  s:base0E, [], "", [])
call <sid>hi("mailQuoted4",  s:base0C, [], "", [])
call <sid>hi("mailQuoted5",  s:base0D, [], "", [])
call <sid>hi("mailQuoted6",  s:base0A, [], "", [])
call <sid>hi("mailURL",      s:base0D, [], "", [])
call <sid>hi("mailEmail",    s:base0D, [], "", [])

" Markdown highlighting
call <sid>hi("markdownCode",              s:base0B, [], "", [])
call <sid>hi("markdownError",             s:base05, s:base00, "", [])
call <sid>hi("markdownCodeBlock",         s:base0B, [], "", [])
call <sid>hi("markdownHeadingDelimiter",  s:base0D, [], "", [])

" NERDTree highlighting
call <sid>hi("NERDTreeDirSlash",  s:base0D, [], "", [])
call <sid>hi("NERDTreeExecFile",  s:base05, [], "", [])

" PHP highlighting
call <sid>hi("phpMemberSelector",  s:base05, [], "", [])
call <sid>hi("phpComparison",      s:base05, [], "", [])
call <sid>hi("phpParent",          s:base05, [], "", [])
call <sid>hi("phpMethodsVar",      s:base0C, [], "", [])

" Python highlighting
call <sid>hi("pythonOperator",  s:base0E, [], "", [])
call <sid>hi("pythonRepeat",    s:base0E, [], "", [])
call <sid>hi("pythonInclude",   s:base0E, [], "", [])
call <sid>hi("pythonStatement", s:base0E, [], "", [])

" Ruby highlighting
call <sid>hi("rubyAttribute",               s:base0D, [], "", [])
call <sid>hi("rubyConstant",                s:base0A, [], "", [])
call <sid>hi("rubyInterpolationDelimiter",  s:base0F, [], "", [])
call <sid>hi("rubyRegexp",                  s:base0C, [], "", [])
call <sid>hi("rubySymbol",                  s:base0B, [], "", [])
call <sid>hi("rubyStringDelimiter",         s:base0B, [], "", [])

" SASS highlighting
call <sid>hi("sassidChar",     s:base08, [], "", [])
call <sid>hi("sassClassChar",  s:base09, [], "", [])
call <sid>hi("sassInclude",    s:base0E, [], "", [])
call <sid>hi("sassMixing",     s:base0E, [], "", [])
call <sid>hi("sassMixinName",  s:base0D, [], "", [])

" Signify highlighting
call <sid>hi("SignifySignAdd",     s:base0B, s:base01, "", [])
call <sid>hi("SignifySignChange",  s:base0D, s:base01, "", [])
call <sid>hi("SignifySignDelete",  s:base08, s:base01, "", [])

" Spelling highlighting
call <sid>hi("SpellBad",     s:base08, s:base00, "undercurl", s:base08)
call <sid>hi("SpellLocal",   s:base0C, s:base0C, "undercurl", s:base0C)
call <sid>hi("SpellCap",     s:base0D, s:base0D, "undercurl", s:base0D)
call <sid>hi("SpellRare",    s:base0A, s:base0A, "undercurl", s:base0A)

" Java highlighting
call <sid>hi("javaOperator",     s:base0D, [], "", [])

" Ale highlighting
call <sid>hi("ALEWarning",     [], s:base00, "", [])
call <sid>hi("ALEWarningSign", s:base0A, s:base00, "", [])
call <sid>hi("ALEError",       [], s:base00, "", [])
call <sid>hi("ALEErrorSign",   s:base08, s:base00, "", [])
call <sid>hi("ALEInfo",        [], s:base00, "", [])
call <sid>hi("ALEInfoSign",    s:blue, s:base00, "", [])

" FZF
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }


" Remove functions
delf <sid>hi

" Remove color variables
unlet s:red s:green s:yellow s:blue s:magenta s:cyan
unlet s:black s:almostblack s:darkgray s:gray s:white
unlet s:base00 s:base01 s:base02 s:base03
unlet s:base04 s:base05
unlet s:base08 s:base09 s:base0A s:base0B
unlet s:base0C s:base0D s:base0E s:base0F
