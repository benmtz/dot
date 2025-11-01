let mapleader = "\<Space>"

nnoremap <leader>cf <Cmd>lua require('vscode').action('editor.action.formatDocument')<CR>

nnoremap <leader>am <Cmd>lua require('vscode').action('workbench.action.chat.openModelPicker')<CR>
nnoremap <leader>ac <Cmd>lua require('vscode').action('workbench.action.chat.open')<CR>
nnoremap <leader>aa <Cmd>lua require('vscode').action('workbench.action.chat.openAgent')<CR>

nmap <leader>nr <Cmd>lua require('vscode').action('vscode-neovim.restart')<CR>
