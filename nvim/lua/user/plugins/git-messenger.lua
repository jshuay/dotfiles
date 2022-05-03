vim.g.git_messenger_no_default_mappings = true
-- vim.g.git_messenger_include_diff = 'current'
vim.g.git_messenger_always_into_popup = true
vim.g.git_messenger_floating_win_opts = { border = 'rounded' }
vim.g.git_messenger_popup_content_margins = false

local map = require('lib.keymap').keymap

map('n', '<leader>gb', '<Plug>(git-messenger)', { noremap = false })

vim.cmd([[
    augroup GitMessengerOverrides
        autocmd!
        autocmd FileType gitmessengerpopup set concealcursor=nv
        autocmd FileType gitmessengerpopup nmap <buffer> <esc> q
        autocmd FileType gitmessengerpopup nmap <buffer> i O
        autocmd FileType gitmessengerpopup hi gitmessengerEmail ctermfg=214 guifg=#fabd2f
    augroup end
]])
