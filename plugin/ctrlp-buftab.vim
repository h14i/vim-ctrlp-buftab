" plugin/ctrlp-buftab.vim
scriptencoding utf-8
let s:cpo = &cpo
set cpo&vim

if exists('g:loaded_ctrlp_buftab') && g:loaded_ctrlp_buftab
  finish
endif
let g:loaded_ctrlp_buftab = 1

" augroup plugin-ctrlp-buftab
"   autocmd!
"   " FIXME: register timings
"   autocmd BufRead
"   \ * if !exists('t:buftab_buflist_')
"   \ |   let t:buftab_buflist_ = []
"   \ | endif
"   \ | if !&previewwindow && empty(&buftype) && index(t:buftab_buflist_, expand('<abuf>')) < 0
"   \ |   call add(t:buftab_buflist_, expand('<abuf>'))
"   \ | endif
" augroup END

command! -nargs=0 CtrlPBufTab call ctrlp#init(ctrlp#buftab#id())

" alias
" command! -nargs=0 CtrlPBufferTab CtrlPBufTab

let &cpo = s:cpo
unlet s:cpo
" vim:ft=vim:sts=2:sw=2:et:
