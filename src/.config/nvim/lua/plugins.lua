local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--local prompts = require(vim.fn.stdpath("config") .. "/lua/prompts.lua")

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  --  INIT plugins --
  { 'junegunn/fzf.vim',
    lazy = false ,
    dependencies = {
      'junegunn/fzf'
    },
  },
  {
    "ibhagwan/fzf-lua",
    -- optional for icon support
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local actions = require("fzf-lua").actions
      require("fzf-lua").setup({
        files = {
          actions = {
            ["ctrl-h"] = actions.file_split,
            ["ctrl-v"] = actions.file_vsplit,
            ["ctrl-t"] = actions.file_tabedit,
          }
        },
        buffers= {
          actions = {
            ["ctrl-h"] = actions.buf_split,
            ["ctrl-v"] = actions.buf_vsplit,
            ["ctrl-t"] = actions.buf_tabedit,
          }
        }
      })
    end
  },
  {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
  },
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main",
    dependencies = {
      { "zbirenbaum/copilot.lua" },
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = function()
      -- local prompts = require("prompts")
      return {
        debug = false, -- Enable debugging
        -- See Configuration section for rest
        prompts = {
          GitStage = {
            prompt = '> #git:staged\n\nSuggest optimizations about the code staged',
            system_prompt = 'You are a rockstar developer, specializing in cmake jenkins c++ and typescript. You do not hallucinate, and are very good at explaining context and giving sources. You know that sometimes it is ok to say that something is good enough.',
            description = 'Optimize my git staging area'
          },
          EdgeCase = {
            prompt = 'Find edge cases in the current buffer',
            system_prompt = 'You are a rockstar developer, specializing in cmake jenkins c++ and typescript. You do not hallucinate, and are very good at explaining context and giving sources, you are concise. You know that sometimes it is ok to say that something is good enough.',
            description = 'Find edge cases in the current buffer'
          },
          CodeSmells = {
            prompt = 'Find code smells cases in the current buffer',
            system_prompt = 'You are a rockstar developer, specializing in cmake jenkins c++ and typescript. You do not hallucinate, and are very good at explaining context and giving sources, you are concise. You know that sometimes it is ok to say that something is good enough.',
            description = 'Find code smells in the current buffer'
          }

        }
      }
    end

  },
	{ 'nvim-treesitter/nvim-treesitter', lazy = false, priority = 1000 },
  {
    'MetriC-DT/balance-theme.nvim', -- has a light theme for outdoor sessions
    lazy = false,
  },
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {},
  -- },
  { 
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
        vim.cmd.colorscheme('rose-pine')
    end
},
  --{
  --  'sainnhe/gruvbox-material',
  --  lazy = false,
  --  priority = 1000,
  --  config = function()
  --    vim.g.gruvbox_material_transparent_background = 2
  --    vim.g.gruvbox_material_background = 'hard'
  --    vim.g.gruvbox_material_enable_italic = true
  --    vim.cmd.colorscheme('gruvbox-material')
  --  end
  --},
	{ 'norcalli/nvim-colorizer.lua' },
	{ 'folke/which-key.nvim', lazy = true },
  { 'sheerun/vim-polyglot' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'voldikss/vim-floaterm' },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "neovim/nvim-lspconfig" },
  { 'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'dcampos/cmp-snippy',
      'dcampos/nvim-snippy',
    }
  },
  { 'rmagatti/auto-session',
     lazy = false,
     priority = 1000,
     config = function()
       require("auto-session").setup {
         log_level = "error",
         auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
       }
     end
  },
  { "lukas-reineke/indent-blankline.nvim" },
  { "folke/trouble.nvim", dependencies = { "kyazdani42/nvim-web-devicons" } },
  { 'ckipp01/nvim-jenkinsfile-linter', dependencies = { "nvim-lua/plenary.nvim" } },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'kyazdani42/nvim-web-devicons' } },
  {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  },
})

