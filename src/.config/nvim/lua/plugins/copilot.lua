return {
  {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({})
      end,
  },
  {
    "zbirenbaum/copilot-cmp",
    config = function ()
      require("copilot_cmp").setup()
    end
  },
  {
    "olimorris/codecompanion.nvim",
    opts = function()
      return {
        adapters = {
          copilot = function()
            return require("codecompanion.adapters").extend("copilot", {
              schema = {
                model = {
                  default = "gemini-2.5-pro",
                  -- default = "gemini-2.0-flash",
                },
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "copilot",
          },
          inline = {
            adapter = "copilot",
          },
        },
        display = {
          diff = {
            provider = "mini_diff",
          },
        },
        opts = {
          log_level = "DEBUG",
        },
      }
    end,
    init = function()
      require("plugins.codecompanion.fidget-spinner"):init()
      require("mini.diff").setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      "j-hui/fidget.nvim",
      "echasnovski/mini.nvim"
    },
  }
}

