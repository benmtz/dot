require("plugins")
require("mappings")
require("global-settings")
require("telescope-config")


-- Plugin specific configurations
-- Development utilities
require("trouble").setup { }
require("autocompletion")
require("language-servers")


require("indent_blankline").setup {
    -- for example, context is off by default, use this to turn it on
    show_current_context = true,
    show_current_context_start = true,
}

require'colorizer'.setup()

-- Comments
require('nvim_comment').setup()


-- Theming
-- require("dashboard-setup")
require("lualine-config")

require("auto-session").setup {
  log_level = "error",

  cwd_change_handling = {
    restore_upcoming_session = true, -- already the default, no need to specify like this, only here as an example
    pre_cwd_changed_hook = nil, -- already the default, no need to specify like this, only here as an example
    post_cwd_changed_hook = function() -- example refreshing the lualine status line _after_ the cwd changes
      require("lualine").refresh() -- refresh lualine so the new session name is displayed in the status bar
    end,
  },
}

