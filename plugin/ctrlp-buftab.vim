" plugin/ctrlp-buftab.vim
"
" name   : ctrlp-buftab.vim
" license: public domain
"
" setup "{{{
if exists('g:loaded_ctrlp_buftab') && g:loaded_ctrlp_buftab
  finish
endif
let g:loaded_ctrlp_buftab = 1

scriptencoding utf-8
let s:cpo = &cpo
set cpo&vim
"}}}

" Add bufnr to t:ctrlp_buftab_bufnrs
function! s:add(bufnr) abort "{{{
  if !exists('t:ctrlp_buftab_bufnrs')
    let t:ctrlp_buftab_bufnrs = {}
  endif
  if !has_key(t:ctrlp_buftab_bufnrs, a:bufnr)
    let t:ctrlp_buftab_bufnrs[a:bufnr] = a:bufnr
  endif
endfunction "}}}

" Remove bufnr from t:ctrlp_buftab_bufnrs
function! s:remove(bufnr) abort "{{{
  if !exists('t:ctrlp_buftab_bufnrs')
    let t:ctrlp_buftab_bufnrs = {}
  endif
  if has_key(t:ctrlp_buftab_bufnrs, a:bufnr)
    call remove(t:ctrlp_buftab_bufnrs, a:bufnr)
  endif
endfunction "}}}

augroup plugin-ctrlp-buftab
  autocmd!
  autocmd BufNewFile,BufRead * call s:add(expand('<abuf>'))
  autocmd BufDelete,BufUnload * call s:remove(expand('<abuf>'))
augroup END

command! -nargs=0 CtrlPBufTab call ctrlp#init(ctrlp#buftab#id())

" teardown "{{{
let &cpo = s:cpo
unlet s:cpo
"}}}
" vim: set fdm=marker sts=2 sw=2 et:
