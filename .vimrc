" === SET LEADER ===
let mapleader = "\<Space>"

" === PLUGINS ===

call plug#begin()

Plug 'tpope/vim-sensible' " some sensible defaults

" look and feel
Plug 'itchyny/lightline.vim' " status bar
Plug 'mhinz/vim-startify' " fancy start screen
Plug 'junegunn/goyo.vim' " focus on text writing; use <S-F9>
Plug 'Yggdroot/indentLine' " display lines along indentations
Plug 'tribela/vim-transparent' " use terminal's transparency setting
Plug 'ryanoasis/vim-devicons' " icons for NERDTree
Plug 'lambdalisue/glyph-palette.vim' " for coloring icons

" themes
Plug 'arcticicestudio/nord-vim'
Plug 'ghifarit53/tokyonight-vim'
Plug 'haishanh/night-owl.vim'
Plug 'vv9k/vim-github-dark'

" navigation
Plug 'preservim/nerdtree' " file navigation tree; use <S-F8>
Plug 'junegunn/fzf' " fuzzy finder; use <S-F7>
Plug 'voldikss/vim-floaterm' " floating terminal; use \t to open, \f to open and launch ranger
Plug 'ctrlpvim/ctrlp.vim' " full path fuzzy file, buffer, tag, ... finder via <c-p> + <c-f>

" git related
Plug 'tpope/vim-fugitive' " git commands via :Git <command>
Plug 'airblade/vim-gitgutter' " live display of git differences

" functionality
Plug 'Ron89/thesaurus_query.vim' " thesaurus; use \cs to open
Plug 'tpope/vim-commentary' " comment line with 'gcc'; comment selection with 'gc'
Plug 'tpope/vim-surround' " change, add, remove surroundings like (), [] etc.
Plug 'jiangmiao/auto-pairs' " add pairs, e.g. (), [] etc.
Plug 'ervandew/supertab' " autocomplete with tab-key
Plug 'godlygeek/tabular'

" markdown-preview:
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Linters, LSPs etc.
"Plug 'dmerejkowsky/vim-ale' " asynchonous lint engine

call plug#end()


" === SETTINGS ===

" --- look and feel ---

" save view when closing and restore when opening vim:
autocmd BufWinLeave *.* mkview
autocmd BufWinEnter *.* silent loadview

" style of line numbering:
set number " show line numbers
set nu rnu " turn hybrid line numbers on

" folding:
"set foldmethod=indent

" chow cursorline:
set cursorline
autocmd BufWinEnter *.* highlight CursorLine guibg=#182028

" coloring icons:
augroup my-glyph-palette
  autocmd! *
  autocmd FileType fern call glyph_palette#apply()
  autocmd FileType nerdtree,startify call glyph_palette#apply()
augroup END

" markdown syntax for qmd files:
au BufRead,BufNewFile *.qmd set filetype=markdown

" formatting:
set autoindent
set smartindent
set smarttab
set shiftwidth=2 " on pressing tab, insert 2 spaces
set tabstop=2 " when indenting with '>', use 2 spaces width
set expandtab
filetype plugin indent on " show existing tab with 2 spaces width

" intuitive window splitting:
set splitbelow
set splitright

" NERDTree look and feel
let NERDTreeMinimalUI=1
let g:NERDTreeDirArrowExpandable = ''
let g:NERDTreeDirArrowCollapsible = ''
let NERDTreeShowBookmarks=1

" use mouse
set mouse=a


" --- mappings ---
nmap <S-F7> :FZF<cr>
nmap <S-F8> :NERDTreeToggle<cr>
nmap <S-F9> :Goyo<cr>
let g:ctrlp_cmd = 'CtrlPMRU' " start ctrlp in mru-mode (includes buffers)
let g:floaterm_keymap_new = '<Leader>t'
nmap <Leader>r :FloatermNew ranger<cr>

" colortheme (e.g. in floaterm)for ghdark which I also use in gnome-terminal
let g:terminal_ansi_colors = [
  \'#43484E', '#E68989', '#FA7970', '#FAA356',
  \'#75BDFB', '#B28ED9', '#A2D2FB', '#88919A',
  \'#42474E', '#E68989', '#FA7970', '#FAA356',
  \'#75BDFB', '#DCC7FF', '#A7D5FF', '#ACB1B5' ]
highlight Terminal guibg='#161B22'
highlight Terminal guifg='#ECF2F8'


" --- themes ---

syntax enable
if (has("termguicolors"))  " enable true colors support
 set termguicolors
endif
colorscheme ghdark
let g:lightline = {'colorscheme': 'ghdark'}
set encoding=UTF-8 " must have for webdevicons
set t_Co=256 " this is may or may not needed.
set fillchars+=vert:\  " replace vertical lines in borders by whitespaces


" --- startify ---

nmap <c-s> :Startify<cr>
let g:startify_files_number = 8
let g:startify_custom_header = []
let g:startify_bookmarks = [
  \ { 'w': '~/Nextcloud/GitHub/website' },
  \ { 'b': '~/Nextcloud/GitHub/website/blog' },
  \ ]
function! s:gitModified() " returns all modified files of the current git repo
  let files = systemlist('git ls-files -m 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction
function! s:gitUntracked() " same as above, but show untracked files, honouring .gitignore
  let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction
let g:startify_lists = [
  \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
  \ { 'type': 'files',     'header': ['   MRU']            },
  \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
  \ { 'type': 'sessions',  'header': ['   Sessions']       },
  \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
  \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
  \ { 'type': 'commands',  'header': ['   Commands']       },
  \ ]

