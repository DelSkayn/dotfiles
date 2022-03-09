" Define prefix dictionary
let g:which_key_map = {}
let g:which_key_map['name'] =  'root'

for s:i in range(1, 9)
  let g:which_key_map[s:i] = 'window-'.s:i
endfor
unlet s:i

let g:which_key_map['?'] = [ 'Maps', 'show-keybindings' ]
let g:which_key_map[';'] = [ '<Plug>NERDCommenterToggle','commenter' ]
let g:which_key_map[' '] = {
      \ 'name': '+tab' ,
      \ '1' : 'tab-1'  ,
      \ '2' : 'tab-2'  ,
      \ '3' : 'tab-3'  ,
      \ '4' : 'tab-4'  ,
      \ '5' : 'tab-5'  ,
      \ '6' : 'tab-6'  ,
      \ '7' : 'tab-7'  ,
      \ '8' : 'tab-8'  ,
      \ '9' : 'tab-9'  ,
      \ }

let g:which_key_map['a'] = {
      \ 'name' : '+align',
      \ }

let g:which_key_map['b'] = {
      \ 'name' : '+buffer'       ,
      \ '1' :  'buffer-1'        ,
      \ '2' :  'buffer-2'        ,
      \ '3' :  'buffer-3'        ,
      \ '4' :  'buffer-4'        ,
      \ '5' :  'buffer-5'        ,
      \ '6' :  'buffer-6'        ,
      \ '7' :  'buffer-7'        ,
      \ '8' :  'buffer-8'        ,
      \ '9' :  'buffer-9'        ,
      \ 'd' :  'delete-buffer'   ,
      \ 'f' :  'first-buffer'    ,
      \ 'h' :  'home-buffer'     ,
      \ 'k' :  'kill-buffer'     ,
      \ 'l' :  'last-buffer'     ,
      \ 'n' :  'next-buffer'     ,
      \ 'p' :  'previous-buffer' ,
      \ 'b' :  'fzf-buffer'      ,
      \ '?' :  'fzf-buffer'      ,
      \ }

let g:which_key_map['d'] = 'scroll-down'

let g:which_key_map['e'] = {
      \ 'name' : '+errors'     ,
      \ 'n' : 'next-error'     ,
      \ 'p' : 'previous-error' ,
      \ }

let g:which_key_map['f'] = {
      \ 'name' : '+find/files/fold'             ,
      \ '0' : '0-fold-level'                    ,
      \ '1' : '1-fold-level'                    ,
      \ '2' : '2-fold-level'                    ,
      \ '3' : '3-fold-level'                    ,
      \ '4' : '4-fold-level'                    ,
      \ '5' : '5-fold-level'                    ,
      \ '6' : '6-fold-level'                    ,
      \ '7' : '7-fold-level'                    ,
      \ '8' : '8-fold-level'                    ,
      \ '9' : '9-fold-level'                    ,
      \ 'd' : 'find-current-buffer-in-NERDTree' ,
      \ 'f' : 'files-in-home-direcotry'         ,
      \ 's' : 'save-file'                       ,
      \ 't' : 'toggle-NERDTree'                 ,
      \ '?' : 'files-in-current-direcotry'      ,
      \ 'b' : ['BLines'                         , 'fzf-find-current-buffer'] ,
      \ }

"let g:which_key_map['g'] = {
"      \ 'name' : '+git/version-control' ,
"      \ 'b' : ['Gblame'                 , 'fugitive-blame']             ,
"      \ 'c' : ['BCommits'               , 'commits-for-current-buffer'] ,
"      \ 'C' : ['Gcommit'                , 'fugitive-commit']            ,
"      \ 'd' : ['Gdiff'                  , 'fugitive-diff']              ,
"      \ 'e' : ['Gedit'                  , 'fugitive-edit']              ,
"      \ 'l' : ['Glog'                   , 'fugitive-log']               ,
"      \ 'r' : ['Gread'                  , 'fugitive-read']              ,
"      \ 's' : ['Gstatus'                , 'fugitive-status']            ,
"      \ 'w' : ['Gwrite'                 , 'fugitive-write']             ,
"      \ 'p' : ['Git push'               , 'fugitive-push']              ,
"      \ 'y' : ['Goyo'                   , 'goyo-mode']                  ,
"      \ }

let g:which_key_map['h'] = {
      \ 'name' : '+help',
      \ }

"let g:which_key_map['j'] = {
"      \ 'name' : '+jump/json'                   ,
"      \ 'j' : 'easymotion-goto-char'       ,
"      \ 'J' : 'easymotion-goto-char-2'     ,
"      \ 'l' : 'jump-linewise'              ,
"      \ 'w' : 'jump-to-word-bidirectional' ,
"      \ 'f' : 'jump-forward-wordwise'      ,
"      \ 'b' : 'jump-backword-wordwise'     ,
"      \ 'F' : ['execute line(".")."!python -m json.tool"', 'format-current-raw-oneline-json'],
"      \ }

"let g:which_key_map['l'] = {
"      \ 'name' : '+lsp'                               ,
"      \ 'c' : ['LanguageClient_contextMenu()'         , 'context-menu']     ,
"      \ 'h' : ['LanguageClient#textDocument_hover()'  , 'hover']            ,
"      \ }


let g:which_key_map['q'] = [ 'q', 'quit' ]

let g:which_key_map['Q'] = [ 'qa!', 'quit-without-saving' ]

"let g:which_key_map['s'] = {
"      \ 'name' : '+search/show'                   ,
"      \ 'c' : 'search-clear-highlight'            ,
"      \ 'h' : ['spacevim#util#SyntaxHiGroup()'    , 'show-highlight-group']   ,
"      \ 'b' : ['BLines'                           , 'search-in-buffer']       ,
"      \ 'B' : ['spacevim#plug#fzf#SearchBcword()' , 'search-cword-in-buffer'] ,
"      \ }

function! s:buftag() abort
  if exists(':BTags')
    BTags
  elseif exists(':LeaderfBufTag')
    LeaderfBufTag
  else
    echom "Not avaliable"
  endif
endfunction

let g:which_key_map['u'] = 'scroll-up'

let g:which_key_map['w'] = {
      \ 'name' : '+windows'                       ,
      \ 'w' :  'other-window'                     ,
      \ 'd' :  'delete-window'                    ,
      \ '-' :  'split-window-below'               ,
      \ '|' :  'split-window-right'               ,
      \ '2' :  'layout-double-columns'            ,
      \ 'o' :  ['only', 'close-all-windows-except-current'] ,
      \ 'h' :  'window-left'                      ,
      \ 'j' :  'window-below'                     ,
      \ 'l' :  'window-right'                     ,
      \ 'k' :  'window-up'                        ,
      \ 'H' :  'expand-window-left'               ,
      \ 'J' :  'expand-window-below'              ,
      \ 'L' :  'expand-window-right'              ,
      \ 'K' :  'expand-window-up'                 ,
      \ '=' :  'balance-window'                   ,
      \ 's' :  'split-window-below'               ,
      \ 'v' :  'split-window-below'               ,
      \ '?' :  'fzf-window'                       ,
      \ }

let g:which_key_map['l'] = {
    \ 'name'    : '+language',
    \ 'd'       : 'goto-definition',
    \ 'h'       : 'hover',
    \ 'r'       : 'find-references',
    \ 's'       : 'search-symbols'
    \ }

call which_key#register('<Space>', "g:which_key_map")
