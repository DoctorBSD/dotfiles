" Basic
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set shell=/usr/bin/bash

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Tabs / Indent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
set autoindent
set smartindent

" UI
let &t_ut=''
set t_RV=
set ttymouse=sgr
set mouse=a
set number
set relativenumber
set wildmode=longest,list
set ttyfast
set background=dark
set termguicolors
set laststatus=2
set clipboard=unnamed,unnamedplus
set hidden
set completeopt=menuone,noinsert,noselect

filetype plugin indent on
syntax enable

call plug#begin()
Plug 'morhetz/gruvbox'
Plug 'joshdick/onedark.vim'
Plug 'xolox/vim-colorscheme-switcher'
Plug 'xolox/vim-misc'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'sheerun/vim-polyglot'
Plug 'alvan/vim-closetag'
Plug 'dense-analysis/ale'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'elkasztano/nushell-syntax-vim'
Plug 'imsnif/kdl.vim'
Plug 'wakatime/vim-wakatime'
Plug 'yukimura1227/vim-yazi'
Plug 'nathanaelkane/vim-indent-guides'
call plug#end()

colorscheme onedark

let g:colorscheme_switcher_exclude_builtins=1
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_italic = 1
let g:gruvbox_bold = 1
let g:gruvbox_underline = 1
let g:gruvbox_strikethrough = 1
let g:onedark_enable_italics = 1

let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-sumneko-lua', 'coc-clangd', 'coc-java', 'coc-rust-analyzer', 'coc-zig', 'coc-markdownlint']

inoremap <silent><expr> <cr> coc#pum#visible() && coc#pum#info()['index'] != -1 ? coc#pum#confirm() : "\<C-g>u\<CR>"

" Use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()

let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#linecolumn#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline_statusline_ontop = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'default'
let g:airline_powerline_fonts = 1
let g:airline_theme = 'wombat'

let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'
let g:closetag_filetypes = 'html,xhtml,phtml,xml,javascript.jsx,typescript.tsx'

" ALE Configuration
let g:ale_disable_lsp = 1
let g:ale_set_highlights = 1
let g:ale_echo_msg_error_str = 'Error'
let g:ale_echo_msg_warning_str = 'Warning'
let g:ale_floating_window_border = ['│', '─', '╭', '╮', '╯', '╰', '│', '─']

" Линтеры
let g:ale_linters = {
\   'lua': ['luacheck'],
\   'python': ['pylint'],
\   'c': ['clang-tidy', 'cppcheck'],
\   'cpp': ['clang-tidy', 'cppcheck'],
\   'java': ['javac', 'checkstyle'],
\   'zig': ['zls'],
\   'rust': ['rust-analyzer']
\}

" Фиксеры
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'lua': ['stylua'],
\   'python': ['black'],
\   'c': ['clang-format'],
\   'cpp': ['clang-format'],
\   'java': ['google_java_format'],
\   'zig': ['zigfmt'],
\   'rust': ['rustfmt']
\}

" Автоформатирование при сохранении
let g:ale_fix_on_save = 1

" Символы ошибок/предупреждений
let g:ale_set_signs = 1
let g:ale_sign_error = '⚠'
let g:ale_sign_warning = '!'

let g:ale_zig_zls_executable = '/usr/bin/zls'

nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-f> :Rg<CR>
nnoremap <silent> <C-b> :Buffers<CR>
nnoremap <silent> <C-h> :Helptags<CR>

let g:rustfmt_autosave = 1

" Path to yazi executable (default: 'yazi')
let g:yazi_executable = 'yazi'

" Enable opening multiple files (default: 1)
let g:yazi_open_multiple = 0

" Replace netrw with yazi (default: 0)
let g:yazi_replace_netrw = 1

" Disable default key mappings (default: 0)
let g:yazi_no_mappings = 1

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 1
"autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#2a2a2a
"autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#303030
