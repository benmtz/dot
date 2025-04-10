vim.g.mapleader = " "

vim.api.nvim_set_keymap('n', '<SPACE>', '<Nop>', { noremap = true })

vim.api.nvim_set_keymap('n', '<C-j>', '<C-w><C-j>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-h>', '<C-w><C-h>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-k>', '<C-w><C-k>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<C-w><C-l>', { noremap = true })

vim.api.nvim_set_keymap('', '<F2>', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true } )

vim.api.nvim_set_keymap('t', '<F12>', '<C-\\><C-n><ESC>', { noremap = true })
vim.api.nvim_set_keymap('i', '<F12>', '<ESC>', { noremap = true })

vim.api.nvim_set_keymap('n', '<D-Right>', '<cmd>bnext<cr>', { noremap = true })
vim.api.nvim_set_keymap('n', '<D-Left>', '<cmd>bprev<cr>', { noremap = true })

vim.api.nvim_set_keymap('', '<C-_>', 'gc', { })
vim.api.nvim_set_keymap('', '<C-/>', 'gc', { })

vim.api.nvim_set_keymap('t', '<A-ESC>', '<C-\\><C-n>', { noremap = true })
-- <D-e><D-r><D-y><D-l><D-;><Right><D-o>
-- <D-Right><D-Left>

-- Reminders
-- <C-X> is Control - C-X
-- <S-F12> is Shift - F12
-- <A-X> or <M-X> - is the alt key (what is on macOS ?)
-- <D-X> is the command key on macOS

ftask = function()
  build_task_command =function(selected)
    return "direnv exec " .. vim.fn.getcwd() .. " task " .. selected
  end
  require'fzf-lua'.fzf_exec(
    "task --list-all"
      .. " | sed -e '1d; s/\\* \\(.*\\):\\s*\\(.*\\)\\s*(aliases.*/\\1\\t\\2/' -e 's/\\* \\(.*\\):\\s*\\(.*\\)/\\1\\t\\2/'"
      .. " | awk '{$1= $1};1'",
      {
        actions = {
          ['default'] = function(selected)
            vim.cmd("FloatermNew --width=0.98 --height=0.98 --autoclose=0 " .. build_task_command(selected[1]) .. "" )
          end,
          ['ctrl-x'] = function(selected, opts)
            vim.cmd("sp term://" .. build_task_command(selected[1]))
          end,
          ['ctrl-v'] = function(selected, opts)
            vim.cmd("vsp term://" .. build_task_command(selected[1]))
          end,
        }
      }
  )
end

gg = function()
  require'fzf-lua'.fzf_exec(
    "fd --no-ignore-vcs -d 3 -H -g '**/.git'"
      .. " | sed -E 's/\\/?\\.git\\/?$//g'",
      {
        actions = {
          ['default'] = function(selected)
            local repo = selected[1]
            if (repo == nil or repo == '') then
              vim.cmd("FloatermNew --width=0.98 --height=0.98 lazygit")
              vim.api.nvim_feedkeys("a", "n", true)
            else
              vim.cmd("FloatermNew --width=0.98 --height=0.98 lazygit -p " .. selected[1])
              vim.api.nvim_feedkeys("a", "n", true)
            end
          end,
        }
      }
  )
end


local wk = require("which-key")
wk.add(
  {
    { "<leader>c", group = "Code" },
    { "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", desc = "Actions" },
    { "<leader>cc", "<cmd>cclose<cr>", desc = "Close quickfixes" },
    { "<leader>cf", group = "Format" },
    { "<leader>cfm", "<cmd>lua vim.lsp.buf.formatting()<CR>", desc = "Format" },
    { "<leader>cg", group = "Go to..." },
    { "<leader>cgD", "<cmd>lua vim.lsp.buf.declaration()<CR>", desc = "declaration" },
    { "<leader>cgd", "<cmd>lua vim.lsp.buf.definition()<CR>", desc = "definition" },
    { "<leader>cgi", "<cmd>lua vim.lsp.buf.implementation()<CR>", desc = "implementation" },
    { "<leader>cgr", "<cmd>lua vim.lsp.buf.references()<CR>", desc = "References" },
    { "<leader>ch", group = "Code help and suggestions" },
    { "<leader>che", "<cmd>lua vim.lsp.buf.signature_help()<CR>", desc = "Signature" },
    { "<leader>cho", "<cmd>lua vim.lsp.buf.hover()<CR>", desc = "Hover code" },
    { "<leader>cl", group = "Lint" },
    { "<leader>clj", '<cmd>lua require("jenkinsfile_linter").validate()<CR>', desc = "Validate Jenkinsfile" },
    { "<leader>co", "<cmd>copen<cr>", desc = "Open quickfixes" },
    { "<leader>crn", "<cmd>lua vim.lsp.buf.rename()<CR>", desc = "Rename symbol" },
    { "<leader>cw", group = "Workspace" },
    { "<leader>cwa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", desc = "Add folder to workspace" },
    { "<leader>cwl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", desc = "List folder workspaces" },
    { "<leader>cwr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", desc = "Remove folder from workspace" },
    { "<leader>f", group = "Find" },
    { "<leader>fb", '<cmd>lua require("fzf-lua").buffers({sort_lastused = true})<cr>', desc = "Find in buffers" },
    { "<leader>ff", '<cmd>lua require("fzf-lua").files()<cr>', desc = "Find files" },
    { "<leader>fg", '<cmd>lua require("fzf-lua").live_grep_native()<cr>', desc = "Find text (grep)" },
    { "<leader>fh", '<cmd>lua require("fzf-lua").git_bcommits()<cr>', desc = "Buffer history" },
    { "<leader>fj", '<cmd>lua require("fzf-lua").jumps()<cr>', desc = "Fuzzy jumps" },
    { "<leader>fm", '<cmd>lua require("fzf-lua").marks()<cr>', desc = "Find mark" },
    { "<leader>fp", '<cmd>lua require("fzf-lua").colorschemes()<cr>', desc = "Fuzzy colorschemes" },
    { "<leader>ft", "<cmd>lua ftask()<cr>", desc = "Run task" },
    { "<leader>gg", "<cmd>lua gg()<cr>", desc = "Git" },
    { "<leader>gb", "<cmd>GitBlameToggle<cr>", desc = "Git" },
    { "<leader>i", group = "Issues" },
    { "<leader>id", "<cmd>TroubleToggle document_diagnostics<cr>", desc = "Toggle trouble focument" },
    { "<leader>il", "<cmd>TroubleToggle loclist<cr>", desc = "Toggle trouble loclist" },
    { "<leader>in", "<cmd>lua vim.diagnostic.goto_next()<CR>", desc = "Next issue" },
    { "<leader>ip", "<cmd>lua vim.diagnostic.goto_prev()<CR>", desc = "Previous issue" },
    { "<leader>iq", "<cmd>TroubleToggle quickfix<cr>", desc = "Toggle trouble quickfix" },
    { "<leader>is", "<cmd>lua vim.diagnostic.open_float()<CR>", desc = "Show issues" },
    { "<leader>iw", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Toggle trouble workspace" },
    { "<leader>m", group = "Misc" },
    { "<leader>mn", group = "Nvim" },
    { "<leader>mnr", "<cmd>source $MYVIMRC<cr>", desc = "Reload nvim config" },
    { "<leader>t", group = "Tabs" },
    { "<leader>te", "<cmd>tabe<cr>", desc = "New tab" },
    { "<leader>tn", "<cmd>tabn<cr>", desc = "Next tab" },
    { "<leader>tp", "<cmd>tabp<cr>", desc = "Previous tab" },
    { "<leader>w", group = "External Apps" },
    { "<leader>we", "<cmd>FloatermNew --width=0.98 --height=0.98 yazi<cr>", desc = "yazi" },
    { "<leader>wk", "<cmd>FloatermNew --width=0.98 --height=0.98 k9s<cr>", desc = "k9s" },
    { "<leader>wt", "<cmd>FloatermNew taskwarrior-tui<cr>", desc = "taskwarrior" },
    { "<leader>y", group = "Yank" },
    { "<leader>yb", " mzggVG\"+y'z ", desc = "Yank buffer" },
    { "<leader>yg", '<cmd>let @+=system("git-remote-url " . expand("%") . " -l " . line("."))<cr>', desc = "Yank git path" },
    { "<leader>yp", '<cmd>let @+=expand("%")<cr>', desc = "Yank path" },
    { "<leader>z", group = "Terminal" },
    { "<leader>ze", "<cmd>e term://fish<cr>", desc = "Term in buffer" },
    { "<leader>zt", "<cmd>tabe term://fish<cr>", desc = "Term in tab" },
    { "<leader>zv", "<cmd>vsp term://fish<cr>", desc = "Term in vsplit" },
    { "<leader>zx", "<cmd>15sp term://fish<cr>", desc = "Term in split" },
    { "<leader>a", group = "Assistant" },
    { "<leader>at", "<cmd>CopilotChatToggle<cr>", desc = "Toggle chat" },
    { "<leader>am", "<cmd>CopilotChatModels<cr>", desc = "Change model" },
    { "<leader>ag", "<cmd>CopilotChatGitStage<cr>", desc = "Optimize staged" },
    { "<leader>ae", "<cmd>CopilotChatEdgeCase<cr>", desc = "Find edge cases" },
    { "<leader>as", "<cmd>CopilotChatCodeSmells<cr>", desc = "Find code smells" },
  }
)
