require('nvim-treesitter.configs').setup({
    ensure_installed = 'maintained',
    highlight = {
        enable = true,
        disable = { 'NvimTree' },
    },
    context_commentstring = {
        enable = true
    }
})

require('spellsitter').setup()
