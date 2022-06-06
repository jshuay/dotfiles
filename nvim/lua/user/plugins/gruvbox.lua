vim.g.gruvbox_invert_selection = 0
vim.g.gruvbox_bold = 0

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('GruvboxOverrides', { clear = true }),
    pattern = { 'gruvbox' },
    callback = function()
        vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#504945', ctermbg = 239 })
        vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#504945', ctermbg = 239 })
        vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#504945', ctermbg = 239 })
    end
})
