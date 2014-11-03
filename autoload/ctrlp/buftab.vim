" autoload/ctrlp/buftab.vim
scriptencoding utf-8
let s:cpo = &cpo
set cpo&vim

let s:ignore_pattern =
\ get(g:, 'ctrlp_buftab_ignore_pattern', '\/\.\(git\|hg\|svn\|bzr\)')

let s:ignore_buftype =
\ get(g:, 'ctrlp_buftab_ignore_buftype', 'explorer\|help\|quickfix')

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

function! ctrlp#buftab#init() "{{{
  if !exists('g:loaded_tabpagebuffer')
    call s:errormsg('Not installed tabpagebuffer.vim')
    return []
  endif
  if !exists('t:tabpagebuffer')
    return []
  endif

  let bufnr_list = map(keys(copy(t:tabpagebuffer)), "str2nr(v:val)")
  " スペシャルなバッファは除外する
  let bufnr_list = filter(bufnr_list, 'getbufvar(v:val, "&buftype") == ""')

  let bufname_list = map(bufnr_list, "bufname(v:val)")
  " 特定の名前のバッファを除外する
  let bufname_list = filter(bufname_list, "s:ignore_pattern !~# v:val")

  return bufname_list
endfunction "}}}


function! ctrlp#buftab#accept(mode, str) "{{{
  call ctrlp#exit()
  " TODO: jump to target buffer
  exec 'buffer' fnameescape(a:str)
endfunction "}}}

let &cpo = s:cpo
unlet s:cpo
" vim: set sts=2 sw=2 et fdm=marker:
