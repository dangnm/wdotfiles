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

function! ClearHighlight()
  let @/ = ""
endfunction

function! ListFilesInCurrentDir()
  execute "Files"." ".expand("%:h")
endfunction

function! CopyCurrentPath()
  let @*=expand("%:p") | echo expand("%:p")
endfunction

function! CopyCurrentFileName()
  let @*=expand("%:t") | echo expand("%:t")
endfunction

" General
Plug 'liuchengxu/vim-which-key'
Plug 'scrooloose/nerdtree'

" UI
Plug 'itchyny/lightline.vim' "Bottom statusline
Plug 'Yggdroot/indentLine' "Display the indention levels with thin vertical lines

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

" Other tools
Plug 'jceb/vim-orgmode'

call plug#end()

"========================================================
" MAPPING which key (leader guide)
"========================================================
let g:mapleader = "\<Space>"
let g:maplocalleader = ','
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>


" Define prefix dictionary
let g:which_key_map =  {}
let g:which_key_map.s = {
      \ 'name' : 'search'                                            ,
      \ 'p' : ['Ag'     , 'Ag search']       ,
      \ 'b' : ['Buffers'     , 'Buffers']       ,
      \ 'c' : ['ClearHighlight()'     , 'Clear highlight']       ,
      \ 'a' : {
         \ 'name': 'ag',
         \ 'a' : ['Ag'     , 'Ag search']       ,
         \ 'd' : ['AgD' , 'Ag current dir']  ,
      \ },
      \ }

let g:which_key_map.b = {
      \ 'name' : 'buffers'                                            ,
      \ 'b' : ['Buffers'     , 'Show buffers']       ,
      \ }

let g:which_key_map.f = {
      \ 'name' : 'files'                                            ,
      \ 'n' : ['NERDTreeToggleInCurDir()'     , 'NERD tree']       ,
      \ 'f' : ['ListFilesInCurrentDir()'     , 'Files in current dir']       ,
      \ 'y' : ['CopyCurrentPath()'     , 'Copy current path']       ,
      \ 'Y' : ['CopyCurrentFileName()'     , 'Copy current filename']       ,
      \ 'q' : ['q'     , 'Quit']       ,
      \ 'Q' : ['qa'     , 'Quit all']       ,
      \ }

let g:which_key_map.g = {
      \ 'name' : 'git'                                            ,
      \ 'b' : ['Gblame'     , 'Blame']       ,
      \ }

let g:which_key_map.p = {
      \ 'name' : 'projects'                                            ,
      \ 'f' : ['Files'     , 'Files search']       ,
      \ }

let g:which_key_map.t = {
      \ 'name' : 'tabs/toggles'                                            ,
      \ 'n' : [':tab sp', 'New tab'],
      \ 'l' : ['tabnext', 'Next tab'],
      \ 'h' : ['tabprev', 'Previous tab'],
      \ 'j' : ['tabfirst', 'First tab'],
      \ 'k' : ['tablast', 'Last tab'],
      \ 'c' : ['tabclose', 'Close tab'],
      \ '1' : ['feedkeys("1gt")', 'Tab 1'],
      \ '2' : ['feedkeys("2gt")', 'Tab 2'],
      \ '3' : ['feedkeys("3gt")', 'Tab 3'],
      \ '4' : ['feedkeys("4gt")', 'Tab 4'],
      \ 't' : {
         \ 'name': 'toggles',
         \ 'a' : ['deoplete#toggle()'     , 'Auto completion'],
         \ 'i' : ['IndentLinesToggle' , 'Indent guide'],
         \ },
      \ }

let g:which_key_map.w = {
      \ 'name' : 'windows'                                            ,
      \ 'f' : ['Files'     , 'Files search']       ,
      \ '/' : ['vsplit', 'Split window right'],
      \ 's' : ['split', 'Split window bellow'],
      \ 'l' : ['call feedkeys("\<C-W>l")', 'Window right'],
      \ 'h' : ['call feedkeys("\<C-W>h")', 'Window left'],
      \ 'j' : ['call feedkeys("\<C-W>j")', 'Window down'],
      \ 'k' : ['call feedkeys("\<C-W>k")', 'Window up'],
      \ '=' : ['call feedkeys("\<C-W>=")', 'Balance windows'],
      \ 'd' : ['call feedkeys("\<C-W>c")', 'Close window'],
      \ 'r' : {
         \ 'name': 'resize',
         \ 'l' : [':call feedkeys("\<C-W>\>")', 'Increase width'],
         \ 'h' : [':call feedkeys("\<C-W>\<")', 'Decrease width'],
         \ 'k' : [':call feedkeys("\<C-W>+")', 'Increase height'],
         \ 'j' : [':call feedkeys("\<C-W>-")', 'Decrease height'],
         \ 'm' : [':res +1000 | vertical res 100', 'Maximize window size'],
         \ },
      \ }

let g:which_key_map.j = {
      \ 'name' : 'jump'                                            ,
      \ 'g' : [':call GenerateCTAGS()', 'Generate CTAGS'],
      \ 't' : [':call feedkeys("\<C-]>")', 'To definition'],
      \ }

let g:which_key_map.z = {
      \ 'name' : 'zoom'                                            ,
      \ 'c' : ['zc', 'close fold(zc)'],
      \ 'o' : ['zo', 'open fold(zo)'],
      \ 'M' : ['zM', 'close all folds(zM)'],
      \ 'R' : ['zR', 'open all folds(zR)'],
      \ }

call which_key#register('<Space>', "g:which_key_map")

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
colorscheme gruvbox "Install theme
let g:auto_ctags = 1 "Tags for definition jump
set notagrelative "Tags for definition jump
set tags=s:gitdir "Tags for definition jump
set foldmethod=indent     " Fold by indent
set foldlevel=1           " Starting fold at level 1
set foldlevelstart=20     " Open all folds by default"
set foldnestmax=20        " Deepest fold is 20 levels
set nofoldenable          " Disable fold by default


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

"========================================================
" CONFIG INDENT LINE
"========================================================
if s:IsPlugged('indentLine')
    let g:indentLine_enabled              = 0
    let g:indentLine_showFirstIndentLevel = 1
    let g:indentLine_noConcealCursor      = 1
    let g:indentLine_color_term           = 239
endif
