" autoload/ctrlp/buftab.vim
scriptencoding utf-8

if exists('g:loaded_ctrlp_buftab') && g:loaded_ctrlp_buftab
  finish
endif
let g:loaded_ctrlp_buftab = 1

" init

let s:buftab = {
\   'init'  : 'ctrlp#buftab#init()',
\   'accept': 'ctrlp#buftab#accept',
\   'lname' : 'buftab',
\   'sname' : 'btab',
\   'type'  : 'line',
\   'sort'  : 0,
\ }

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
  let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:buftab)
else
  let g:ctrlp_ext_vars = [s:buftab]
endif

function! s:errormsg(msg) abort "{{{
  echohl WarningMsg | echomsg a:msg | echohl None
endfunction "}}}

if !exists('s:id')
  let s:id = get(g:, 'ctrlp_builtins') + len(g:ctrlp_ext_vars)
endif

function! ctrlp#buftab#id() abort "{{{
  return s:id
endfunction "}}}

" core

function! s:remove_special_buffer(buflist) abort "{{{
  return filter(a:buflist, 'getbufvar(v:val, "&buftype") == ""')
endfunction "}}}

function! s:to_bufname_list(bufnr_list) abort "{{{
  return map(a:bufnr_list, "bufname(v:val)")
endfunction "}}}

function! s:remove_ignored_bufname(bufname_list) abort "{{{
  let list = a:bufname_list
  if !exists('g:ctrlp_show_hidden') || g:ctrlp_show_hidden == 0
    let dot_pattern = '^\.\|\/\.'
    let list = filter(list, "match(v:val, dot_pattern) < 0")
  endif
  if exists('g:ctrlp#buftab#ignore_pattern') && g:ctrlp#buftab#ignore_pattern != ""
    let list = filter(list, "match(v:val, g:ctrlp#buftab#ignore_pattern) < 0")
  endif
  return list
endfunction "}}}

function! s:remove_empty_bufname(bufname_list) abort "{{{
  return filter(a:bufname_list, 'v:val != ""')
endfunction "}}}

function! ctrlp#buftab#collect_all_buffers() abort "{{{
  let buflist = []
  let i = 1
  let last_buffer = bufnr('$')
  while i <= last_buffer
    if buflisted(i)
      call add(buflist, i)
    endif
    let i += 1
  endwhile
  return buflist
endfunction "}}}

function! ctrlp#buftab#filter_tabpagenr(tabpagenr) abort "{{{
  let tab_buflist = []
  for bufnr in ctrlp#buftab#collect_all_buffers()
    if a:tabpagenr == getbufvar(bufnr, 'ctrlp_buftab_tabnr')
      call add(tab_buflist, bufnr)
    endif
  endfor
  return tab_buflist
endfunction "}}}

function! ctrlp#buftab#init() abort "{{{
  let bufnr_list = ctrlp#buftab#filter_tabpagenr(tabpagenr())

  " let bufnr_list = s:remove_special_buffer(bufnr_list)

  let bufname_list = s:to_bufname_list(bufnr_list)

  " let bufname_list = s:remove_ignored_bufname(bufname_list)
  " let bufname_list = s:remove_empty_bufname(bufname_list)

  return bufname_list
endfunction "}}}

" finish

function! ctrlp#buftab#accept(mode, str) abort "{{{
  call ctrlp#exit()
  exec 'buffer' fnameescape(a:str)
endfunction "}}}

" vim: set sts=2 sw=2 et fdm=marker:
