require("plugin.theme")
require("plugin.language_server")
require("plugin.blame")
require("plugin.comments")
require("plugin.blankline")
require("plugin.fzf")

require("plugin.navigation")
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

