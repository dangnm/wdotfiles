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
Plug 'tpope/vim-surround'

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
let g:lmap.f.n = ['NERDTreeToggle','NERD tree']
let g:lmap.f.f = ['execute "Files"." ".expand("%:h")','Files in current dir']
let g:lmap.f.y = ['let @*=expand("%:p") | echo expand("%:p")', 'Copy current path']
let g:lmap.f.q = ['q', 'Quit']

let g:lmap.g = { 'name' : 'Git' }
let g:lmap.g.b = ['Gblame','Blame']

let mapleader=" "

call leaderGuide#register_prefix_descriptions("<Space>", "g:lmap")
nnoremap <silent> <leader> :<c-u>LeaderGuide '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>LeaderGuideVisual '<Space>'<CR>

"========================================================
" EDITOR CONFIGS
"========================================================
set clipboard=unnamed

"========================================================
" MAPPING NERDTree
"========================================================
nnoremap <silent> <F9>  :NERDTreeToggle<CR>
inoremap <silent> <F9>  <Esc>:NERDTreeToggle<CR>
nnoremap <silent> <F10> :NERDTreeFind<CR>
inoremap <silent> <F10> <Esc>:NERDTreeFind<CR>

" ================FZF=================
let g:fzf_tags_command = 'ctags -R --exclude=.git --exclude=node_modules'
let $FZF_DEFAULT_COMMAND = 'ag --hidden --ignore .git --ignore node_modules -l -g ""'
command! -bang -nargs=* AgD
  \ call fzf#vim#ag(<q-args>,
  \                 extend(
  \                 <bang>0 ? fzf#vim#with_preview('up:60%')
  \                         : fzf#vim#with_preview('right:50%:hidden', '?'), {"dir": expand("%:h")}),
  \                 <bang>0)




