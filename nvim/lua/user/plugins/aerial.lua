local status, aerial = pcall(require, 'aerial')
if not status then
    return
end

aerial.setup({
    default_bindings = false,
    show_guides = true,
    close_behavior = 'close',
    open_automatic = function(bufnr)
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
