local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()

  use 'wbthomason/packer.nvim'

	use 'norcalli/nvim-colorizer.lua'

	use 'sheerun/vim-polyglot'

	use {
    "folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
	}

	use {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
	}

	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'dcampos/cmp-snippy',
			'dcampos/nvim-snippy',
		}
	}

	-- Jenkins linting
	use({'ckipp01/nvim-jenkinsfile-linter', requires = { "nvim-lua/plenary.nvim" } })

	-- Telescope
	use {
	  'nvim-telescope/telescope.nvim',
	  requires = {
		  {'nvim-lua/plenary.nvim'},
		  {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'},
			{'nvim-telescope/telescope-file-browser.nvim'},
			{'benmtz/telescope-project.nvim'},
	  }
	}

	use 'saadparwaiz1/cmp_luasnip'

	-- Comments
	use "terrortylor/nvim-comment"

	-- Task management
	use 'skywind3000/asynctasks.vim'                           -- Task management system
	use 'skywind3000/asyncrun.vim'
	use 'GustavoKatel/telescope-asynctasks.nvim'

	-- UI plugins
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}
	use {
		'glepnir/dashboard-nvim',
		requires = {'nvim-tree/nvim-web-devicons'}
	}
	use 'folke/tokyonight.nvim'

	use 'voldikss/vim-floaterm'

	use "lukas-reineke/indent-blankline.nvim"

	use "folke/which-key.nvim"

	if packer_bootstrap then
    require('packer').sync()
  end

end)
