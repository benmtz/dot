local k = require("keymap")
local opts = { noremap=true, silent=true }
local function set_keymap(...) vim.api.nvim_set_keymap('n', ...) end

vim.g.mapleader=" "
vim.api.nvim_set_keymap('n', '<SPACE>', '<Nop>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', {noremap = true})

vim.api.nvim_set_keymap('t', '<A-ESC>', '<C-\\><C-n>', {noremap = true})

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
    z = {
      name = "Terminal",
      e = {'<cmd>15sp term://fish<cr>', 'Term in split'},
      x = {'<cmd>vsp term://fish<cr>', 'Term in vsplit' },
      v = {'<cmd>e term://fish<cr>', 'Term in buffer' }
    },
    w = {
      name = "External Apps",
      g = {'<cmd>FloatermNew --width=0.9 --height=0.9 lazygit<cr>', 'lazygit'},
      e = {'<cmd>FloatermNew --width=0.9 --height=0.9 ranger<cr>', 'ranger'},
      t = {'<cmd>FloatermNew taskwarrior-tui<cr>', 'taskwarrior'}
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

