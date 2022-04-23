vim.cmd([[
    augroup YankToSystemClipboard
        autocmd!
        autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '*' | execute 'OSCYankReg "' | endif
    augroup end
]])
