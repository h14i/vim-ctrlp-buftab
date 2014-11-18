" plugin/ctrlp-buftab.vim
if exists('g:loaded_ctrlp_buftab') && g:loaded_ctrlp_buftab
  finish
endif
let g:loaded_ctrlp_buftab = 1

let s:cpo = &cpo
set cpo&vim

command! -nargs=0 CtrlPBufTab call ctrlp#init(ctrlp#buftab#id())

let &cpo = s:cpo
unlet s:cpo
" vim: set sts=2 sw=2 et fdm=marker:
