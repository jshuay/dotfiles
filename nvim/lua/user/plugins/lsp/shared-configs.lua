local M = {}

local bmap = require('lib.keymap').buf_keymap
local map = require('lib.keymap').keymap

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

    -- aerial (code outline) integration
    require('aerial').on_attach(client, bufnr)
end

map('n', '<leader>rr', '<cmd>lua vim.lsp.buf.document_highlight()<CR>')
map('n', '<leader>rc', '<cmd>lua vim.lsp.buf.clear_references()<CR>')

local status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if not status then
    M.capabilities = {}
else
    M.capabilities = cmp_nvim_lsp.update_capabilities(vim.lsp.protocol.make_client_capabilities())
    M.capabilities.textDocument.completion.completionItem.snippetSupport = false
end

M.handlers = {
    ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' }),
    ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {border = 'rounded' }),
}

return M
