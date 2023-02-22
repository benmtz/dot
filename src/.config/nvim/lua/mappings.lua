vim.g.mapleader=" "
vim.api.nvim_set_keymap('n', '<SPACE>', '<Nop>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', {noremap = true})

vim.api.nvim_set_keymap('t', '<A-ESC>', '<C-\\><C-n>', {noremap = true})
vim.api.nvim_set_keymap('t', '<F12>', '<C-\\><C-n><ESC>', {noremap = true})

local wk = require("which-key")
wk.register({
  ["<leader>"] = {
    r = {
      e = { "<cmd>e .tasks<cr>", "Edit tasks" },
    },
    t = {
      name = "Tabs",
      e = { "<cmd>tabe<cr>", "New tab"},
      n = { "<cmd>tabn<cr>", "Next tab"},
      p = { "<cmd>tabp<cr>", "Previous tab" },
    },
    i = {
      s = { '<cmd>lua vim.diagnostic.open_float()<CR>', 'Show issues' },
      p = { '<cmd>lua vim.diagnostic.goto_prev()<CR>', 'Previous issue' },
      n = { '<cmd>lua vim.diagnostic.goto_next()<CR>', 'Next issue'},
      l = { '<cmd>lua vim.diagnostic.setloclist()<CR>', 'List issues' },
    },
    z = {
      name = "Terminal",
      x = {'<cmd>15sp term://fish<cr>', 'Term in split'},
      v = {'<cmd>vsp term://fish<cr>', 'Term in vsplit' },
      e = {'<cmd>e term://fish<cr>', 'Term in buffer' },
      t = {'<cmd>tabe term://fish<cr>', 'Term in tab' }
    },
    w = {
      name = "External Apps",
      g = {'<cmd>FloatermNew --width=0.9 --height=0.9 lazygit<cr>', 'lazygit'},
      e = {'<cmd>FloatermNew --width=0.9 --height=0.9 ranger<cr>', 'ranger'},
      k = {'<cmd>FloatermNew --width=0.9 --height=0.9 k9s<cr>', 'k9s'},
      t = {'<cmd>FloatermNew taskwarrior-tui<cr>', 'taskwarrior'}
    },

    c = {
      name = "Code",
      gD = {'<cmd>lua vim.lsp.buf.declaration()<CR>', 'Go to declaration'},
      gd = {'<cmd>lua vim.lsp.buf.definition()<CR>', 'Go to definition'},
      ho = {'<cmd>lua vim.lsp.buf.hover()<CR>', 'Hover code'},
      gi = { '<cmd>lua vim.lsp.buf.implementation()<CR>', 'Go to impl'},
      he = { '<cmd>lua vim.lsp.buf.signature_help()<CR>', 'Signature'},
      wa = { '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', 'Workspace add folder'},
      wr = { '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', 'Workspace remove folder'},
      wl = { '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', 'Workspace list'},
      -- vim.api.nvim_buf_set_keymap(bufnr, 'n', k.type_definition, '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
      rn = { '<cmd>lua vim.lsp.buf.rename()<CR>', 'Rename symbol'},
      a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', 'Actions'},
      r = { '<cmd>lua vim.lsp.buf.references()<CR>', 'References'},
      fm = { '<cmd>lua vim.lsp.buf.formatting()<CR>', 'Format'}
    },
    f = {
      name = "Find",
      h = { '<cmd>lua require("telescope.builtin").git_files()<cr>', 'Find file (.gitignored)'},
      f = { '<cmd>lua require("telescope.builtin").find_files({follow = true})<cr>', 'Find file (All)' },
      m = { '<cmd>lua require("telescope.builtin").marks()<cr>', 'Find mark' },
      g = { '<cmd>lua require("telescope.builtin").live_grep()<cr>', 'Find text (grep)' },
      e = { '<cmd>Telescope file_browser<cr>', 'File browser' },
      b = { '<cmd>lua require("telescope.builtin").buffers()<cr>' , 'Find browser'},
      r = { '<cmd>lua require("telescope").extensions.asynctasks.all()<cr>', 'Find asynctask'},
      p = { '<cmd>lua require("telescope").extensions.project.project{}<cr>', 'Find project'}
    },
    y = {
      name = "Yank",
      p = { '<cmd>let @+=expand("%")<cr>', 'Yank path' },
      g = { '<cmd>let @+=system("git-remote-url " . expand("%") . " -l " . line("."))<cr>', 'Yank git path'},
      b = { [[ mzggVG"+y'z ]], 'Yank buffer' },
    }
  }
})

