-- This file can be loaded by calling `lua require('plugins')` from your init.vim

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'
    
    -- THEMES --
    
    -- nightfox theme
    -- use "EdenEast/nightfox.nvim"

    -- tokyonight theme
    use "folke/tokyonight.nvim"

    -- telescope
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use { 
        'nvim-telescope/telescope-fzf-native.nvim', 
        run = 'make'
    }

    -- better-escape
    use { 'jdhao/better-escape.vim', event = 'InsertEnter' }

    -- lualine
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- nvim-treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    -- harpoon
    use('theprimeagen/harpoon')

    -- undotree
    use('mbbill/undotree')

    -- vim-fugitive
    use('tpope/vim-fugitive')

    -- lsp
    use {
        -- 'williamboman/nvim-lsp-installer',
        'neovim/nvim-lspconfig',
        'hrsh7th/nvim-cmp',
        'hrsh7th/cmp-nvim-lsp',
    }

    -- nvim-notify
    use('rcarriga/nvim-notify')

    -- dashboard-nvim
    use {
        'nvimdev/dashboard-nvim',
        -- event = 'VimEnter',
        requires = {'nvim-tree/nvim-web-devicons'},
   }

    -- wilder.nvim
    use('gelguy/wilder.nvim')

    -- specs.nvim
    use('cxwx/specs.nvim')

    -- nvim-web-devicons
    use('nvim-tree/nvim-web-devicons')

    -- vim-be-good
    use('theprimeagen/vim-be-good')

    -- vim-tmux-navigator
    use('christoomey/vim-tmux-navigator')
end)
