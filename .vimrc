syntax on

" set mouse
set mouse=a

" Configure search
set ignorecase smartcase

" Use system's clipboard. Keep platform specific settings
set clipboard+=unnamedplus

" No backup or swapfile
set nobackup nowritebackup noswapfile

" show line numbers
set number numberwidth=2

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<Tab>"
    else
        return "\<C-p>"
    endif
endfunction
inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n><Paste>

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·

" Use one space, not two, after punctuation.
set nojoinspaces

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" highlight the current line
set cursorline
hi CursorLine cterm=NONE ctermbg=grey ctermfg=white guibg=grey guifg=white
hi CursorColumn cterm=NONE ctermbg=grey ctermfg=white guibg=grey guifg=white

" Make escape work in the Neovim terminal.
tnoremap <Esc> <C-\><C-n>

" Use tabs as spaces, default identation: 2 spaces
set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab expandtab shiftround

" set terminal true colors
set termguicolors

" Line breaks
set breakindent
set breakindentopt=sbr

" Spelling
set spellfile=$HOME/.vim/spell/en.utf-8.add spelllang=en

" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" Set spelling, syntax highlighting for Markdown
au BufRead,BufNewFile *.md setlocal spell filetype=markdown

" Automatically wrap at 72 characters and spell check git commit messages
"au FileType gitcommit setlocal textwidth=72 spell

"Syntax highlighting for special files
au BufNewFile,BufRead Gemfile set filetype=ruby
au BufNewFile,BufRead Gemfile.lock set filetype=ruby

" Enable folding
set foldmethod=syntax
au FileType yaml,eruby,haml,html,scss,javascript set foldmethod=indent
set foldlevelstart=99
let g:vimsyn_folding='af'

" Enable filetype specific indenting and plugins
filetype indent plugin on

" Spelling highlights
highlight clear SpellBad
highlight SpellBad guifg=#ff0000 guibg=#ffff00

" Custom key mapings ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
" Leader is space
let mapleader=" "

" Easy splitting
"map <leader>s :split <cr>
"map <leader>v :vsplit <cr>

" New file
nmap <C-n> :call NewFile(input('New file name: '))<cr>
function! NewFile(filename)
  if a:filename == ''
    return
  endif
  exec 'e %:h/' . a:filename
endfunction

" Save file
noremap <leader>w :w <cr>

" Switch between the last two files
nnoremap <leader><leader> <c-^>

" Buffer navigation
nnoremap <leader><Left> :bp <cr>
nnoremap <leader><Right> :bn <cr>

" List buffers and prompt for a number
nnoremap <leader>b :buffers<CR>:buffer<Space>

" Replace hashrockets with 1.9 hash style syntax
nmap <leader>: :%s/:\([^ ]*\)\(\s*\)=>/\1:/gc <cr>o

" Cancel a search with Escape:
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>

" Quickly reload vim
nnoremap <leader>rv :source $MYVIMRC<CR>

" Auto indent whole document
nmap <leader>ai mzgg=G`z

" Folding
map <leader>- za

" Plugins ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
execute pathogen#infect()

" Ale
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'

" Gutentags
call pathogen#helptags()

" Airline
"let g:airline#extensions#tabline#enabled = 1

" Use LightLine instead
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left':  [ [ 'mode', 'paste' ],
      \              [ 'gitbranch', 'filename', 'readonly' ] ],
      \   'right': [ [ 'lineinfo' ], ['percent'],
      \              [ 'fileformat', 'fileencoding', 'filetype' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch':    'LightlineFugitive',
      \   'filename':     'LightlineFilename',
      \   'filetype':     'LightlineFiletype',
      \   'fileformat':   'LightlineFileformat',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode':         'LightlineMode',
      \ },
      \ 'component_type': { 'paste': 'warning' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
   \ }

function! LightlineModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? '' :
        \ ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' != fname ? fname : '[No Name]') .
        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlinePaste()
  return '%{&paste?"PASTE":""}'
endfunction

function! LightlineFugitive()
  try
    if expand('%:t') !~? 'NERD' && exists('*fugitive#head')
      let mark = ''  " edit here for cool mark
      let branch = fugitive#head()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineMode()
  let fname = expand('%:t')
  return fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" Surround with #{}
function! s:InsertInterpolation()
  let before = getline('.')[col('^'):col('.')]
  let after  = getline('.')[col('.'):col('$')]
  " check that we're in double-quotes string
  if before =~# '"' && after =~# '"'
      execute "normal! a{}\<Esc>h"
  endif
endfunction
au FileType ruby,eruby,haml
    \   inoremap <silent><buffer> # #<ESC>:call <SID>InsertInterpolation()<CR>a
    \ | let b:surround_{char2nr('#')} = "#{\r}"

" CtrlSF
nmap <C-f> :CtrlSF 
inoremap <C-f> <Esc>:CtrlSF 
let g:ctrlsf_ackprg = 'ag'
let g:ctrlsf_default_root = 'project'
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_ignore_dir = ['bower_components', 'node_modules', 'log', 'tmp']
let g:ctrlsf_indent = 2
autocmd FileType ctrlsf set nu

" Closetag
let g:closetag_filenames = "*.html,*.xhtml,*.phtml,*.js"

" Emmet
autocmd FileType html,erb,jsx EmmetInstall

" Fuzzy
nnoremap <C-p> :FuzzyOpen<CR>

" Polyglot
let g:jsx_ext_required = 0
let g:rubycomplete_rails = 1

" Sayonara
nnoremap <leader>q :Sayonara<cr>

" Deoplete
let g:deoplete#enable_at_startup = 1

" UltiSnips
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Nerdtree
map <leader>1 :NERDTreeToggle<CR>
map <leader>! :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 &&
      \ exists("b:NERDTree") &&
      \ b:NERDTree.isTabTree()) | q | endif

" Interface ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
let base16colorspace=256

" Nerdtree
" Don't show help, press ? to get it
let g:NERDTreeMinimalUI = 1
" Delete buffer after file rename, delete
let g:NERDTreeAutoDeleteBuffer=1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

