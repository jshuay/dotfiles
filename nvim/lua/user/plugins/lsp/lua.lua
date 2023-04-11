local shared_configs = require('user.plugins.lsp.shared-configs')

return {
    server = 'lua_ls',
    opts = {
        on_attach = shared_configs.on_attach,
        capabilities = shared_configs.capabilities,
        handlers = shared_configs.handlers,
        settings = {
            Lua = {
                diagnostics = {
                    -- Let LSP know about vim global variable
                    globals = { 'vim' }
                },
                telemetry = {
                    enabled = false
                }
            }
        }
    }
}
