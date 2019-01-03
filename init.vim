"========================================================
" INSTALL PLUGINS
"========================================================
filetype off
call plug#begin('~/.vim/plugged')

" Helpers
"
let s:python3 = has('python3')
let s:show_missing_plugin_warning = 'true'
let s:gitdir = substitute(system("git rev-parse --show-toplevel 2>/dev/null"), '\n\+$', '', '')

function! GenerateCTAGS()
  if (strlen(s:gitdir) > 0)
    exe '!ctags -R -f '.s:gitdir.'/.git/tags '.s:gitdir
  endif
endfunction

function! s:CheckPlugged(plugin) abort
  if !s:IsPlugged(a:plugin) && s:show_missing_plugin_warning == 'true'
    echo 'Please install '.a:plugin
  endif
  return s:IsPlugged(a:plugin)
endfunction

function! s:IsPlugged(plugin) abort
  return has_key(g:plugs, a:plugin)
endfunction

" General
Plug 'hecal3/vim-leader-guide'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'

" Edit Tools
Plug 'tpope/vim-surround' "Add surrounding quote mark
Plug 'tomtom/tcomment_vim' "Comment code
Plug 'easymotion/vim-easymotion' "Goto char
Plug 'w0rp/ale' "Lint/Rubocop
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
endif

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" GIT vim
Plug 'mhinz/vim-signify' "Sign column to indicate added, modified and removed lines
Plug 'tpope/vim-fugitive'

call plug#end()

"========================================================
" MAPPING leader guide
"========================================================
" Define prefix dictionary
let g:lmap =  {}

" Multilevel dictionaries:
let g:lmap.s = { 'name' : 'Search' }
let g:lmap.s.f = ['Files', 'Files search']
let g:lmap.s.a = { 'name' : 'Ag search' }
let g:lmap.s.a.a = ['Ag', 'Ag search']
let g:lmap.s.a.d = ['AgD','Ag current dir']
let g:lmap.s.b = ['Buffers', 'Buffers']
let g:lmap.s.c = ['let @/ = ""', 'Clear highlight']

let g:lmap.f = { 'name' : 'File Menu' }
let g:lmap.f.n = ['call NERDTreeToggleInCurDir()','NERD tree']
let g:lmap.f.f = ['execute "Files"." ".expand("%:h")','Files in current dir']
let g:lmap.f.y = ['let @*=expand("%:p") | echo expand("%:p")', 'Copy current path']
let g:lmap.f.q = ['q', 'Quit']
let g:lmap.f.Q = ['qa', 'Quit all']

let g:lmap.g = { 'name' : 'Git' }
let g:lmap.g.b = ['Gblame','Blame']

let g:lmap.p = { 'name' : 'Projects' }
let g:lmap.p.f = ['Files', 'Files search']

let g:lmap.t = { 'name' : 'Tabs/Toggles' }
let g:lmap.t.n = ['tab sp', 'New tab']
let g:lmap.t.l = ['tabnext', 'Next tab']
let g:lmap.t.h = ['tabprev', 'Previous tab']
let g:lmap.t.j = ['tabfirst', 'First tab']
let g:lmap.t.k = ['tablast', 'Last tab']
let g:lmap.t.c = ['tabclose', 'Close tab']
let g:lmap.t.1 = ['call feedkeys("1gt")', 'Tab 1']
let g:lmap.t.2 = ['call feedkeys("2gt")', 'Tab 2']
let g:lmap.t.3 = ['call feedkeys("3gt")', 'Tab 3']
let g:lmap.t.4 = ['call feedkeys("4gt")', 'Tab 4']
let g:lmap.t.t = { 'name' : 'Toggles' }
let g:lmap.t.t.a = ['call deoplete#toggle()', 'Auto completion']

let g:lmap.w = { 'name' : 'Windows' }
let g:lmap.w = {
      \'name' : 'Windows',
      \'/' : ['vsplit', 'Split window right'],
      \'s' : ['split', 'Split window bellow'],
      \'l' : ['call feedkeys("\<C-W>l")', 'Window right'],
      \'h' : ['call feedkeys("\<C-W>h")', 'Window left'],
      \'j' : ['call feedkeys("\<C-W>j")', 'Window down'],
      \'k' : ['call feedkeys("\<C-W>k")', 'Window up'],
      \'=' : ['call feedkeys("\<C-W>=")', 'Balance windows'],
      \'d' : ['call feedkeys("\<C-W>c")', 'Close window']
      \}

let g:lmap.w.r = { 'name' : 'Resize' }
let g:lmap.w.r.l = ['call feedkeys("\<C-W>\>")', 'Increase width']
let g:lmap.w.r.h = ['call feedkeys("\<C-W>\<")', 'Decrease width']
let g:lmap.w.r.k = ['call feedkeys("\<C-W>+")', 'Increase height']
let g:lmap.w.r.j = ['call feedkeys("\<C-W>-")', 'Decrease height']
let g:lmap.w.r.m = ['res +1000 | vertical res 100', 'Maximize window size']

let g:lmap.j = { 'name' : 'Jump' }
let g:lmap.j.g = ['call GenerateCTAGS()', 'Generate CTAGS']
let g:lmap.j.t = ['call feedkeys("\<C-]>")', 'To definition']

let mapleader=" "

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

"========================================================
" EDITOR CONFIGS
"========================================================
set clipboard=unnamed
set ruler
set ai "Auto indent
set number " Show line numbers
syntax on " Highlight syntax
set expandtab "Convert tab to spaces
set bs=2 tabstop=2 shiftwidth=2 softtabstop=2 "Default space number for backspace, tab
colorscheme monokai "Theme monokai
let g:auto_ctags = 1 "Tags for definition jump
set notagrelative "Tags for definition jump
set tags=s:gitdir "Tags for definition jump


"========================================================
" MAPPING NERDTree
"========================================================
if s:CheckPlugged('nerdtree')
  nnoremap <silent> <F9>  :NERDTreeToggle<CR>
  inoremap <silent> <F9>  <Esc>:NERDTreeToggle<CR>
  nnoremap <silent> <F10> :NERDTreeFind<CR>
  inoremap <silent> <F10> <Esc>:NERDTreeFind<CR>
  function! NERDTreeToggleInCurDir()
    " If NERDTree is open in the current buffer
    if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
      exe ":NERDTreeClose"
    elseif (expand('%:t') == '')
      exe ":NERDTreeToggle"
    else
      exe ":NERDTreeFind"
    endif
  endfunction
endif

" ================FZF=================
if s:CheckPlugged('fzf')
  let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules'
  let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -l -g ""'
  command! -bang -nargs=* AgD
        \ call fzf#vim#ag(<q-args>,
        \                 extend(
        \                 <bang>0 ? fzf#vim#with_preview('up:60%')
        \                         : fzf#vim#with_preview('right:50%:hidden', '?'), {"dir": expand("%:h")}),
        \                 <bang>0)
endif

"========================================================
" MAPPING EASYMOTION
"========================================================
if s:CheckPlugged('vim-easymotion')
  let g:EasyMotion_do_mapping = 0
  let g:EasyMotion_smartcase = 1
  map / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)
endif

" ===========ALE config===============
if s:CheckPlugged('ale')
  let g:ale_sign_error = '✘'
  let g:ale_sign_warning = '⚠'
  highlight ALEErrorSign ctermbg=NONE ctermfg=red
  highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
  let g:ale_echo_msg_error_str = '✘ Error'
  let g:ale_echo_msg_warning_str = '⚠ Warning'
  let g:ale_echo_msg_format = '[%linter%] [%severity%] %s'
  let g:ale_list_window_size = 5
  let g:ale_linters = {'jsx': ['stylelint', 'eslint'], 'go': ['gometalinter', 'gofmt']}
  let g:ale_fixers = {
        \   'javascript': [
        \       'prettier',
        \       'eslint',
        \   ],
        \   'ruby': ['rubocop']
        \}
  let g:javascript_plugin_flow = 1
  autocmd BufWritePost *.js,*.jsx,*.py,*.rb ALEFix
  autocmd FileType ruby compiler ruby
endif

"========================================================
" CONFIG DEOPLETE
"========================================================
if s:IsPlugged('deoplete.nvim') && s:python3
  let g:deoplete#enable_at_startup = 1
endif
