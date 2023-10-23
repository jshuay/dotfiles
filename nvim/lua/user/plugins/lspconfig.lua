local mason_status, mason = pcall(require, 'mason')
if not mason_status then
    return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not mason_lspconfig_status then
    return
end

local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then
    return
end

mason.setup({})
mason_lspconfig.setup({})

local map = require('lib.keymap').keymap

map('n', '<leader>dd', ':lua vim.diagnostic.open_float()<CR>')
map('n', '<leader>dD', ':lua vim.diagnostic.setloclist()<CR>')

local diagnostics_symbols = require('user.diagnostics_symbols')

vim.fn.sign_define('DiagnosticSignError', { text = diagnostics_symbols.ERROR, texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = diagnostics_symbols.WARN, texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = diagnostics_symbols.INFO, texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = diagnostics_symbols.HINT, texthl = 'DiagnosticSignHint' })

vim.diagnostic.config({
    severity_sort = true,
    float = {
        source = true,
        focus = false,
        border = 'rounded',
        format = function(diagnostic)
            if diagnostic.user_data ~= nil and diagnostic.user_data.lsp.code ~= nil then
                return string.format('%s: %s', diagnostic.user_data.lsp.code, diagnostic.message)
            end
            return diagnostic.message
        end
    }
})

local servers = {}

local lua = require('user.plugins.lsp.lua')
servers[lua.server] = lua.opts

local rust = require('user.plugins.lsp.rust')
servers[rust.server] = rust.opts

local typescript = require('user.plugins.lsp.typescript')
servers[typescript.server] = typescript.opts

local json = require('user.plugins.lsp.json')
servers[json.server] = json.opts

local sh = require('user.plugins.lsp.sh')
servers[sh.server] = sh.opts

local python = require('user.plugins.lsp.python')
servers[python.server] = python.opts

local perl = require('user.plugins.lsp.perl')
servers[perl.server] = perl.opts

local html = require('user.plugins.lsp.html')
servers[html.server] = html.opts

local css = require('user.plugins.lsp.css')
servers[css.server] = css.opts

for server,opts in pairs(servers) do
    lspconfig[server].setup({
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        settings = opts.settings,
        -- flags = {
        --     -- This will be default in neovim 0.7.0+
        --     debounce_text_changes = 150
        -- },
        handlers = opts.handlers
    })
end

