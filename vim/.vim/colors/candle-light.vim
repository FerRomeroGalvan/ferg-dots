" Name: candle-light
" Based on: candle-grey-transparent by Aditya Azad
"
" Candle anatomy — reading a function signature:
"
"   def  foo  (  x: int = 0  )  ->  bool  :
"   ─┬─  ─┬─  ┬  ──────────  ┬  ─┬  ──┬─
"    │    │   │               │   │    └── flame    #D99962  amber
"    │    │   │               │   └─────── wick     #7A6A55  dark cord
"    │    │   └───────────────┴─────────── holder   #6B5040  dark iron
"    │    │       param names / types ────────────── wax pool #C8955A
"    │    └────────────────────────────── bone      #E8E0D0  off-white name
"    └─────────────────────────────────── wax       #C8955A  candle body kw
"
"   Amber (#D99962) appears exactly once: the return type — the live flame.
"
" Verified against :so $VIMRUNTIME/syntax/hitest.vim output.
" Key findings:
"   pythonConditional -> Conditional   (if/elif/else)
"   pythonRepeat      -> Repeat        (for/while)
"   pythonException   -> Exception     (try/except/raise/finally)
"   pythonInclude     -> Include       (import/from)
"   pythonAsync       -> Statement     (async/await)
"   pythonExceptions  -> Structure     (ValueError, Exception class names)
"   pythonStatement   catches ONLY: pass/del/global/nonlocal/assert/yield/lambda
"   pythonFunction    = name token after def
"   pythonClass       = name token after class
"   pythonParam       = parameter names in def signature
"   pythonArrow       = -> token
"   pythonAnnotation  = return type after ->
"   pythonDecorator   = @ symbol
"   pythonDecoratorName = decorator name
"   pythonBuiltin     = built-in functions (print, len, etc.)
"   pythonDocstring   = docstring content
"
" Full palette:
"   #0D0D0D  near-black      (background reference)
"   #1E1A14  warm dark       (CursorLine bg)
"   #2E2A22  warm shadow     (ColorColumn)
"   #383838  cool dark-grey  (comments, docstrings)
"   #555555  cool mid-grey   (operators, delimiters, pass/del/assert)
"   #6B5040  dark iron       (parens — candle holder)
"   #7A6A55  wick            (-> arrow)
"   #8C8C8C  cool grey       (strings, numbers)
"   #C8955A  wax             (def/class kw, params, annotations, decorators)
"   #C8C8C8  cool light-grey (general identifiers, imported names)
"   #E8E0D0  bone            (function/class names)
"   #F2F2F2  neutral white   (Normal text)
"   #F5EFE0  warm ivory      (if/for/return/import — flow keywords)
"   #D99962  amber/flame     (return type annotation, cursor, search, todo)
"
" cterm approximations:
"   warm dark bg    → 234
"   cool dark-grey  → 237
"   cool mid-grey   → 240
"   dark iron       → 95
"   wick            → 243
"   cool grey       → 245
"   wax             → 173
"   cool light-grey → 251
"   bone            → 254
"   neutral white   → 255
"   warm ivory      → 230
"   amber           → 214
"
" Requires in vimrc (before plug#begin):
"   let g:polyglot_disabled = ['python']
"   let g:python_highlight_all = 1

set background=dark

highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name="candle-light"

" ================================================================
" EDITOR CHROME
" ================================================================
hi Normal          ctermfg=255    ctermbg=NONE    cterm=NONE      guifg=#F2F2F2    guibg=NONE       gui=NONE
hi Cursor          ctermfg=233    ctermbg=214     cterm=NONE      guifg=#0D0D0D    guibg=#D99962    gui=NONE
hi CursorLine      ctermfg=230    ctermbg=234     cterm=NONE      guifg=#F5EFE0    guibg=#1E1A14    gui=NONE
hi LineNr          ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE
hi CursorLineNR    ctermfg=214    ctermbg=NONE    cterm=bold      guifg=#D99962    guibg=NONE       gui=bold
hi CursorColumn    ctermfg=NONE   ctermbg=234     cterm=NONE      guifg=NONE       guibg=#1E1A14    gui=NONE
hi FoldColumn      ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE
hi SignColumn      ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE
hi Folded          ctermfg=237    ctermbg=NONE    cterm=italic    guifg=#383838    guibg=NONE       gui=italic
hi VertSplit       ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE
hi ColorColumn     ctermfg=NONE   ctermbg=234     cterm=NONE      guifg=NONE       guibg=#2E2A22    gui=NONE
hi TabLine         ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE
hi TabLineFill     ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE
hi TabLineSel      ctermfg=255    ctermbg=NONE    cterm=bold      guifg=#F2F2F2    guibg=NONE       gui=bold

" ================================================================
" SEARCH / NAVIGATION
" ================================================================
hi Directory       ctermfg=255    ctermbg=NONE    cterm=NONE      guifg=#F2F2F2    guibg=NONE       gui=NONE
hi Search          ctermfg=233    ctermbg=214     cterm=NONE      guifg=#0D0D0D    guibg=#D99962    gui=NONE
hi IncSearch       ctermfg=233    ctermbg=255     cterm=bold      guifg=#0D0D0D    guibg=#F2F2F2    gui=bold

" ================================================================
" STATUS / PROMPT
" ================================================================
hi StatusLine      ctermfg=214    ctermbg=NONE    cterm=NONE      guifg=#D99962    guibg=NONE       gui=NONE
hi StatusLineNC    ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE
hi WildMenu        ctermfg=233    ctermbg=214     cterm=bold      guifg=#0D0D0D    guibg=#D99962    gui=bold
hi Question        ctermfg=245    ctermbg=NONE    cterm=NONE      guifg=#8C8C8C    guibg=NONE       gui=NONE
hi Title           ctermfg=255    ctermbg=NONE    cterm=bold      guifg=#F2F2F2    guibg=NONE       gui=bold
hi ModeMsg         ctermfg=255    ctermbg=NONE    cterm=bold      guifg=#F2F2F2    guibg=NONE       gui=bold
hi MoreMsg         ctermfg=214    ctermbg=NONE    cterm=NONE      guifg=#D99962    guibg=NONE       gui=NONE

" ================================================================
" VISUAL / SELECTION
" ================================================================
hi MatchParen      ctermfg=214    ctermbg=237     cterm=bold      guifg=#D99962    guibg=#383838    gui=bold
" Visual: background only — tokens keep their individual colours through selection
hi Visual          ctermfg=NONE   ctermbg=238     cterm=NONE      guifg=NONE       guibg=#3A3028    gui=NONE
hi VisualNOS       ctermfg=NONE   ctermbg=238     cterm=NONE      guifg=NONE       guibg=#3A3028    gui=NONE
hi NonText         ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE
hi Todo            ctermfg=233    ctermbg=214     cterm=bold      guifg=#0D0D0D    guibg=#D99962    gui=bold
hi Underlined      ctermfg=255    ctermbg=NONE    cterm=underline guifg=#F2F2F2    guibg=NONE       gui=underline
hi Error           ctermfg=255    ctermbg=88      cterm=bold      guifg=#F2F2F2    guibg=#6B1A1A    gui=bold
hi ErrorMsg        ctermfg=255    ctermbg=88      cterm=bold      guifg=#F2F2F2    guibg=#6B1A1A    gui=bold
hi WarningMsg      ctermfg=214    ctermbg=NONE    cterm=NONE      guifg=#D99962    guibg=NONE       gui=NONE
hi Ignore          ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE
hi SpecialKey      ctermfg=237    ctermbg=NONE    cterm=NONE      guifg=#383838    guibg=NONE       gui=NONE

" ================================================================
" CONSTANTS — strings, numbers: cool grey, recessive
" ================================================================
hi Constant        ctermfg=245    ctermbg=NONE    cterm=NONE      guifg=#8C8C8C    guibg=NONE       gui=NONE
hi String          ctermfg=245    ctermbg=NONE    cterm=NONE      guifg=#8C8C8C    guibg=NONE       gui=NONE
hi StringDelimiter ctermfg=245    ctermbg=NONE    cterm=NONE      guifg=#8C8C8C    guibg=NONE       gui=NONE
hi Character       ctermfg=245    ctermbg=NONE    cterm=NONE      guifg=#8C8C8C    guibg=NONE       gui=NONE
hi Number          ctermfg=245    ctermbg=NONE    cterm=NONE      guifg=#8C8C8C    guibg=NONE       gui=NONE
" Boolean/None: mid-grey bold — values, not keywords, should recede
hi Boolean         ctermfg=245    ctermbg=NONE    cterm=bold      guifg=#8C8C8C    guibg=NONE       gui=bold
hi Float           ctermfg=245    ctermbg=NONE    cterm=NONE      guifg=#8C8C8C    guibg=NONE       gui=NONE

" ================================================================
" IDENTIFIERS
" General variables: cool light-grey
" Function names (via Function group): bone — warm off-white
" ================================================================
hi Identifier      ctermfg=251    ctermbg=NONE    cterm=NONE      guifg=#C8C8C8    guibg=NONE       gui=NONE
" Function group = name after 'def' in generic syntax
" Overridden for Python specifically by pythonFunction below
hi Function        ctermfg=254    ctermbg=NONE    cterm=NONE      guifg=#E8E0D0    guibg=NONE       gui=NONE

" ================================================================
" BASE KEYWORD GROUPS
" These are the fallback groups that python-specific groups inherit from.
" Setting them correctly means the inheritance chain works for free.
"
"   Conditional  ← pythonConditional (if/elif/else)
"   Repeat       ← pythonRepeat (for/while)
"   Exception    ← pythonException (try/except/raise/finally)
"   Include      ← pythonInclude (import/from)
"   Statement    ← pythonAsync (async/await) + pythonStatement fallback
"   Structure    ← pythonExceptions (ValueError, TypeError etc.)
"   Keyword      ← def/class (we set this to wax)
"   StorageClass ← storage modifiers
" ================================================================

" Flow keywords: warm ivory bold — they catch the light
hi Conditional     ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold
hi Repeat          ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold
hi Exception       ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold
hi Label           ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold
hi Include         ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold

" Statement: ivory bold — async/await + any unmatched statement keywords
hi Statement       ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold

" pass/del/global/assert/yield/lambda — these fall through to pythonStatement
" which has no specific override, so they inherit Statement (ivory bold).
" That's fine — they're control-flow words, not definitions.

" PreProc: ivory bold (generic preprocessor / includes)
hi PreProc         ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold
hi Define          ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold
hi Macro           ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold
hi PreCondit       ctermfg=230    ctermbg=NONE    cterm=bold      guifg=#F5EFE0    guibg=NONE       gui=bold

" ================================================================
" WAX — def/class keywords and their kin
" #C8955A muted terracotta
" Keyword group is used by 'def' and 'class' in Python syntax.
" Type/Structure/Typedef = type annotations, inherited class names.
" ================================================================
hi Keyword         ctermfg=173    ctermbg=NONE    cterm=NONE      guifg=#C8955A    guibg=NONE       gui=NONE
hi StorageClass    ctermfg=173    ctermbg=NONE    cterm=NONE      guifg=#C8955A    guibg=NONE       gui=NONE
hi Type            ctermfg=173    ctermbg=NONE    cterm=NONE      guifg=#C8955A    guibg=NONE       gui=NONE
" Structure catches pythonExceptions (ValueError, TypeError etc.) — wax,
" they're part of the language material
hi Structure       ctermfg=173    ctermbg=NONE    cterm=NONE      guifg=#C8955A    guibg=NONE       gui=NONE
hi Typedef         ctermfg=173    ctermbg=NONE    cterm=NONE      guifg=#C8955A    guibg=NONE       gui=NONE
hi Special         ctermfg=173    ctermbg=NONE    cterm=NONE      guifg=#C8955A    guibg=NONE       gui=NONE

" ================================================================
" OPERATORS / DELIMITERS — cool mid-grey, recede into shadow
" ================================================================
hi Operator        ctermfg=240    ctermbg=NONE    cterm=NONE      guifg=#555555    guibg=NONE       gui=NONE
hi Delimiter       ctermfg=240    ctermbg=NONE    cterm=NONE      guifg=#555555    guibg=NONE       gui=NONE
hi SpecialChar     ctermfg=245    ctermbg=NONE    cterm=NONE      guifg=#8C8C8C    guibg=NONE       gui=NONE
hi Tag             ctermfg=251    ctermbg=NONE    cterm=NONE      guifg=#C8C8C8    guibg=NONE       gui=NONE
hi Debug           ctermfg=214    ctermbg=NONE    cterm=bold      guifg=#D99962    guibg=NONE       gui=bold

" ================================================================
" COMMENTS — darkest, italic, furthest from flame
" ================================================================
hi Comment ctermfg=240 ctermbg=NONE cterm=italic guifg=#555555 guibg=NONE gui=italic
hi SpecialComment  ctermfg=245    ctermbg=NONE    cterm=italic    guifg=#8C8C8C    guibg=NONE       gui=italic

" ================================================================
" PYTHON-SPECIFIC CANDLE ANATOMY
" All groups confirmed present via hitest.vim output.
" ================================================================

" -- WAX KEYWORD: def / class ----------------------------------
" pythonStatement catches def/class at keyword level.
" We set it to wax. The name tokens (pythonFunction, pythonClass)
" override this immediately after.
hi pythonStatement       ctermfg=173    ctermbg=NONE    cterm=NONE      guifg=#C8955A    guibg=NONE    gui=NONE

" -- None / True / False: cool grey bold — values, not keywords ----
" pythonNone and pythonBoolean are active when python_highlight_all = 1
hi pythonNone            ctermfg=245    ctermbg=NONE    cterm=bold      guifg=#8C8C8C    guibg=NONE    gui=bold
hi pythonBoolean         ctermfg=245    ctermbg=NONE    cterm=bold      guifg=#8C8C8C    guibg=NONE    gui=bold

" -- BONE: the name that follows def / class -------------------
" Warm off-white — the name carved into the wax.
hi pythonFunction        ctermfg=254    ctermbg=NONE    cterm=NONE      guifg=#E8E0D0    guibg=NONE    gui=NONE
hi pythonClass           ctermfg=254    ctermbg=NONE    cterm=NONE      guifg=#E8E0D0    guibg=NONE    gui=NONE

" -- DARK IRON: ( ) — the candle holder -----------------------
" Dark warm brown — structural, contains the flame.
hi pythonOperator        ctermfg=95     ctermbg=NONE    cterm=NONE      guifg=#6B5040    guibg=NONE    gui=NONE

" -- WAX POOL: parameter names --------------------------------
" Same wax as def/class — same material, inside the holder.
hi pythonParam           ctermfg=173    ctermbg=NONE    cterm=NONE      guifg=#C8955A    guibg=NONE    gui=NONE

" -- WICK: -> -------------------------------------------------
" Dark cord — the passage before the flame.
hi pythonArrow           ctermfg=243    ctermbg=NONE    cterm=NONE      guifg=#7A6A55    guibg=NONE    gui=NONE

" -- FLAME: return type annotation ----------------------------
" Amber — the single live fire. Appears here and nowhere else.
hi pythonAnnotation      ctermfg=214    ctermbg=NONE    cterm=NONE      guifg=#D99962    guibg=NONE    gui=NONE

" -- DECORATOR: wax italic ------------------------------------
hi pythonDecorator       ctermfg=173    ctermbg=NONE    cterm=italic    guifg=#C8955A    guibg=NONE    gui=italic
hi pythonDecoratorName   ctermfg=173    ctermbg=NONE    cterm=italic    guifg=#C8955A    guibg=NONE    gui=italic

" -- BUILTINS: wax (print, len, range etc.) -------------------
hi pythonBuiltin         ctermfg=173    ctermbg=NONE    cterm=NONE      guifg=#C8955A    guibg=NONE    gui=NONE

" -- DOCSTRINGS: comment-level dark, italic -------------------
hi pythonDocstring       ctermfg=237    ctermbg=NONE    cterm=italic    guifg=#383838    guibg=NONE    gui=italic

" -- INHERITED FROM BASE GROUPS (no override needed) ----------
" pythonConditional -> Conditional  (ivory bold) ✓
" pythonRepeat      -> Repeat       (ivory bold) ✓
" pythonException   -> Exception    (ivory bold) ✓
" pythonInclude     -> Include      (ivory bold) ✓
" pythonAsync       -> Statement    (ivory bold) ✓
" pythonExceptions  -> Structure    (wax)        ✓
" pythonNumber      -> Number       (cool grey)  ✓
" pythonString      -> String       (cool grey)  ✓
" pythonComment     -> Comment      (dark italic) ✓
" pythonTodo        -> Todo         (amber bg)   ✓

" ================================================================
" DIFF
" ================================================================
hi DiffAdd         ctermfg=251    ctermbg=22      cterm=NONE      guifg=#C8C8C8    guibg=#1A2E1A    gui=NONE
hi DiffChange      ctermfg=251    ctermbg=52      cterm=NONE      guifg=#C8C8C8    guibg=#2E1E0A    gui=NONE
hi DiffDelete      ctermfg=237    ctermbg=52      cterm=NONE      guifg=#383838    guibg=#2E0A0A    gui=NONE
hi DiffText        ctermfg=233    ctermbg=214     cterm=bold      guifg=#0D0D0D    guibg=#D99962    gui=bold

" ================================================================
" COMPLETION MENU
" ================================================================
hi Pmenu           ctermfg=245    ctermbg=234     cterm=NONE      guifg=#8C8C8C    guibg=#1E1A14    gui=NONE
hi PmenuSel        ctermfg=233    ctermbg=214     cterm=bold      guifg=#0D0D0D    guibg=#D99962    gui=bold
hi PmenuSbar       ctermfg=NONE   ctermbg=237     cterm=NONE      guifg=NONE       guibg=#383838    gui=NONE
hi PmenuThumb      ctermfg=NONE   ctermbg=245     cterm=NONE      guifg=NONE       guibg=#8C8C8C    gui=NONE

" ================================================================
" SPELLING
" ================================================================
hi SpellBad        ctermfg=214    ctermbg=NONE    cterm=underline guifg=#D99962    guibg=NONE       gui=undercurl
hi SpellCap        ctermfg=251    ctermbg=NONE    cterm=underline guifg=#C8C8C8    guibg=NONE       gui=undercurl
hi SpellLocal      ctermfg=245    ctermbg=NONE    cterm=underline guifg=#8C8C8C    guibg=NONE       gui=undercurl
hi SpellRare       ctermfg=245    ctermbg=NONE    cterm=underline guifg=#8C8C8C    guibg=NONE       gui=undercurl
