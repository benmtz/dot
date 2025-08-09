local vscode = require('vscode')

vim.opt.clipboard:append { "unnamedplus" }

function add_block_comments_with_copilot()
    vscode.action('inlineChat.start') 
    vscode.action('inlineChat.sendMessage', {
        message = "Add block comments to the selected code",
        language = vim.bo.filetype,
    }) 
end

vim.g.mapleader = " "

vim.keymap.set("i", "§", "<Esc>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>cf", "<Cmd>lua require('vscode').action('editor.action.formatDocument')<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>am", "<Cmd>lua require('vscode').action('workbench.action.chat.openModelPicker')<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>ac", "<Cmd>lua require('vscode').action('workbench.action.chat.open')<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>aa", "<Cmd>lua require('vscode').action('workbench.action.chat.openAgent')<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>av", "<Cmd>lua require('vscode').action('workbench.action.chat.openAgent')<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>nr", "<Cmd>lua require('vscode').action('vscode-neovim.restart')<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>nt", "<Cmd>lua require('vscode').action('nx.run.target')<CR>", { noremap = true, silent = true })

vim.keymap.set("n", "<leader>mc", "<Cmd>lua add_block_comments_with_copilot()<CR>", { noremap = true, silent = true })
