local k = require("keymap")
local opts = { noremap=true, silent=true }
local function set_keymap(...) vim.api.nvim_set_keymap('n', ...) end

vim.g.mapleader=" "
vim.api.nvim_set_keymap('n', '<SPACE>', '<Nop>', {noremap = true})

vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', {noremap = true})
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', {noremap = true})
-- vim.api.nvim_set_keymap('i', '<C-j>', '<C-w><C-j>', {noremap = true})

vim.api.nvim_set_keymap('t', '<A-ESC>', '<C-\\><C-n>', {noremap = true})
-- f for find
set_keymap(k.search_file_all,'<cmd>lua require("telescope.builtin").git_files()<cr>', opts)
set_keymap(k.search_file_git,'<cmd>lua require("telescope.builtin").find_files({follow = true})<cr>', opts)
set_keymap(k.search_marks,'<cmd>lua require("telescope.builtin").marks()<cr>', opts)
set_keymap(k.live_grep,'<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
set_keymap(k.explorer,'<cmd>Telescope file_browser<cr>', opts)
set_keymap(k.search_buffers,'<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
set_keymap(k.search_run_tasks,'<cmd>lua require("telescope").extensions.asynctasks.all()<cr>', opts)
set_keymap(k.telescope_project,'<cmd>lua require("telescope").extensions.project.project{}<cr>', opts)
-- set_keymap('<leader>fp','<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)


-- g for git
set_keymap(k.search_git_branches,'<cmd>lua require("telescope.builtin").git_branches()<cr>', opts)
set_keymap(k.search_git_commits,'<cmd>lua require("telescope.builtin").git_bcommits()<cr>', opts)
set_keymap(k.search_git_status,'<cmd>lua require("telescope.builtin").git_status()<cr>', opts)
set_keymap(k.git_file_path,'<cmd>lua require("git_file").get_file_url()<cr>', opts)


-- e for edit
set_keymap(k.edit_tasks,'<cmd>e .tasks<cr>', opts)

-- z for zsh (well now it's fish)
set_keymap(k.term_bottom,'<cmd>15sp term://fish<cr>', opts) -- x to mimick telescope mappings
set_keymap(k.term_right,'<cmd>vsp term://fish<cr>', opts)
set_keymap(k.term_buffer,'<cmd>e term://fish<cr>', opts)


-- t for tab
set_keymap(k.tab_new,'<cmd>tabe<cr>', opts)
set_keymap(k.tab_next,'<cmd>tabn<cr>', opts)
set_keymap(k.tab_previous,'<cmd>tabp<cr>', opts)

-- w for floattermW
set_keymap('<leader>wg', '<cmd>FloatermNew --width=0.9 --height=0.9 lazygit<cr>', opts)
set_keymap('<leader>we', '<cmd>FloatermNew --width=0.9 --height=0.9 ranger<cr>', opts)
set_keymap('<leader>wt', '<cmd>FloatermNew taskwarrior-tui<cr>', opts)
-- set_keymap('<leader>wt', '<cmd>FloatermToggle<cr>', opts)

-- y for yank things
-- Even if it's mainly related to yanking to the clipboard
-- yanking to other registers should still end there
set_keymap(k.yank_path,'<cmd>let @+=expand("%")<cr>', opts)
set_keymap(k.yank_git,'<cmd>let @+=system("git-remote-url " . expand("%") . " -l " . line("."))<cr>', opts)
set_keymap(k.yank_buffer, [[ mzggVG"+y'z ]], opts)

