local lsp_installer_status, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not lsp_installer_status then
    return
end

local lspconfig_status, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status then
    return
end

local map = require('lib.keymap').keymap

map('n', '<leader>dd', ':lua vim.diagnostic.open_float()<CR>')
map('n', '<leader>dD', ':lua vim.diagnostic.setloclist()<CR>')

vim.fn.sign_define('DiagnosticSignError', { text = '', texthl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn', { text = '', texthl = 'DiagnosticSignWarn' })
vim.fn.sign_define('DiagnosticSignInfo', { text = '', texthl = 'DiagnosticSignInfo' })
vim.fn.sign_define('DiagnosticSignHint', { text = '', texthl = 'DiagnosticSignHint' })

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

lsp_installer.setup({
    -- automatic_installation = true
})

for server,opts in pairs(servers) do
    lspconfig[server].setup({
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        settings = opts.settings,
        flags = {
            -- This will be default in neovim 0.7.0+
            debounce_text_changes = 150
        }
    })
end

-- lsp_installer.on_server_ready(function(server)
--     if opts[server.name] then
--         server:setup(opts[server.name])
--         return
--     end
--     server:setup(opts.default)
-- end)
