vim.g.oscyank_max_length = 100000
vim.g.oscyank_silent = true

vim.cmd([[
    augroup YankToSystemClipboard
        autocmd!
        autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '*' | execute 'OSCYankReg "' | endif
    augroup end
]])
