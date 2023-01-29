require("plugins")
require("mappings")
require("global-settings")
require("telescope-config")

-- Plugin specific configurations
-- Development utilities
require("trouble").setup { }
require("autocompletion")
require("language-servers")
--
-- Theming
require("dashboard-setup")
require("lualine-config")

