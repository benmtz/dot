-- Add the /site packpath manually, for some reasons packpath
-- does not work well with asdf
-- vim.opt.packpath:prepend(vim.fn.stdpath('data') .. '/site')

-- require("config.lazy")

require("plugin.navigation")
require("plugin.theme")
require("plugin.language_server")
require("plugin.blame")
require("plugin.comments")
require("plugin.blankline")
require("plugin.fzf")

require("mappings")
require("global-settings")
require("telescope-config")

-- Plugin specific configurations
-- Development utilities
require("trouble").setup { }
require("autocompletion")
require("language-servers")

require'colorizer'.setup()

require("lualine-config")

