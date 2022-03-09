let g:ale_linters = {'rust': ['cargo']}
let g:airline#extensions#ale#enabled = 1

let g:ale_fix_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_set_quickfix = 1
let g:ale_open_list = 1

let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
    \ 'python': ['/usr/local/bin/pyls'],
    \ 'vue': ['vls'],
    \ 'typescript': ['typescript-language-server', '--stdio'],
    \ }

nmap <silent> <leader>ll :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nmap <silent> <leader>lh :call LanguageClient#textDocument_hover()<CR>
nmap <silent> <leader>ld :call LanguageClient#textDocument_definition()<CR>
nmap <silent> <leader>lr :call LanguageClient#textDocument_rename()<CR>

nmap <silent> <leader>ld :ALEGoToDefinition<CR>
nmap <silent> <leader>lh :ALEHover<CR>
nmap <silent> <leader>lr :ALEFindReferences<CR>
nmap <silent> <leader>ls :ALESymbolSearch<CR>
nmap <silent> <leader>ep :cprevious<CR>
nmap <silent> <leader>en :cnext<CR>
