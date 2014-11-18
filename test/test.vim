" test/test.vim

let s:suite = themis#suite('Test for ctrlp-buftab.vim :')

function! s:suite.check_runtimepath() "{{{
  Assert Compare(stridx(&rtp, "ctrlp.vim"), '>', -1)
  Assert Compare(stridx(&rtp, "tabpagebuffer.vim"), '>', -1)
  Assert Compare(stridx(&rtp, "vim-scall"), '>', -1)
  Assert Compare(stridx(&rtp, "vim-ctrlp-buftab"), '>', -1)
endfunction "}}}

" ctrlp#buftab#id()
function! s:suite.id_return_positive_number() "{{{
  Assert Compare(ctrlp#buftab#id(), '>', 0)
endfunction "}}}

" ctrlp#buftab#init()
function! s:suite.return_empty_array_if_tabpagebuffer_not_loaded() "{{{
  Assert Equals(ctrlp#buftab#init(), [])
endfunction "}}}

function! s:setup_list() "{{{
  return [
  \   '/home/h14i/path/to/file',
  \   '/home/h14i/.vim/vimrc',
  \   '.git/index',
  \   'vim-ctrlp-buftab/test/.themisrc',
  \   'vim-ctrlp-buftab/test/test.vim',
  \ ]
endfunction "}}}

function! s:suite.remove_ignored_bufname_when_not_show_hidden() "{{{
  let list = s:setup_list()
  let g:ctrlp_show_hidden = 0

  Assert Equals(
  \   scall#call('autoload/ctrlp/buftab.vim:remove_ignored_bufname', list),
  \   ['/home/h14i/path/to/file', 'vim-ctrlp-buftab/test/test.vim'])
endfunction "}}}

function! s:suite.remove_ignored_bufname_when_show_hidden() "{{{
  let list = s:setup_list()
  let nlist = len(list)
  let g:ctrlp_show_hidden = 1

  Assert Equals(
  \   len(scall#call('autoload/ctrlp/buftab.vim:remove_ignored_bufname', list)),
  \   nlist)
endfunction "}}}

function! s:suite.remove_ignored_bufname_with_buftab_ignore_pattern() "{{{
  let list = s:setup_list()
  let g:ctrlp_show_hidden = 0
  let g:ctrlp#buftab#ignore_pattern = 'home'

  Assert Equals(
  \   scall#call('autoload/ctrlp/buftab.vim:remove_ignored_bufname', list),
  \   ['vim-ctrlp-buftab/test/test.vim'])
endfunction "}}}

function! s:suite.remove_empty_bufname() "{{{
  let list = ['aaa', '', 'bbb', 'ccc']

  Assert Equals(
  \   scall#call('autoload/ctrlp/buftab.vim:remove_empty_bufname', list),
  \   ['aaa', 'bbb', 'ccc'])
endfunction "}}}

" vim: set fdm=marker sts=2 sw=2 et:
