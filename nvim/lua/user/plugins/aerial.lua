local status, aerial = pcall(require, 'aerial')
if not status then
    return
end

aerial.setup({
    default_bindings = false,
    show_guides = true,
    open_automatic = true
})

local map = require('lib.keymap').keymap

map('n', '<leader>m', '<cmd>AerialToggle<CR>')

vim.cmd([[
    augroup AerialKeymap
        autocmd!
        autocmd FileType aerial nmap <silent><buffer> o :lua require('aerial').select()<CR>
        autocmd FileType aerial nmap <silent><buffer> v :lua require('aerial').select({ split = 'v' })<CR>
        autocmd FileType aerial nmap <silent><buffer> s :lua require('aerial').select({ jump = false })<CR>
        autocmd FileType aerial nmap <silent><buffer> q :AerialClose<CR>
        autocmd FileType aerial nmap <silent><buffer> <2-LeftMouse> :lua require('aerial').select()<CR>
    augroup end
]])
