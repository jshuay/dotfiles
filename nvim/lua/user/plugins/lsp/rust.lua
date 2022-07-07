local shared_configs = require('user.plugins.lsp.shared-configs')

return {
    server = 'rust_analyzer',
    opts = {
        on_attach = shared_configs.on_attach,
        capabilities = shared_configs.capabilities,
        handlers = shared_configs.handlers,
        settings = {
            ['rust-analyzer'] = {
                assist = {
                    importGranularity = 'module',
                    importPrefix = 'self'
                },
                cargo = {
                    loadOutDirsFromCheck = true
                },
                procMacro = {
                    enable = true
                }
            }
        }
    }
}
