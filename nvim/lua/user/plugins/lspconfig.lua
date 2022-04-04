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
                return string.format("%s: %s", diagnostic.user_data.lsp.code, diagnostic.message)
            end
            return diagnostic.message
        end
    }
})

local shared_configs = require('user.plugins.lsp.shared-configs')

local opts = {
    default = {
        on_attach = shared_configs.on_attach,
        capabilities = shared_configs.capabilities
    }
}

local lua = require('user.plugins.lsp.lua')
opts[lua.server] = lua.opts

local rust = require('user.plugins.lsp.rust')
opts[rust.server] = rust.opts

-- TODO: Remove this in neovim 0.7.0+
for _,opt in pairs(opts) do
    if opt.flags == nil then
        opt.flags = {}
    end
    -- This will be default in neovim 0.7.0+
    opt.flags.debounce_text_changes = 150
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
    if opts[server.name] then
        server:setup(opts[server.name])
        return
    end
    server:setup(opts.default)
end)
