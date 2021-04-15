set nocompatible
syntax on

set showcmd

set backspace=indent,eol,start
set hidden

set relativenumber

set history=500

filetype on
filetype plugin on
filetype indent on

set autoread

set whichwrap+=<,>,h,l


set ignorecase
set smartcase

set path+=**

set scrolloff=8

set hlsearch
set incsearch

set lazyredraw

set magic

set showmatch

set mat=1

set noerrorbells
set novisualbell
set t_vb=
set tm=500

set encoding=UTF-8

set ffs=unix,dos,mac

set nobackup
set nowritebackup
set noswapfile

set shiftround

" disable annoying comment on newline
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" custom indent options
autocmd FileType txt setlocal tw=0 spell noexpandtab wrap linebreak
autocmd FileType css setlocal ts=4 sw=4 sts=4
autocmd FileType html setlocal ts=2 sw=2 sts=2
autocmd FileType ruby setlocal ts=2 sw=2 sts=2
autocmd FileType python setlocal ts=4 sw=4 sts=4
autocmd FileType nim setlocal ts=2 sw=2 sts=2 noexpandtab
autocmd FileType c setlocal ts=8 sw=8 sts=8 noexpandtab
autocmd FileType cpp setlocal ts=2 sw=2 sts=2 noexpandtab
autocmd FileType qml setlocal ts=4 sw=4 sts=4
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0

set ai
set si
set wrap
set lbr

set ssop-=options,folds

set wildmenu
set wildmode=list:longest,full

set wildignore=*.o,*~,*.pyc,**/node_modules/**,**/venv/**,**/__pycache__
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.png,*.ico
set wildignore+=*.pdf,*.psd
set wildignore+=**/node_modules/**,**/bower_components/**

set mouse+=a

noremap :W :w

set mousemodel=popup_setpos

noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')


vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

map <silent> <leader><cr> :noh<cr>


map <silent> <C-j> <C-W>j
map <silent> <C-k> <C-W>k
map <silent> <C-h> <C-W>h
map <silent> <C-l> <C-W>l

nnoremap <silent> <Up> :tabnew<cr>
nnoremap <silent> <Down> :tabclose<cr>
nnoremap <silent> <Left> :tabNext<CR>
nnoremap <silent> <Right> :tabnext<cr>

nnoremap gf :vertical wincmd f<CR>

set splitbelow
set splitright

au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


map 0 ^

fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

" Disable Arrow keys in Insert mode
inoremap <Up> <Nop>
inoremap <Down> <Nop>
inoremap <Left> <Nop>
inoremap <Right> <Nop>

set infercase

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-commentary'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'preservim/nerdtree'

Plug 'itchyny/lightline.vim'

Plug 'twerth/ir_black'

Plug 'vim-python/python-syntax'

call plug#end()

" Lightline settings
"--------------------------------------
set laststatus=2

if !has('gui_running')
  set t_Co=256
endif

" coc-vim settings
"-------------------------------------
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

">>>>>>>>>>>>>>>>>>>>>>>
" Coc Extensions
"<<<<<<<<<<<<<<<<<<<<<<<
let g:coc_global_extensions = ['coc-clangd', 'coc-cmake', 'coc-css', 'coc-cssmodules', 'coc-emmet', 'coc-eslint', 'coc-html', 'coc-jedi', 'coc-json', 'coc-markdownlint', 'coc-spell-checker', 'coc-yaml', 'coc-sql']

"NerdTree settings
"-----------------------------

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" enable line numbers
let NERDTreeShowLineNumbers=1
" make sure relative line numbers are used
autocmd FileType nerdtree setlocal relativenumber

nnoremap <silent> <space>n :NERDTreeToggle<CR>

" Auto surround
" --------------------

vnoremap <space>( <esc>`>a)<esc>`<i(<esc>
vnoremap <space>{ <esc>`>a}<esc>`<i{<esc>
vnoremap <space>[ <esc>`>a]<esc>`<i[<esc>
vnoremap <space>" <esc>`>a"<esc>`<i"<esc>
vnoremap <space>' <esc>`>a'<esc>`<i'<esc>

" python-syntax settings
"--------------------------
let g:python_highlight_all = 1

" Color Settings
" ---------------------
if !has('gui_running')
	set t_Co=256
endif

if has('nvim') || has('termguicolors')
	set termguicolors
endif

set background=dark
set cursorline
colorscheme ir_black
