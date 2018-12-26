"========================================================
" INSTALL PLUGINS
"========================================================
filetype off
call plug#begin('~/.vim/plugged')

" General
Plug 'hecal3/vim-leader-guide'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'

" Edit Tools
Plug 'tpope/vim-surround' "Add surrounding quote mark
Plug 'tomtom/tcomment_vim' "Comment code
Plug 'easymotion/vim-easymotion' "Goto char
Plug 'w0rp/ale' "Lint/Rubocop

" Search
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" GIT vim
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

call plug#end()


"========================================================
" MAPPING leader guide
"========================================================
" Define prefix dictionary
let g:lmap =  {}

" Second level dictionaries:
let g:lmap.s = { 'name' : 'Search' }
let g:lmap.s.f = ['Files', 'Files search']
let g:lmap.s.a = { 'name' : 'Ag search' }
let g:lmap.s.a.a = ['Ag', 'Ag search']
let g:lmap.s.a.d = ['AgD','Ag current dir']
let g:lmap.s.b = ['Buffers', 'Buffers']

let g:lmap.h = { 'name' : 'Gitgutter' }

let g:lmap.f = { 'name' : 'File Menu' }
let g:lmap.f.n = ['call NERDTreeToggleInCurDir()','NERD tree']
let g:lmap.f.f = ['execute "Files"." ".expand("%:h")','Files in current dir']
let g:lmap.f.y = ['let @*=expand("%:p") | echo expand("%:p")', 'Copy current path']
let g:lmap.f.q = ['q', 'Quit']

let g:lmap.g = { 'name' : 'Git' }
let g:lmap.g.b = ['Gblame','Blame']

let g:lmap.p = { 'name' : 'Projects' }
let g:lmap.p.f = ['Files', 'Files search']

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

"========================================================
" MAPPING NERDTree
"========================================================
nnoremap <silent> <F9>  :NERDTreeToggle<CR>
inoremap <silent> <F9>  <Esc>:NERDTreeToggle<CR>
nnoremap <silent> <F10> :NERDTreeFind<CR>
inoremap <silent> <F10> <Esc>:NERDTreeFind<CR>
function! NERDTreeToggleInCurDir()
  " If NERDTree is open in the current buffer
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    exe ":NERDTreeFind"
  endif
endfunction

" ================FZF=================
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules'
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -l -g ""'
command! -bang -nargs=* AgD
  \ call fzf#vim#ag(<q-args>,
  \                 extend(
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'), {"dir": expand("%:h")}),
  \                 <bang>0)

"========================================================
" MAPPING EASYMOTION
"========================================================
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)

" ===========ALE config===============
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
