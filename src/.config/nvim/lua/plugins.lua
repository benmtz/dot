local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function()

  use 'wbthomason/packer.nvim'

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

	use 'skywind3000/asynctasks.vim'                           -- Task management system
	use 'skywind3000/asyncrun.vim'
	use 'GustavoKatel/telescope-asynctasks.nvim'

	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	use 'voldikss/vim-floaterm'

	-- use 'goolord/alpha-nvim'
	use {
  'glepnir/dashboard-nvim',
  requires = {'nvim-tree/nvim-web-devicons'}
}

	-- Themes --
	-- use 'morhetz/gruvbox'
	-- use 'joshdick/onedark.vim'
	-- use { "catppuccin/nvim", as = "catppuccin" }
  -- use "EdenEast/nightfox.nvim" -- Packer
	use 'folke/tokyonight.nvim'

	use "folke/which-key.nvim"

	use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }


	if packer_bootstrap then
    require('packer').sync()
  end

end)
