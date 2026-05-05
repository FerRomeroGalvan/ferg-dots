syntax on
set number
set relativenumber
set tabstop=4
set expandtab
set autoindent
set smartindent
set clipboard=unnamedplus
set mouse=a

" ================================================================
" MUST BE BEFORE PLUGINS — polyglot + python syntax flags
" ================================================================
let g:polyglot_disabled = ['python']
let g:python_highlight_all = 1

" ================================================================
" NERDTREE GIT STATUS — must be before plug#begin
"
" Unified git colour language (matches gitgutter + minimap):
"   Added/Untracked → wick      #7A6A55 / 243  dim but present
"   Modified/Dirty  → wax       #C8955A / 173  same as def/class
"   Staged/Renamed  → wax       #C8955A / 173  prepared
"   Deleted         → ember     #5A1A1A / 52   burned away
"   Unmerged        → deep red  #CC3333 / 196  conflict
"   Ignored/Clean   → shadow    #383838 / 237  nothing happening
" ================================================================
let g:NERDTreeGitStatusHighlightingCustom = {
\   'Modified':  'ctermfg=173 ctermbg=NONE cterm=NONE guifg=#C8955A guibg=NONE gui=NONE',
\   'Dirty':     'ctermfg=173 ctermbg=NONE cterm=NONE guifg=#C8955A guibg=NONE gui=NONE',
\   'Staged':    'ctermfg=173 ctermbg=NONE cterm=NONE guifg=#C8955A guibg=NONE gui=NONE',
\   'Renamed':   'ctermfg=173 ctermbg=NONE cterm=NONE guifg=#C8955A guibg=NONE gui=NONE',
\   'Untracked': 'ctermfg=243 ctermbg=NONE cterm=NONE guifg=#7A6A55 guibg=NONE gui=NONE',
\   'Deleted':   'ctermfg=52  ctermbg=NONE cterm=NONE guifg=#5A1A1A guibg=NONE gui=NONE',
\   'Unmerged':  'ctermfg=196 ctermbg=NONE cterm=bold guifg=#CC3333 guibg=NONE gui=bold',
\   'Ignored':   'ctermfg=237 ctermbg=NONE cterm=NONE guifg=#383838 guibg=NONE gui=NONE',
\   'Clean':     'ctermfg=237 ctermbg=NONE cterm=NONE guifg=#383838 guibg=NONE gui=NONE',
\   'Unknown':   'ctermfg=240 ctermbg=NONE cterm=NONE guifg=#555555 guibg=NONE gui=NONE',
\ }

" ================================================================
" MINIMAP — disable plugin colour reset so our highlights stick
" ================================================================
let g:minimap_enable_highlight_colorgroup = 0

" ================================================================
" PLUGINS
" ================================================================
call plug#begin()

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'dense-analysis/ale'
Plug 'sheerun/vim-polyglot'
Plug 'ryanoasis/vim-devicons'
Plug 'wfxr/minimap.vim'
Plug 'airblade/vim-gitgutter'
Plug 'vim-test/vim-test'

call plug#end()

" ================================================================
" COLORSCHEME — after plugins
" ================================================================
set cursorline
colorscheme candle-light
let g:airline_theme='candle_light'

" ================================================================
" SEARCH
" ================================================================
set ignorecase
set smartcase
set incsearch
set hlsearch

" ================================================================
" SPLITS
" ================================================================
set splitbelow
set splitright

" ================================================================
" PERSISTENT UNDO — run once: mkdir -p ~/.vim/undodir
" ================================================================
set undofile
set undodir=~/.vim/undodir

" ================================================================
" MINIMAP settings
" ================================================================
let g:minimap_width = 10
let g:minimap_auto_start = 1
let g:minimap_auto_start_win_enter = 1
let g:minimap_highlight_range = 1
let g:minimap_highlight_search = 1
let g:minimap_git_colors = 1

" ================================================================
" CANDLE HIGHLIGHT FUNCTIONS
" Called on VimEnter (after all plugins load) to beat plugin
" load-time colour resets. Also on ColorScheme and BufEnter.
"
" Unified git colour language across all three systems:
"   Added    → wick  #7A6A55 / 243   dim but present
"   Modified → wax   #C8955A / 173   changed — same as def/class
"   Deleted  → ember #5A1A1A / 52    burned away
" ================================================================

function! s:MinimapCandle()
    " Viewport indicator — warm dark bg, ivory fg (matches CursorLine)
    highlight minimapCursor            ctermbg=234 ctermfg=230 cterm=NONE guibg=#1E1A14 guifg=#F5EFE0 gui=NONE
    highlight minimapRange             ctermbg=234 ctermfg=230 cterm=NONE guibg=#1E1A14 guifg=#F5EFE0 gui=NONE
    " Diff — wick/wax/ember, matching gitgutter
    highlight minimapDiffAdded                     ctermfg=243 cterm=NONE               guifg=#7A6A55 gui=NONE
    highlight minimapDiffLine                      ctermfg=173 cterm=NONE               guifg=#C8955A gui=NONE
    highlight minimapDiffRemoved                   ctermfg=52  cterm=NONE               guifg=#5A1A1A gui=NONE
    highlight minimapCursorDiffAdded   ctermbg=234 ctermfg=243 cterm=NONE guibg=#1E1A14 guifg=#7A6A55 gui=NONE
    highlight minimapCursorDiffLine    ctermbg=234 ctermfg=173 cterm=NONE guibg=#1E1A14 guifg=#C8955A gui=NONE
    highlight minimapCursorDiffRemoved ctermbg=234 ctermfg=52  cterm=NONE guibg=#1E1A14 guifg=#5A1A1A gui=NONE
    highlight minimapRangeDiffAdded    ctermbg=234 ctermfg=243 cterm=NONE guibg=#1E1A14 guifg=#7A6A55 gui=NONE
    highlight minimapRangeDiffLine     ctermbg=234 ctermfg=173 cterm=NONE guibg=#1E1A14 guifg=#C8955A gui=NONE
    highlight minimapRangeDiffRemoved  ctermbg=234 ctermfg=52  cterm=NONE guibg=#1E1A14 guifg=#5A1A1A gui=NONE
endfunction

function! s:ALECandle()
    highlight ALEErrorSign   guifg=#CC3333 guibg=NONE gui=NONE     ctermfg=196 ctermbg=NONE
    highlight ALEWarningSign guifg=#D99962 guibg=NONE gui=NONE     ctermfg=214 ctermbg=NONE
    highlight ALEError       guifg=NONE    guibg=NONE gui=underline ctermfg=NONE cterm=underline
    highlight ALEWarning     guifg=NONE    guibg=NONE gui=underline ctermfg=NONE cterm=underline
endfunction

function! s:GitGutterCandle()
    " Added    → wick (dim, present — matches NERDTree Untracked/Added)
    " Modified → wax  (matches NERDTree Modified/Dirty)
    " Deleted  → ember (matches NERDTree Deleted)
    highlight GitGutterAdd    guifg=#7A6A55 guibg=NONE gui=NONE ctermfg=243 ctermbg=NONE
    highlight GitGutterChange guifg=#C8955A guibg=NONE gui=NONE ctermfg=173 ctermbg=NONE
    highlight GitGutterDelete guifg=#5A1A1A guibg=NONE gui=NONE ctermfg=52  ctermbg=NONE
endfunction

augroup CandleHighlights
    autocmd!
    autocmd VimEnter    *       call s:MinimapCandle()
    autocmd VimEnter    *       call s:ALECandle()
    autocmd VimEnter    *       call s:GitGutterCandle()
    autocmd ColorScheme *       call s:MinimapCandle()
    autocmd ColorScheme *       call s:ALECandle()
    autocmd ColorScheme *       call s:GitGutterCandle()
    autocmd BufEnter    minimap call s:MinimapCandle()
augroup END

" ================================================================
" ALE config
" ================================================================
let g:ale_linters = {
\   'python': ['ruff', 'mypy'],
\}
let g:ale_fixers = {
\   'python': ['ruff'],
\}
let g:ale_fix_on_save = 1
let g:ale_python_mypy_options = '--ignore-missing-imports'
let g:ale_sign_error   = '▌'
let g:ale_sign_warning = '▌'

" ================================================================
" GITGUTTER
" ================================================================
let g:gitgutter_enabled = 1
let g:gitgutter_sign_added              = '▌'
let g:gitgutter_sign_modified           = '▌'
let g:gitgutter_sign_removed            = '▌'
let g:gitgutter_sign_removed_first_line = '▌'
let g:gitgutter_sign_modified_removed   = '▌'

" ================================================================
" VIM-TEST
" ================================================================
let test#strategy = 'vimterminal'
let test#python#runner = 'pytest'

nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tv :TestVisit<CR>

" ================================================================
" NERDTREE
" ================================================================
let g:NERDTreeShowHidden = 1
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusConcealBrackets = 1

" Unique bar characters per git state — same visual weight,
" unique codepoints so syntax engine colours each independently.
"   ▎ Modified/Dirty/Staged/Renamed → wax
"   ▏ Untracked/Clean/Ignored       → wick/shadow
"   ▋ Deleted                       → ember
"   ▊ Unmerged                      → deep red
let g:NERDTreeGitStatusIndicatorMapCustom = {
\   'Modified':  '▎',
\   'Dirty':     '▎',
\   'Staged':    '▎',
\   'Renamed':   '▎',
\   'Untracked': '▏',
\   'Deleted':   '▋',
\   'Unmerged':  '▊',
\   'Ignored':   '▏',
\   'Clean':     '▏',
\   'Unknown':   '▏',
\ }

" ================================================================
" KEYBINDINGS
" ================================================================
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-s> :w<CR>
nnoremap <C-m> :MinimapToggle<CR>

" ================================================================
" LAYOUT — open NERDTree + empty buffer when launching on a dir
" ================================================================
function! OpenDirLayout()
    if isdirectory(argv(0))
        NERDTree
        wincmd l
        enew
    endif
endfunction

autocmd VimEnter * call OpenDirLayout()
