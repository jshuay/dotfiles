vim.g.gruvbox_invert_selection = 0
vim.g.gruvbox_bold = 0
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_sign_column = 'bg0'

vim.api.nvim_create_autocmd('ColorScheme', {
    group = vim.api.nvim_create_augroup('GruvboxOverrides', { clear = true }),
    pattern = { 'gruvbox' },
    callback = function()
        vim.api.nvim_set_hl(0, 'LspReferenceText', { bg = '#504945', ctermbg = 239 })
        vim.api.nvim_set_hl(0, 'LspReferenceRead', { bg = '#504945', ctermbg = 239 })
        vim.api.nvim_set_hl(0, 'LspReferenceWrite', { bg = '#504945', ctermbg = 239 })

        vim.api.nvim_set_hl(0, 'NormalFloat', {})
        vim.api.nvim_set_hl(0, 'FloatBorder', {})

        vim.api.nvim_set_hl(0, 'ScrollbarHandleCustom', { bg = '#1d2021' })
        vim.api.nvim_set_hl(0, 'ScrollbarSearchCustom', { fg = '#458588' })
        vim.api.nvim_set_hl(0, 'ScrollbarCursorCustom', { fg = '#fabd2f' })

        vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#fe8019' })

        vim.api.nvim_set_hl(0, 'Search', {})
        vim.api.nvim_set_hl(0, 'IncSearch', {})
    end
})
