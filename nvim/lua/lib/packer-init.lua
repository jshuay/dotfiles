local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    })
    print('Installing packer close and reopen Neovim...')
    vim.cmd([[ packadd packer.nvim ]])
end

local status, packer = pcall(require, 'packer')
if not status then
    return
end

packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end
    },
    auto_clean = true,
    compile_on_sync = true
})

-- Triggers sourcing and resyncing when changes are made to plugins.lua
vim.cmd([[
    augroup PackerUserConfig
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

return packer
