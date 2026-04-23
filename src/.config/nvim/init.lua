require("config.lazy")

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

