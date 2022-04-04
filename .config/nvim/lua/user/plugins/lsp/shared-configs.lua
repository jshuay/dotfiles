local M = {}

local bmap = require('lib.keymap').buf_keymap

M.on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    bmap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
    bmap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
    bmap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
    bmap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
    bmap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')
    bmap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
    bmap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
    -- Telescope provides nicer lsp references integration with float window
    -- bmap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')

    vim.cmd('command! Format execute "lua vim.lsp.buf.formatting()"')
end

M.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

return M
