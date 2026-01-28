return {
  { 'sheerun/vim-polyglot' },
  {
    'MetriC-DT/balance-theme.nvim', -- has a light theme for outdoor sessions
    lazy = false,
  },
  {
    "f-person/auto-dark-mode.nvim",
    opts = {
      set_dark_mode = function()
          vim.api.nvim_set_option_value("background", "dark", {})
          vim.cmd("colorscheme nightfox") -- Set dark colorscheme here
      end,
      set_light_mode = function()
          vim.api.nvim_set_option_value("background", "light", {})
          vim.cmd("colorscheme nightfox")
      end,
      update_interval = 3000,
      fallback = "dark",
    }
  },
  {
    "scottmckendry/cyberdream.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("cyberdream").setup({
          borderless_pickers = false,
          transparent = true,
      })
    end
  },
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nightfox").setup({
          transparent = true
        })
    end
  },
  { "folke/trouble.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' } }
}

