" plugin/ctrlp-buftab.vim
if exists('g:loaded_ctrlp_buftab_plugin') && g:loaded_ctrlp_buftab_plugin
  finish
endif
let g:loaded_ctrlp_buftab_plugin = 1

augroup ctrlp-buftab
  autocmd!
  autocmd BufEnter
  \ * if !exists('b:ctrlp_buftab_tabnr')
  \ |   let b:ctrlp_buftab_tabnr = tabpagenr()
  \ | endif
augroup END

command! -nargs=0 CtrlPBufTab call ctrlp#init(ctrlp#buftab#id())
" vim: set sts=2 sw=2 et fdm=marker:
