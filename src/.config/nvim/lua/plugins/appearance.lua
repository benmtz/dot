return {
  { 'sheerun/vim-polyglot' },
  { "lukas-reineke/indent-blankline.nvim" },
  {
    'MetriC-DT/balance-theme.nvim', -- has a light theme for outdoor sessions
    lazy = false,
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        vim.cmd.colorscheme('rose-pine')
    end
  },
  { "folke/trouble.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' } }
}

