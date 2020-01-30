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
