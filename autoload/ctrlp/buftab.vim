" autoload/ctrlp/buftab.vim
"
" name   : ctrlp-buftab.vim
" license: public domain
"
scriptencoding utf-8

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

" Public API

if !exists('s:id')
  let s:id = get(g:, 'ctrlp_builtins') + len(g:ctrlp_ext_vars)
endif

function! ctrlp#buftab#id() abort "{{{
  return s:id
endfunction "}}}

function! ctrlp#buftab#init() abort "{{{
  if !exists('t:ctrlp_buftab_bufnrs') || empty(t:ctrlp_buftab_bufnrs)
    return []
  endif

  let bufnr_list = s:bufnr_list(t:ctrlp_buftab_bufnrs)

  " let bufnr_list = s:remove_special_buffer(bufnr_list)

  let bufname_list = s:to_bufname(bufnr_list)

  if !get(g:, 'ctrlp_show_hidden', 0)
    let bufname_list = s:remove_hidden(bufname_list)
  endif

  " let bufname_list = s:remove_ignored_name(bufname_list)
  " let bufname_list = s:remove_empty(bufname_list)

  return bufname_list
endfunction "}}}

" finish

function! ctrlp#buftab#accept(mode, str) abort "{{{
  call ctrlp#exit()
  exec 'buffer' fnameescape(a:str)
endfunction "}}}

" Private functions

function! s:bufnr_list(dict) abort "{{{
  return map(keys(a:dict), 'str2nr(v:val)')
endfunction "}}}

function! s:to_bufname(bufnr_list) abort "{{{
  return map(a:bufnr_list, 'bufname(v:val)')
endfunction "}}}

function! s:remove_special_buffer(buflist) abort "{{{
  return filter(a:buflist, 'getbufvar(v:val, ''&buftype'') ==# ''''')
endfunction "}}}

function! s:remove_hidden(buflist) abort "{{{
  let pat = '^\.\|\/\.'
  return filter(a:buflist, 'match(v:val, pat) < 0')
endfunction "}}}

function! s:remove_ignored_name(bufname_list) abort "{{{
  let list = a:bufname_list
  if exists('g:ctrlp#buftab#ignore_pattern') && g:ctrlp#buftab#ignore_pattern !=# ''
    let list = filter(list, 'match(v:val, g:ctrlp#buftab#ignore_pattern) < 0')
  endif
  return list
endfunction "}}}

function! s:remove_empty(bufname_list) abort "{{{
  return filter(a:bufname_list, 'v:val !=# ''''')
endfunction "}}}

" vim: set sts=2 sw=2 et fdm=marker:
