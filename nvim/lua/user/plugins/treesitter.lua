local nvim_treesitter_configs_status, nvim_treesitter_configs = pcall(require, 'nvim-treesitter.configs')
if not nvim_treesitter_configs_status then
    return
end

nvim_treesitter_configs.setup({
    ensure_installed = 'all',
    highlight = {
        enable = true,
        disable = { 'NvimTree' },
    },
    context_commentstring = {
        enable = true
    }
})

local spellsitter_status, spellsitter = pcall(require, 'spellsitter')
if not spellsitter_status then
    return
end

spellsitter.setup()
