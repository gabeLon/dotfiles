" ~/.vimrc (stow-friendly, sin bootstrap)
" =======================================================

let s:vim_dir = expand('~/.vim')

" =======================================================
" vim-plug
" =======================================================
call plug#begin(s:vim_dir . '/plugged')

" ================================
" Plugins
" ================================
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'junegunn/goyo.vim'
Plug 'reedes/vim-pencil'

Plug 'itchyny/lightline.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'ap/vim-buftabline'

Plug 'ctrlpvim/ctrlp.vim'
Plug 'airblade/vim-gitgutter'
Plug 'dense-analysis/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'majutsushi/tagbar'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-scripts/indentpython.vim'
Plug 'lepture/vim-jinja'

Plug 'preservim/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'instant-markdown/vim-instant-markdown', { 'for': 'markdown' }
Plug 'vimwiki/vimwiki'

call plug#end()

" =======================================================
" Opciones generales
" =======================================================
let mapleader = " "
set number relativenumber
set noerrorbells visualbell t_vb=
set encoding=utf-8 fileencoding=utf-8 fileformat=unix
set mouse=a laststatus=2
set hlsearch incsearch
set foldmethod=indent foldlevel=99
set splitright
set nocompatible
syntax on
filetype plugin indent on

" Colores y tema
set t_Co=256
colorscheme onedark

" Tabs
set tabstop=4 shiftwidth=4 softtabstop=4 expandtab
autocmd FileType html,css,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2

" Restaurar posición previa al abrir archivos
autocmd BufReadPost * if line("'\"")>1 && line("'\"")<=line("$") | exe "normal! g'\"" | endif

" =======================================================
" Mapeos generales
" =======================================================
inoremap jj <ESC>
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nmap <leader><space> :nohlsearch<cr>

" Tabs
nmap <leader>tn :tabnew<cr>
nmap <leader>tt :tabnext<cr>
nmap <leader>tc :tabclose<cr>

" Ventanas
nmap <leader>k :wincmd k<CR>
nmap <leader>j :wincmd j<CR>
nmap <leader>h :wincmd h<CR>
nmap <leader>l :wincmd l<CR>

" Buffers
nmap <leader>hh :bp<CR>
nmap <leader>ll :bn<CR>
nmap <leader>dd :bd<CR>

" Editar vimrc
nnoremap <leader>ev :vsplit $MYVIMRC<CR>

" Netrw
function! ToggleNetrw()
    let i = bufnr("$")
    let wasOpen = 0
    while i >= 1
        if getbufvar(i, "&filetype") == "netrw"
            silent exe "bwipeout " . i
            let wasOpen = 1
        endif
        let i -= 1
    endwhile
    if !wasOpen
        silent Lexplore
    endif
endfunction
nmap <leader>n :call ToggleNetrw()<CR>
let g:netrw_banner=0
let g:netrw_liststyle=3
let g:netrw_browse_split=0
let g:netrw_altv=1
let g:netrw_winsize=25
autocmd VimEnter * :call ToggleNetrw()

" =======================================================
" ALE
" =======================================================
map <C-e> <Plug>(ale_next_wrap)
map <C-r> <Plug>(ale_previous_wrap)

" =======================================================
" Tagbar
" =======================================================
map <leader>t :TagbarToggle<CR>

" =======================================================
" Paste mode
" =======================================================
let &t_SI .= "\<Esc>[?2004h"
let &t_EI .= "\<Esc>[?2004l"
function! XTermPasteBegin()
    set paste
    return ""
endfunction
inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()

" =======================================================
" Terminal embebido
" =======================================================
nmap <leader>te :belowright terminal<CR>

" =======================================================
" Wrap toggle
" =======================================================
noremap <silent> <Leader>w :call ToggleWrap()<CR>
function! ToggleWrap()
    if &wrap
        echo "Wrap OFF"
        setlocal nowrap nolist
        set virtualedit=all
    else
        echo "Wrap ON"
        setlocal wrap linebreak nolist
        set virtualedit=
    endif
endfunction

" =======================================================
" Mouse toggle
" =======================================================
let g:is_mouse_enabled = 1
noremap <silent> <Leader>m :call ToggleMouse()<CR>
function! ToggleMouse()
    if g:is_mouse_enabled
        echo "Mouse OFF"
        set mouse=
        let g:is_mouse_enabled = 0
    else
        echo "Mouse ON"
        set mouse=a
        let g:is_mouse_enabled = 1
    endif
endfunction

" =======================================================
" Markdown & Vimwiki
" =======================================================
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal = 2
let g:vim_markdown_conceal_code_blocks = 1
let g:vim_markdown_new_list_item_indent = 2
let g:vim_markdown_strikethrough = 1
autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft', 'autoformat': 0})
autocmd FileType markdown setlocal linebreak
autocmd FileType markdown nnoremap <leader>a :Tabularize /\|<CR>
nmap <leader>mp :MarkdownPreview<CR>

let g:vimwiki_list = [{'path': s:vim_dir.'/VimWiki','syntax':'markdown','ext':'.md'}]
let g:instant_markdown_autostart = 0
let $PATH = $PATH . ':' . expand('$HOME/.npm-global/bin')

