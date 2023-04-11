vim.g.oscyank_max_length = 100000
vim.g.oscyank_silent = true

vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('YankToSystemClipboard', { clear = true }),
    pattern = { '*' },
    callback = function()
        if vim.v.event.operator == 'y' and vim.v.event.regname == '*' then
            vim.fn.execute('OSCYankRegister "')
        end
    end
})
