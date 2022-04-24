local packer = require('lib.packer-init')

local config = function(file)
    require('user.plugins.' .. file)
end

packer.startup(function(use)
    -- packer manges itself
    use({ 'wbthomason/packer.nvim' })

    use({
        'gruvbox-community/gruvbox',
        config = config('gruvbox')
    })

    -- use({ 'airblade/vim-rooter' })

    -- use({ 'roman/golden-ratio' })

    use({
        'karb94/neoscroll.nvim',
        config = config('neoscroll')
    })

    use({
        'kyazdani42/nvim-tree.lua',
        requires = { 'kyazdani42/nvim-web-devicons' },
        config = config('nvim-tree')
    })

    use({
        'tpope/vim-commentary',
        config = config('commentary')
    })

    use({
        'Asheq/close-buffers.vim',
        config = config('close-buffers')
    })

    use({
        'voldikss/vim-floaterm',
        config = config('floaterm')
    })

    -- use({
    --     'junegunn/fzf.vim',
    --     requires = { 'junegunn/fzf', run = ':call fzf#install()' },
    --     config = config('fzf')
    -- })

    use({
        'nvim-treesitter/nvim-treesitter',
        requires = {
            'lewis6991/spellsitter.nvim',
            'JoosepAlviste/nvim-ts-context-commentstring'
        },
        config = config('treesitter')
    })

    use({
        'neovim/nvim-lspconfig',
        'williamboman/nvim-lsp-installer',
        config = config('lspconfig')
    })

    use({
        'hrsh7th/nvim-cmp',
        requires = {
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'hrsh7th/cmp-nvim-lsp-signature-help',
            'onsails/lspkind-nvim'
        },
        config = config('cmp')
    })

    use({
        'lewis6991/gitsigns.nvim',
        requires = 'nvim-lua/plenary.nvim',
        config = config('gitsigns')
    })

    use({
        'tpope/vim-fugitive',
        config = config('fugitive')
    })

    use({
        'j-hui/fidget.nvim',
        config = config('fidget')
    })

    use({
        'nvim-telescope/telescope.nvim',
        requires = {
            'nvim-lua/plenary.nvim',
            'kyazdani42/nvim-web-devicons',
            -- { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
            -- 'nvim-telescope/telescope-live-grep-raw.nvim'
        },
        config = config('telescope')
    })

    use({
        'vimwiki/vimwiki',
        config = config('vimwiki')
    })

    use({
        'f-person/git-blame.nvim',
        config = config('git-blame')
    })

    use({
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            'f-person/git-blame.nvim',
        },
        config = config('lualine')
    })

    use({
        'mfussenegger/nvim-jdtls',
        config = config('jdtls')
    })

    use({
        'ojroques/vim-oscyank',
        branch = 'main',
        config = config('oscyank')
    })

    if PACKER_BOOTSTRAP then
        packer.sync()
    end
end)