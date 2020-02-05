" Set encoding for rendering unicode characters
    :set encoding=utf-8
" Mapping leader character to the spacebar
    let mapleader = " "

" Setting both 'number' and 'relativenumber' enables hybrid line numbers
    :set number relativenumber

" Switch between line number modes automatically.
    :augroup numbertoggle
    :  autocmd!
    :  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
    :  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
    :augroup END

" Perform case-sensitive search if capital letters are included in pattern
    :set ignorecase smartcase

" Use spaces for indentation (4 spaces for an indentation in normal & insert modes)
    :set expandtab tabstop=4 shiftwidth=4 softtabstop=4

" Shortcut to rapidly toggle `set list`
    nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
    :set listchars=tab:▸\ ,eol:¬

"Invisible character colors
    highlight NonText guifg=#4a4a59
    highlight SpecialKey guifg=#4a4a59
