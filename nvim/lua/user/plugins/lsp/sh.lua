local shared_configs = require('user.plugins.lsp.shared-configs')

return {
    server = 'bashls',
    opts = {
        on_attach = shared_configs.on_attach,
        capabilities = shared_configs.capabilities,
        handlers = shared_configs.handlers
    }
}
