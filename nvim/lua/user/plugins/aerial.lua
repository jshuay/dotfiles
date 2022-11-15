local status, aerial = pcall(require, 'aerial')
if not status then
    return
end

aerial.setup({
    backends = { 'lsp', 'treesitter', 'markdown' },
    default_bindings = false,
    show_guides = true,
    close_behavior = 'close',
    filter_kind = {
        "Class",
        "Constant",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
        "Variable"
    },
    open_automatic = function(bufnr)
        -- return aerial.num_symbols(bufnr) > 0
        return aerial.num_symbols(bufnr) > 0 and not aerial.was_closed()
    end
})

local map = require('lib.keymap').keymap

map('n', '<leader>m', '<cmd>AerialToggle<CR>')

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('AerialKeymap', { clear = true }),
    pattern = { 'aerial' },
    callback = function(args)
        local bmap = require('lib.keymap').buf_keymap

        bmap(args.buf, 'n', 'o', '<cmd>lua require("aerial").select()<CR>')
        bmap(args.buf, 'n', 'v', '<cmd>lua require("aerial").select({ split = "v" })<CR>')
        bmap(args.buf, 'n', 's', '<cmd>lua require("aerial").select({ jump = false })<CR>')
        bmap(args.buf, 'n', 'q', '<cmd>AerialClose<CR>')
        bmap(args.buf, 'n', '<2-LeftMouse>', '<cmd>lua require("aerial").select()<CR>')
    end
})

-- Prevents wonky behavior when navigating away from buffer that is not saved.
vim.api.nvim_create_autocmd('QuitPre', {
    group = vim.api.nvim_create_augroup('AerialAutoClose', { clear = true }),
    pattern = { '*' },
    callback = function(args)
        if aerial.is_open(args.buf) then
            aerial.close()
        end
    end
})

