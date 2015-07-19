" plugin/ctrlp-buftab.vim
if exists('g:loaded_ctrlp_buftab_plugin') && g:loaded_ctrlp_buftab_plugin
  finish
endif
let g:loaded_ctrlp_buftab_plugin = 1

command! -nargs=0 CtrlPBufTab call ctrlp#init(ctrlp#buftab#id())
" vim: set sts=2 sw=2 et fdm=marker:
