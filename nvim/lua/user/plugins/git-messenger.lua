vim.g.git_messenger_no_default_mappings = true
-- vim.g.git_messenger_include_diff = 'current'
vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_floating_win_opts = { border = 'rounded' }
vim.g.git_messenger_popup_content_margins = false

local map = require('lib.keymap').keymap

map('n', '<leader>gb', '<Plug>(git-messenger)', { noremap = false })

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('GitMessengerOverrides', { clear = true }),
    pattern = { 'gitmessengerpopup' },
    callback = function(args)
        vim.wo.concealcursor = 'nv'
        local bmap = require('lib.keymap').buf_keymap
        bmap(args.buf, 'n', '<esc>', 'q', { noremap = false })
        bmap(args.buf, 'n', 'i', 'O', { noremap = false })
        vim.api.nvim_set_hl(0, 'gitmessengerEmail', { fg = '#fabd2f', ctermfg = 214 })
    end
})
