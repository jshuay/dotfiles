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
vim.api.nvim_create_autocmd('BufWritePost', {
    group = vim.api.nvim_create_augroup('PackerUserConfig', { clear = true }),
    pattern = { 'plugins.lua' },
    callback = function()
        vim.cmd('source <afile> | PackerCompile')
    end
})

return packer
