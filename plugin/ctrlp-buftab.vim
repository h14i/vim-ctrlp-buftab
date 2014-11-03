" plugin/ctrlp-buftab.vim
scriptencoding utf-8
let s:cpo = &cpo
set cpo&vim

if exists('g:loaded_ctrlp_buftab') && g:loaded_ctrlp_buftab
  finish
endif
let g:loaded_ctrlp_buftab = 1

command! -nargs=0 CtrlPBufTab call ctrlp#init(ctrlp#buftab#id())

" alias
" command! -nargs=0 CtrlPBufferTab CtrlPBufTab

let &cpo = s:cpo
unlet s:cpo
" vim: set sts=2 sw=2 et fdm=marker:
