if !has('nvim-0.7')
    echoerr "Neovim version 0.7 or above is required!"
    finish
endif

if exists('g:loaded_vimberman')
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

command! Vimberman lua require("vimberman").main()

let &cpo = s:save_cpo
unlet s:save_cpo

let g:loaded_vimberman = 1