local status, rust_tools = pcall(require, 'rust-tools')
if not status then
    return
end

local shared_configs = require('user.plugins.lsp.shared-configs')

rust_tools.setup({
    server = {
        on_attach = shared_configs.on_attach,
        capabilities = shared_configs.capabilities,
        handlers = shared_configs.handlers,
    }
})
