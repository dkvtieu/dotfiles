if ! filereadable(system('echo -n "$HOME/.config/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p $HOME/.config/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > $HOME/.config/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('$HOME/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'bkad/camelcasemotion'
Plug 'scrooloose/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'gruvbox-community/gruvbox'
call plug#end()

" Turn on default syntax highlighting if available
    syntax on

" Color schemes
    colorscheme gruvbox
    set bg=light

" Do not retain swap files or backups. Instead retain undo history
    set noswapfile
    set nobackup
    set undofile
    set undodir=$HOME/.vim/undodir

" Set encoding for rendering unicode characters
    set encoding=utf-8

" Mapping leader character to the spacebar
    let mapleader = " "

" Setting both 'number' and 'relativenumber' enables hybrid line numbers
    set number relativenumber

" Turning on ruler for cursor position
    set ruler

" Perform case-sensitive search if capital letters are included in pattern
    set ignorecase smartcase

" Use spaces for indentation (4 spaces for an indentation in normal & insert)
    set expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Shortcut to rapidly toggle `set list`
    nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
    set listchars=tab:▸\ ,eol:¬

" Invisible character colors
    highlight NonText guifg=#4a4a59
    highlight SpecialKey guifg=#4a4a59

" Reload or edit neovim config
    nnoremap <leader>vr :source $HOME/.config/nvim/init.vim<cr>
    nnoremap <leader>ve :e $HOME/.config/nvim/init.vim<cr>

" Clear highlighting
    nnoremap <leader><space> :noh<cr>

" Highlight all matching words and change
    nnoremap cn *``cgn
    nnoremap cN *``cgN

" Set cursor offset
    set scrolloff=8

" Give more height for command area
    set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
    set updatetime=0

" Line character rulers. Soft limit and hard limit
    set colorcolumn=80,120
    highlight ColorColumn ctermbg=grey guibg=grey

" Hide files in buffer when quitting
    set hidden

" Turn off autowrap of overflowing lines
    set nowrap

" Turn on true colors for iterm2 + neovim + gruvbox
    set termguicolors

" Highlight matches as search is being made
    set incsearch

" UndoTree
    nnoremap <leader>u :UndotreeShow<cr>

" Vertical window resizing
    nnoremap <Leader>+ :vertical resize +5<CR>
    nnoremap <Leader>- :vertical resize -5<CR>

" FZF search (project find)
    nnoremap <leader>pF :Files<CR>
    nnoremap <leader>pf :GFiles<CR>

" Move lines in visual mode
    vnoremap J :m '>+1<CR>gv=gv
    vnoremap K :m '<-2<CR>gv=gv

" GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

" Use `[g` and `]g` to navigate diagnostics
    nmap <silent> g[ <Plug>(coc-diagnostic-prev)
    nmap <silent> g] <Plug>(coc-diagnostic-next)

" Use tab for trigger completion with characters ahead and navigate.
    function! s:check_back_space() abort
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    inoremap <silent><expr> <tab>
                \ pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ coc#refresh()
    inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" CoC suggestion completion with <CR>
    if exists('*complete_info')
      inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
    else
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
    endif

" Execute macro over visual selection block
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

    function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction

" Prettier config
    command! -nargs=0 Prettier :CocCommand prettier.formatFile

" Use K to show documentation in preview window
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      else
        call CocAction('doHover')
      endif
    endfunction

" Auto trim trailing whitespace
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun

    autocmd BufWritePre * :call TrimWhitespace()

" Disable timeout for leader input, to give more time to enter command
    set notimeout

" camelcasemotion
    let g:camelcasemotion_key = '<leader>'

" NERDTree
    nmap <leader>pe :NERDTreeToggle<CR>
    let g:NERDTreeIgnore = ['^node_modules$']

    " sync open file with NERDTree
    " Check if NERDTree is open or active
    function! IsNERDTreeOpen()
      return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
    endfunction

    " Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
    " file, and we're not in vimdiff
    function! SyncTree()
      if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
        NERDTreeFind
        wincmd p
      endif
    endfunction

    " Highlight currently open buffer in NERDTree
    autocmd BufEnter * call SyncTree()
