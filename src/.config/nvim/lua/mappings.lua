vim.g.mapleader = " "
vim.api.nvim_set_keymap('n', '<SPACE>', '<Nop>', { noremap = true })

vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', { noremap = true })

vim.api.nvim_set_keymap('t', '<A-ESC>', '<C-\\><C-n>', { noremap = true })
vim.api.nvim_set_keymap('t', '<F12>', '<C-\\><C-n><ESC>', { noremap = true })
vim.api.nvim_set_keymap('i', '<F12>', '<ESC>', { noremap = true })

local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    r = {
      name = "Tasks",
      e = { "<cmd>e .tasks<cr>", "Edit tasks" },
      r = { '<cmd>lua require("telescope").extensions.asynctasks.all()<cr>', 'Find asynctask' },
    },
    t = {
      name = "Tabs",
      e = { "<cmd>tabe<cr>", "New tab" },
      n = { "<cmd>tabn<cr>", "Next tab" },
      p = { "<cmd>tabp<cr>", "Previous tab" },
    },
    i = {
      name = "Issues",
      s = { '<cmd>lua vim.diagnostic.open_float()<CR>', 'Show issues' },
      p = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Previous issue' },
      n = { '<cmd>lua vim.diagnostic.goto_next()<CR>', 'Next issue' },
      -- l = { '<cmd>lua vim.diagnostic.setloclist()<CR>', 'List issues' },
      -- nnoremap <leader>xx <cmd>TroubleToggle<cr>
      w = {'<cmd>TroubleToggle workspace_diagnostics<cr>', 'Toggle trouble workspace' },
      d = {'<cmd>TroubleToggle document_diagnostics<cr>', 'Toggle trouble focument'},
      q = {'<cmd>TroubleToggle quickfix<cr>', 'Toggle trouble quickfix'},
      l = {'<cmd>TroubleToggle loclist<cr>','Toggle trouble loclist' },
      -- R = {'<cmd>TroubleToggle lsp_references<cr>'}
    },
    z = {
      name = "Terminal",
      x = { '<cmd>15sp term://fish<cr>', 'Term in split' },
      v = { '<cmd>vsp term://fish<cr>', 'Term in vsplit' },
      e = { '<cmd>e term://fish<cr>', 'Term in buffer' },
      t = { '<cmd>tabe term://fish<cr>', 'Term in tab' }
    },
    g = {
      g = { '<cmd>FloatermNew --width=0.98 --height=0.98 lazygit<cr>', 'lazygit' },
    },
    w = {
      name = "External Apps",
      e = { '<cmd>FloatermNew --width=0.98 --height=0.98 yazi<cr>', 'yazi' },
      k = { '<cmd>FloatermNew --width=0.98 --height=0.98 k9s<cr>', 'k9s' },
      t = { '<cmd>FloatermNew taskwarrior-tui<cr>', 'taskwarrior' }
    },
    c = {
      name = "Code",
      g = {
        name = "Go to...",
        D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', 'declaration' },
        d = { '<cmd>lua vim.lsp.buf.definition()<CR>', 'definition' },
        i = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'implementation' },
        r = { '<cmd>lua vim.lsp.buf.references()<CR>', 'References' },

      },
      h = {
        name = "Code help and suggestions",
        o = { '<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover code' },
        e = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature' },
      },
      w = {
        name = "Workspace",
        a = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Add folder to workspace' },
        r = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Remove folder from workspace' },
        l = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'List folder workspaces' },
      },
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', k.type_definition, '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      rn = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename symbol' },
      a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Actions' },
      o = { '<cmd>copen<cr>', 'Open quickfixes' },
      c = { '<cmd>cclose<cr>', 'Close quickfixes' },
      f = {
        name = "Format",
        m = {'<cmd>lua vim.lsp.buf.formatting()<CR>', 'Format' }
      },
      l = {
        name = "Lint",
        j = { '<cmd>lua require("jenkinsfile_linter").validate()<CR>', 'Validate Jenkinsfile' }
      }
    },
    f = {
      name = "Find",
      f = { '<cmd>lua require("telescope.builtin").git_files()<cr>', 'Find file (.gitignored)' },
      a = { '<cmd>lua require("telescope.builtin").find_files({follow = true})<cr>', 'Find file (All)' },
      m = { '<cmd>lua require("telescope.builtin").marks()<cr>', 'Find mark' },
      g = { '<cmd>lua require("telescope.builtin").live_grep()<cr>', 'Find text (grep)' },
      e = { '<cmd>Telescope file_browser<cr>', 'File browser' },
      b = { '<cmd>lua require("telescope.builtin").buffers()<cr>', 'Find browser' },
      r = { '<cmd>lua require("telescope").extensions.asynctasks.all()<cr>', 'Find asynctask' },
      p = { '<cmd>lua require("telescope").extensions.project.project{}<cr>', 'Find project' },
      t = { '<cmd>lua require("telescope").extensions.go_task.go_task{}<cr>', 'Run task' }
    },
    y = {
      name = "Yank",
      p = { '<cmd>let @+=expand("%")<cr>', 'Yank path' },
      g = { '<cmd>let @+=system("git-remote-url " . expand("%") . " -l " . line("."))<cr>', 'Yank git path' },
      b = { [[ mzggVG"+y'z ]], 'Yank buffer' },
    },
    m = {
      name = "Misc",
      n = {
        name = "Nvim",
        r = { '<cmd>source $MYVIMRC<cr>', 'Reload nvim config' }
      }
    }
  }
})
