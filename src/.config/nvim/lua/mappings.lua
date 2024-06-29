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
    "fd --no-ignore-vcs -d 5 -H -g '**/.git'"
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
wk.register({
  ["<leader>"] = {
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
      g = { '<cmd>lua gg()<cr>', 'Git' },
      -- g = { '<cmd>FloatermNew --width=0.98 --height=0.98 lazygit<cr>', 'lazygit' },
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
      f = { '<cmd>lua require("fzf-lua").files()<cr>', 'Find files' },
      m = { '<cmd>lua require("fzf-lua").marks()<cr>', 'Find mark' },
      h = { '<cmd>lua require("fzf-lua").git_bcommits()<cr>', 'Buffer history' },
      g = { '<cmd>lua require("fzf-lua").live_grep_native()<cr>', 'Find text (grep)' },
      b = { '<cmd>lua require("fzf-lua").buffers({sort_lastused = true})<cr>', 'Find in buffers' },
      p = { '<cmd>lua require("fzf-lua").colorschemes()<cr>', 'Fuzzy colorschemes' },
      j = { '<cmd>lua require("fzf-lua").jumps()<cr>', 'Fuzzy jumps' },
      t = { '<cmd>lua ftask()<cr>', 'Run task' }
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
