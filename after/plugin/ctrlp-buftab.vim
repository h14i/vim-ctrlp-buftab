" after/plugin/ctrlp-buftab.vim
if exists('g:loaded_ctrlp_buftab_after') && g:loaded_ctrlp_buftab_after | finish | endif
let g:loaded_ctrlp_buftab_after = 1
if exists(':CtrlP')
  command! -nargs=0 CtrlPBufTab call ctrlp#init(ctrlp#buftab#id())
endif
