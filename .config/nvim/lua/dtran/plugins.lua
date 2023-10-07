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
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- nightfox theme
    use "EdenEast/nightfox.nvim"

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

    -- lsp-zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        requires = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        }
    }

    -- nvim-notify
    use('rcarriga/nvim-notify')

    -- dashboard-nvim
    use {
        'glepnir/dashboard-nvim',
        -- event = 'VimEnter',
        requires = {'nvim-tree/nvim-web-devicons'},
   }

    -- wilder.nvim
    use('gelguy/wilder.nvim')

    -- specs.nvim
    use('edluffy/specs.nvim')

    -- nvim-web-devicons
    use('nvim-tree/nvim-web-devicons')

    -- vim-be-good
    use('theprimeagen/vim-be-good')
end)
