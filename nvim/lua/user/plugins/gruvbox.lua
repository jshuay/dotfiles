vim.g.gruvbox_invert_selection = 0
vim.g.gruvbox_bold = 0

vim.cmd([[
    augroup GruvboxOverrides
        autocmd!
        autocmd ColorScheme gruvbox highlight LspReferenceText ctermbg=239 guibg=#504945
        autocmd ColorScheme gruvbox highlight LspReferenceRead ctermbg=239 guibg=#504945
        autocmd ColorScheme gruvbox highlight LspReferenceWrite ctermbg=239 guibg=#504945
    augroup end

    colorscheme gruvbox
]])
