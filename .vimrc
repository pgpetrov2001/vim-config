let mapleader = " "
set nocompatible
"set timeoutlen=50
set ttimeoutlen=50

let g:netrw_keepdir = 0
let g:netrw_preview = 1
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1

" set signcolumn=yes
" so that it doesn't move when signs are added
set signcolumn=no

function MyUndotreeToggle()
    if undotree#UndotreeIsVisible()
        call undotree#UndotreeHide()
        setlocal signcolumn=no
    else
        setlocal signcolumn=yes
        call undotree#UndotreeShow()
        silent exec 'nnoremap <buffer> q :call MyUndotreeToggle()<cr>'
    endif
endfunction

call plug#begin('~/.vim/plugs/')
Plug 'github/copilot.vim'
" Plug 'junegunn/vim-peekaboo'
" Plug 'tmhedberg/SimpylFold'
" Plug 'briancollins/vim-jst' "wtf is going on
Plug 'mbbill/undotree'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'machakann/vim-swap'
"Plug 'uplus/vim-clang-rename'
"Plug 'Valloric/YouCompleteMe'
", {'rtp': 'vim/'}
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
" Plug 'airblade/vim-gitgutter'
" Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'AndrewRadev/inline_edit.vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'vim-scripts/argtextobj.vim'
Plug 'vim-scripts/visualrepeat'
" Plug 'neoclide/coc.nvim'

if has("nvim")
	Plug 'nvim-lua/plenary.nvim'
	Plug 'williamboman/mason.nvim'
	Plug 'williamboman/mason-lspconfig.nvim'
	Plug 'neovim/nvim-lspconfig'
	Plug 'jose-elias-alvarez/null-ls.nvim'
	Plug 'MunifTanjim/prettier.nvim'
	Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
    Plug 'hrsh7th/nvim-cmp'                   " Autocomplete
    Plug 'hrsh7th/cmp-nvim-lsp'               " LSP source for nvim-cmp
    Plug 'hrsh7th/cmp-nvim-lua'
	Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'hrsh7th/cmp-buffer'                 " Buffer source for nvim-cmp
	Plug 'hrsh7th/cmp-cmdline'
    Plug 'hrsh7th/cmp-path'                   " Path source for nvim-cmp
    Plug 'hrsh7th/cmp-vsnip'                  " Snippet source for nvim-cmp
    Plug 'hrsh7th/vim-vsnip'                  " Snippet engine
endif

call plug#end()

inoremap <c-c> <esc>
nnoremap <c-c> <nop>
nnoremap <c-o> <c-o>zz
nnoremap <Leader>i <C-I>
nmap <Leader>o <C-O>

let g:ftplugin_sql_omni_key = '<C-\>'

" let g:ycm_show_diagnostics_ui = 0
" nnoremap <leader>D <plug>(YCMHover)
" inoremap <c-d> <c-o><plug>(YCMHover)

colorscheme morning
colorscheme gruvbox
set bg=dark
syntax on
set re=0

set nowrap

" TODO: check if script tag has src and open the file if it does
nnoremap <Leader>js /<\/script><cr>:InlineEdit<cr><c-w>T
" TODO: plugin displays js with added indent from html

"silent! call repeat#set("\<Plug>vim-surround", v:count)
"nnoremap <leader><leader>. <Plug>(easymotion-repeat)
"nnoremap <leader><leader>f <Plug>(easymotion-overwin-f)
"nnoremap <leader><leader>w <Plug>(easymotion-overwin-w)
"nnoremap <leader><leader>f <Plug>(easymotion-overwin-f)

"command! -n=0 -bar UndotreeToggle :call MyUndotreeToggle()

"autocmd BufRead,BufNewFile * setlocal signcolumn=yes
"autocmd FileType undotree,tagbar,nerdtree setlocal signcolumn=no



nnoremap <leader>gu :call MyUndotreeToggle()<cr>

:command! -nargs=1 Silent execute ':silent !'.<q-args> | execute ':redraw!'

filetype plugin on
filetype plugin indent on

"let g:html_indent_script1 = "inc"
"let g:html_indent_style1 = "inc"

" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, do not insert 4 spaces
" set noexpandtab
set expandtab

set foldmethod=syntax
set foldlevelstart=1
set foldnestmax=1

let javaScript_fold=1         " JavaScript
let perl_fold=1               " Perl
let php_folding=1             " PHP
let r_syntax_folding=1        " R
let ruby_fold=1               " Ruby
let sh_fold_enabled=1         " sh
"let vimsyn_folding='af'       " Vim script
let xml_syntax_folding=1      " XML
let python_fold=1

" fold highlight color style
augroup MyGroup
  autocmd ColorScheme * hi Folded ctermbg=15 guibg=white
augroup END

set autochdir

"hi Visual term=reverse cterm=reverse guibg=Grey

" recursive search upwards for tags file
"set tags+=tags;$HOME
"nnoremap <C-]> :tab tag <c-r><c-w><cr>


" function! DelTagOfFile(file)
  " let fullpath = a:file
  " let cwd = getcwd()
  " let tagfilename = cwd . "/tags"
  " let f = substitute(fullpath, cwd . "/", "", "")
  " let f = escape(f, './')
  " let cmd = 'sed -i "/' . f . '/d" "' . tags . '"'
  " let resp = system(cmd)
" endfunction
" 
" function! UpdateTags()
  " let f = expand("%:p")
  " let cwd = getcwd()
  " let tagfilename = cwd . '/tags'
  " let cmd = 'ctags -a -f ' . tags . ' --c++-kinds=+p --fields=+iaS --extra=+q ' . '"' . f . '"'
  " call DelTagOfFile(f)
  " let resp = system(cmd)
" endfunction
" autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()
set splitright
set relativenumber
set nu rnu
set nohlsearch
" Make Y yank till end of line
nnoremap Y y$
nnoremap <alt>j <Esc>
set exrc

cnoremap kj <C-C>
"inoremap <C-[> <Noop>

map <Leader>v :vsp ~/.vimrc<ENTER>
" if has("autocmd")
"     autocmd bufwritepost .vimrc source $MYVIMRC
" endif

augroup VimrcGroup
  autocmd!
  " Make changes effective after saving .vimrc. Beware that autocommands are
  " duplicated if .vimrc gets sourced again, unless they are wrapped in an
  " augroup and the autocommands are cleared first using 'autocmd!'
  autocmd bufwritepost $MYVIMRC call OnSavingVimrc()
augroup END

" Avoid infinite loops
if !exists("*OnSavingVimrc")
  function! OnSavingVimrc()
    " Clear previous mappings, they don't go away automatically when sourcing vimrc
    mapclear
    echo "Sourcing Vimrc after saving it"
    source $MYVIMRC
  endfunction
endif

nnoremap <Leader><Tab> :tabm +1<cr>
nnoremap <Leader><S-Tab> :tabm -1<cr>
nnoremap <Tab> :tabnext<cr>
nnoremap <S-Tab> :tabprev<cr>
nnoremap <Leader>t :tabnew<cr>:e<Space>
nnoremap <Leader>e :e<Space>
nnoremap <Leader>w :w<cr>
nnoremap <Leader>W :wq<cr>
nnoremap <Leader>ww :wa<cr>
nnoremap <Leader>WW :wqa<cr>
nnoremap <Leader>Ww :wqa<cr>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :q!<cr>
nnoremap <Leader>qq :qa<cr>
nnoremap <Leader>QQ :qa!<cr>
nnoremap <Leader>Qq :qa!<cr>
nnoremap <Leader>h <c-w>h
nnoremap <Leader>l <c-w>l
nnoremap <Leader>j <c-w>j
nnoremap <Leader>k <c-w>k
nnoremap <Leader>1 :tabn 1<cr>
nnoremap <Leader>2 :tabn 2<cr>
nnoremap <Leader>3 :tabn 3<cr>
nnoremap <Leader>4 :tabn 4<cr>
nnoremap <Leader>5 :tabn 5<cr>
nnoremap <Leader>6 :tabn 6<cr>
nnoremap <Leader>7 :tabn 7<cr>
nnoremap <Leader>8 :tabn 8<cr>
nnoremap <Leader>9 :tabn 9<cr>
nnoremap <Leader>0 :tabn 0<cr>

"allow buffer switching without saving
set hidden

"vim tips below
"searches visual selection
let g:highlighting = 0
function! Highlighting()
  if g:highlighting == 1 && @/ =~ '^\\<'.expand('<cword>').'\\>$'
    let g:highlighting = 0
    return ":silent nohlsearch\<CR>"
  endif
  let @/ = '\<'.expand('<cword>').'\>'
  let g:highlighting = 1
  return ":silent set hlsearch\<CR>"
endfunction

function! s:Scratch (command, ...)
   redir => lines
   let saveMore = &more
   set nomore
   execute a:command
   redir END
   let &more = saveMore
   call feedkeys("\<cr>")
   new | setlocal buftype=nofile bufhidden=hide noswapfile
   put=lines
   if a:0 > 0
      execute 'vglobal/'.a:1.'/delete'
   endif
   if a:command == 'scriptnames'
      %substitute#^[[:space:]]*[[:digit:]]\+:[[:space:]]*##e
   endif
   silent %substitute/\%^\_s*\n\|\_s*\%$
   let height = line('$') + 3
   execute 'normal! z'.height."\<cr>"
   0
endfunction

command! -nargs=? Scriptnames call <sid>Scratch('scriptnames', <f-args>)
command! -nargs=+ Scratch call <sid>Scratch(<f-args>)

nnoremap <silent> <expr> <CR> Highlighting()
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>
" above is search for visually selected text but doesn't work
" from vimtips.org

nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
"set incsearch

" have the mouse be able to click on lines
" and visual select with it
set mouse=a
" if has("clipboard")
"   if v:version > 703 || v:version == 703 && has('patch597')
"       set clipboard^=autoselectplus
"   else
"       set clipboard^=autoselect
"   endif
" endif
nnoremap cy "+y
nnoremap cY "+Y
nnoremap cp "+p
nnoremap cP "+P
nnoremap cd "+d
nnoremap cD "+D
vnoremap cy "+y
vnoremap cY "+Y
vnoremap cp "+p
vnoremap cP "+P
vnoremap cd "+d
vnoremap cD "+D

nnoremap k gk
nnoremap j gj
nnoremap gj j
nnoremap gk k

let $PAGER=''
autocmd VimLeave * call system("xsel -ib", getreg('+'))
set undofile " Maintain undo history between sessions
if has('nvim')
	set undodir=~/.config/nvim/undodir
else
	set undodir=~/.vim/undodir
endif
