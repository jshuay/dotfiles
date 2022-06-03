local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then
    return
end

cmp.setup({
    experimental = {
        ghost_text = true
    },
    completion = {
        -- Set completeopt to have a better completion experience
        completeopt = 'menuone,longest,preview'
    },
    formatting = {
        -- fields = { 'abbr', 'kind' },
        format = require('lspkind').cmp_format({
            with_text = true,
            menu = {
                nvim_lsp = '[Lsp]',
                nvim_lua = '[Nvim]',
                buffer = '[Buffer]',
                path = '[Path]',
                luasnip = '[Snip]'
            }
        })
    },
    snippet = {
        expand = function(args)
            local luasnip_status, luasnip = pcall(require, 'luasnip')
            if not luasnip_status then
                return
            end
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = {
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
                return
            end
            fallback()
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
                return
            end
            fallback()
        end, { 'i', 's' }),
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-Space>'] = cmp.mapping(function()
            if cmp.visible() then
                cmp.abort()
                return
            end
            cmp.complete()
        end, { 'i', 'c' }),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        })
    },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'nvim_lua' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'luasnip' }
    })
})
