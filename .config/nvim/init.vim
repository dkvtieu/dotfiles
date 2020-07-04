" Install vim-plug if not already installed
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    echo "Downloading junegunn/vim-plug to manage plugins..."
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

call plug#begin('$HOME/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'tpope/vim-fugitive'
Plug 'mbbill/undotree'
Plug 'tpope/vim-surround'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'junegunn/goyo.vim'
Plug 'tpope/vim-commentary'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'bkad/camelcasemotion'
Plug 'wellle/targets.vim'
Plug 'airblade/vim-gitgutter'
Plug 'mhinz/vim-grepper'
Plug 'liuchengxu/vista.vim'
Plug 'herringtondarkholme/yats.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'joaohkfaria/vim-jest-snippets'
call plug#end()

" Mapping leader character to the spacebar
    let mapleader = " "

" Color schemes
    colorscheme dracula

" Do not show vim mode, instead rely on vim-airline
    set noshowmode

" Allow mouse interaction with vim while in a tmux session
    set mouse=a

" Turn on default syntax highlighting if available
    set encoding=UTF-8
    syntax on


" Do not retain swap files or backups. Instead retain undo history
    set noswapfile
    set nobackup
    set undofile
    set undodir=$HOME/.vim/undodir

" Set encoding for rendering unicode characters
    set encoding=utf-8

" Setting both 'number' and 'relativenumber' enables hybrid line numbers
    set number relativenumber

" Turning on ruler for cursor position
    set ruler

" Perform case-sensitive search if capital letters are included in pattern
    set ignorecase smartcase

" Use spaces for indentation (4 spaces for an indentation in normal & insert)
    set expandtab tabstop=4 shiftwidth=4 softtabstop=4

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

" Disable timeout for leader input, to give more time to enter command
    set notimeout

" Enable global replacement (i.e. no need to do /g with every :substitute)
" WARNING: This may break some plugins
    set gdefault

" Substitute preview
    set inccommand=nosplit

" Show tabline
    set showtabline=2

" Reload or edit neovim config
    nnoremap <leader>vr :source $HOME/.config/nvim/init.vim<cr>
    nnoremap <leader>ve :e $HOME/.config/nvim/init.vim<cr>

" Clear highlighting
    nnoremap <leader><space> :noh<cr>

" Highlight all matching words and change
    nnoremap cn *``cgn
    nnoremap cN *``cgN

" UndoTree
    nnoremap <leader>u :UndotreeShow<cr>

" Window resizing
    nnoremap <Leader>= :vertical resize +5<CR>
    nnoremap <Leader>- :vertical resize -5<CR>
    nnoremap <Leader>+ :resize +5<CR>
    nnoremap <Leader>_ :resize -5<CR>

" FZF search (project find)
    nnoremap <leader>pP :Files<CR>
    nnoremap <leader>pp :GFiles<CR>

" coc
let g:coc_global_extensions = [
            \ 'coc-pairs',
            \ 'coc-tsserver',
            \ 'coc-prettier',
            \ 'coc-json',
            \ 'coc-eslint',
            \ 'coc-explorer',
            \ 'coc-snippets',
            \ ]

" GoTo code navigation.
    nmap <silent> gd <Plug>(coc-definition)
    nmap <silent> gy <Plug>(coc-type-definition)
    nmap <silent> gi <Plug>(coc-implementation)
    nmap <silent> gr <Plug>(coc-references)

" To navigate coc-diagnostics
    nmap <silent> [g <Plug>(coc-diagnostic-prev)
    nmap <silent> ]g <Plug>(coc-diagnostic-next)

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

" Execute macro over visual selection block
    xnoremap @ :<C-u>call ExecuteMacroOverVisualRange()<CR>

    function! ExecuteMacroOverVisualRange()
      echo "@".getcmdline()
      execute ":'<,'>normal @".nr2char(getchar())
    endfunction


" Auto trim trailing whitespace
    fun! TrimWhitespace()
        let l:save = winsaveview()
        keeppatterns %s/\s\+$//e
        call winrestview(l:save)
    endfun

    autocmd BufWritePre * :call TrimWhitespace()


" camelcasemotion
    let g:camelcasemotion_key = '<leader>'

" coc-explorer
    nmap <space>pe :CocCommand explorer<CR>

" Faster buffer selection / switching
    nnoremap <Leader><Tab> :bn<CR>
    nnoremap <Leader><S-Tab> :bp<CR>

" Improve scroll performance on some file types
    augroup syntaxSyncMinLines
        autocmd!
        autocmd Syntax * syntax sync minlines=2000
    augroup END

" Vimdiff mappings
    nmap <leader>gf :diffget //2<CR>
    nmap <leader>gj :diffget //3<CR>

" Auto delete vim-fugitive buffers when quitting
    autocmd BufReadPost fugitive://* set bufhidden=delete


" GitGutter mappings
    nmap <silent> gh <Plug>(GitGutterPreviewHunk)
    nmap <silent> g+ <Plug>(GitGutterStageHunk)
    nmap <silent> g- <Plug>(GitGutterUndoHunk)

" vim-airline
    " let g:airline_symbols_ascii = 1
    " let g:airline#extensions#tabline#enabled = 1
    " let g:airline#extensions#tabline#formatter = 'unique_tail'

" vim-lightline
    let g:lightline = {
            \ 'colorscheme': 'dracula',
            \ 'active': {
            \   'left': [ ['mode', 'paste'], ['gitbranch', 'readonly', 'relativepath', 'modified'] ],
            \   'right': [ ['lineinfo', 'filetype'], ['cocstatus'] ]
            \ },
            \ 'inactive': {
            \   'left': [ ['relativepath'] ],
            \   'right': []
            \ },
            \ 'component_function': {
            \   'cocstatus': 'coc#status',
            \   'gitbranch': 'FugitiveHead'
            \ },
            \ 'tabline': {
            \   'left': [ ['buffers'] ],
            \   'right': [ [] ]
            \ },
            \ 'component_expand': {
            \   'buffers': 'lightline#bufferline#buffers'
            \ },
            \ 'component_type': {
            \   'buffers': 'tabsel'
            \ }
            \ }

    let g:lightline#bufferline#filename_modifier = ':t'


" Use auocmd to force lightline update on coc update.
    autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" vim-grepper
    let g:grepper = {}
    let g:grepper.tools = ["rg"]
    runtime autoload/grepper.vim
    let g:grepper.jump = 1
    nnoremap <Leader>pf :Rg<CR>
    nnoremap <Leader>ps :Grepper -cword -noprompt<CR>
    xmap <Leader>ps <Plug>(GrepperOperator)

" Global find and replace
    nnoremap <Leader>r
      \ :let @s='\<'.expand('<cword>').'\>'<CR>
      \ :Grepper -cword -noprompt<CR>
      \ <Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
      \ :cfdo %s/<C-r>s// \| update
    xmap <Leader>r
      \ "sy \|
      \ :GrepperRg <C-r>s<CR>
      \ <Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
      \ :cfdo %s/<C-r>s// \| update


" Vista (tagbar replacement)
    nmap <leader>l :Vista finder<CR>
    nmap <leader>L :Vista!!<CR>
    let g:vista_default_executive = 'coc'

