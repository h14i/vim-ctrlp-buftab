" plugin/ctrlp-buftab.vim
" setup "{{{
if exists('g:loaded_ctrlp_buftab') && g:loaded_ctrlp_buftab
  finish
endif
let g:loaded_ctrlp_buftab = 1

scriptencoding utf-8
let s:cpo = &cpo
set cpo&vim
"}}}

augroup plugin-ctrlp-buftab
  autocmd!
  autocmd BufEnter
  \ * if !exists('b:ctrlp_buftab_tabnr')
  \ |   let b:ctrlp_buftab_tabnr = tabpagenr()
  \ | endif
augroup END

command! -nargs=0 CtrlPBufTab call ctrlp#init(ctrlp#buftab#id())

" teardown "{{{
let &cpo = s:cpo
unlet s:cpo
"}}}
" vim: set fdm=marker sts=2 sw=2 et:
