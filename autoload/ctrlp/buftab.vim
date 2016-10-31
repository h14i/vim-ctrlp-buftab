" autoload/ctrlp/buftab.vim
"
" name   : ctrlp-buftab.vim
" license: public domain
"
scriptencoding utf-8

function! s:errormsg(msg) abort "{{{
  echohl WarningMsg | echomsg a:msg | echohl None
endfunction "}}}

" Initialization
let g:ctrlp_ext_vars = get(g:, 'ctrlp_ext_vars', []) + [{
\   'init'  : 'ctrlp#buftab#init()',
\   'accept': 'ctrlp#buftab#accept',
\   'lname' : 'buftab',
\   'sname' : 'btab',
\   'type'  : 'line',
\   'sort'  : 0,
\ }]

" Public API

let s:id = ctrlp#getvar('g:ctrlp_builtins') + len(g:ctrlp_ext_vars)

function! ctrlp#buftab#id() abort "{{{
  return s:id
endfunction "}}}

function! ctrlp#buftab#init() abort "{{{
  if !exists('t:ctrlp_buftab_bufnrs') || empty(t:ctrlp_buftab_bufnrs)
    return []
  endif

  let bufnrs = s:to_list(t:ctrlp_buftab_bufnrs)
  " let bufnrs = s:remove_special_buffer(bufnrs)

  let bufnames = map(bufnrs, 'bufname(v:val)')
  if !get(g:, 'ctrlp_show_hidden', 0)
    let bufnames = s:remove_hidden(bufnames)
  endif
  " let bufnames = s:remove_ignored_name(bufnames)
  " let bufnames = s:remove_empty(bufnames)

  return bufnames
endfunction "}}}

" finish

function! ctrlp#buftab#accept(mode, str) abort "{{{
  call ctrlp#exit()
  execute 'buffer' fnameescape(a:str)
endfunction "}}}

" Private functions

function! s:to_list(dict) abort "{{{
  return map(keys(a:dict), 'str2nr(v:val)')
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
