local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer = require('packer')

packer.init({
    display = {
        open_fn = function()
            return require('packer.util').float({ border = 'rounded' })
        end
    },
    auto_clean = true,
    compile_on_sync = true
})

-- Triggers sourcing and recompiling when changes are made to plugins.lua
vim.cmd([[
    augroup PackerUserConfig
        autocmd!
        autocmd BufWritePost plugins.lua source <afile> | PackerCompile
    augroup end
]])

return packer
