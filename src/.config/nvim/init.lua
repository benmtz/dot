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

