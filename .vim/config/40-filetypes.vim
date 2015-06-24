augroup filetypes
    autocmd!
    autocmd BufRead,BufNewFile .jshintrc set filetype=javascript
    autocmd BufRead,BufNewFile *.nasm set filetype=nasm
    autocmd BufRead,BufNewFile *.tc set filetype=c
    autocmd BufRead,BufNewFile *.webapp set filetype=json
    autocmd BufRead,BufNewFile Podfile set filetype=ruby
augroup END
