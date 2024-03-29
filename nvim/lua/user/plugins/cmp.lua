local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then
    return
end

local select_next_item = cmp.mapping(
    function(fallback)
        if cmp.visible() then
            cmp.select_next_item()
            return
        end
        fallback()
    end,
    { 'i', 's' }
)
local select_prev_item = cmp.mapping(
    function(fallback)
        if cmp.visible() then
            cmp.select_prev_item()
            return
        end
        fallback()
    end,
    { 'i', 's' }
)

SHOW_CMP = function()
    if cmp.visible() then
        cmp.abort()
        return
    end
    cmp.complete()
end

cmp.setup({
    experimental = {
        ghost_text = true
    },
    completion = {
        completeopt = 'menuone,longest,preview,noselect'
    },
    preselect = cmp.PreselectMode.None,
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
        ['<Tab>'] = select_next_item,
        ['<Down>'] = select_next_item,
        ['<S-Tab>'] = select_prev_item,
        ['<Up>'] = select_prev_item,
        ['<C-j>'] = cmp.mapping.scroll_docs(4),
        ['<C-Down>'] = cmp.mapping.scroll_docs(4),
        ['<C-k>'] = cmp.mapping.scroll_docs(-4),
        ['<C-Up>'] = cmp.mapping.scroll_docs(-4),
        ['<C-Space>'] = cmp.mapping(SHOW_CMP, { 'i', 'c' }),
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = false
        }),
        ['<C-u>'] = cmp.mapping.abort()
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
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
