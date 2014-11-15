" autoload/ctrlp/buftab.vim
scriptencoding utf-8
let s:cpo = &cpo
set cpo&vim

" init

let s:buftab = {
\   'init'  : 'ctrlp#buftab#init()',
\   'accept': 'ctrlp#buftab#accept',
\   'lname' : 'buftab',
\   'sname' : 'btab',
\   'type'  : 'line',
\   'sort'  : 0,
\ }

let g:ctrlp_ext_vars = get(g:, 'ctrlp_ext_vars', [])
if index(g:ctrlp_ext_vars, s:buftab) < 0
  call add(g:ctrlp_ext_vars, s:buftab)
endif

unlet s:buftab

function! s:errormsg(msg) "{{{
  echohl WarningMsg | echomsg a:msg | echohl None
endfunction "}}}

if !exists('s:id')
  let s:id = get(g:, 'ctrlp_builtins') + len(g:ctrlp_ext_vars)
endif

function! ctrlp#buftab#id() "{{{
  return s:id
endfunction "}}}

" core

function! s:get_buffers() "{{{
  return map(keys(copy(t:tabpagebuffer)), "str2nr(v:val)")
endfunction "}}}

function! s:remove_special_buffer(buflist) "{{{
  return filter(a:buflist, 'getbufvar(v:val, "&buftype") == ""')
endfunction "}}}

function! s:to_bufname_list(bufnr_list) "{{{
  return map(a:bufnr_list, "bufname(v:val)")
endfunction "}}}

let s:dot_pattern = '^\.\|\/\.'

function! s:remove_ignored_bufname(buflist) "{{{
  let buflist = a:buflist
  if !exists('g:ctrlp_show_hidden') || g:ctrlp_show_hidden == 0
    let buflist = filter(buflist, "match(v:val, s:dot_pattern) < 0")
  endif
  if exists('g:ctrlp#buftab#ignore_pattern') && g:ctrlp#buftab#ignore_pattern
    let buflist = filter(buflist, "g:ctrlp#buftab#ignore_pattern !~# v:val")
  endif
  return buflist
endfunction "}}}

function! ctrlp#buftab#init() "{{{
  if !exists('g:loaded_tabpagebuffer')
    call s:errormsg('Not installed tabpagebuffer.vim')
    return []
  endif
  if !exists('t:tabpagebuffer')
    return []
  endif

  let bufnr_list = s:get_buffers()

  let bufnr_list = s:remove_special_buffer(bufnr_list)

  let bufname_list = s:to_bufname_list(bufnr_list)

  let bufname_list = s:remove_ignored_bufname(bufname_list)

  return bufname_list
endfunction "}}}

" finish

function! ctrlp#buftab#accept(mode, str) "{{{
  call ctrlp#exit()
  exec 'buffer' fnameescape(a:str)
endfunction "}}}

let &cpo = s:cpo
unlet s:cpo
" vim: set sts=2 sw=2 et fdm=marker:
