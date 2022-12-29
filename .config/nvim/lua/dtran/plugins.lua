-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- telescope
	use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
	}

	-- nightfox theme
	use "EdenEast/nightfox.nvim" 

	-- better-escape
	use {'jdhao/better-escape.vim', event = 'InsertEnter'}

	-- lualine
	use {
 	 'nvim-lualine/lualine.nvim',
 	 requires = { 'kyazdani42/nvim-web-devicons', opt = true }
	}

	-- treesitter
  	use({'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'})

	-- harpoon
	use('theprimeagen/harpoon')
	
	-- undotree
	use('mbbill/undotree')

	-- vim-fugitive
	use('tpope/vim-fugitive')
end)
