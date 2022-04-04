vim.g.fzf_layout = {
    up = '~90%',
    window = {
        width = 0.8,
        height = 0.8,
        yoffset = 0.5,
        xoffset = 0.5,
    }
}

vim.env.FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'

-- Use ripgrep for Files command, which respects .gitignore files
-- TODO: replace with vim.api.nvim_add_user_command once neovim 0.7.0+ is stable
vim.cmd([[
    command! -bang -nargs=? -complete=dir Files
    \ call fzf#run(fzf#wrap('files', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden' }), <bang>0))
]])

-- Add AllFiles varation that includes .gitignore files
-- TODO: replace with vim.api.nvim_add_user_command once neovim 0.7.0+ is stable
vim.cmd([[
    command! -bang -nargs=? -complete=dir AllFiles
    \ call fzf#run(fzf#wrap('allfiles', fzf#vim#with_preview({ 'dir': <q-args>, 'sink': 'e', 'source': 'rg --files --hidden --no-ignore' }), <bang>0))
]])

local map = require('lib.keymap').keymap

map('n', '<leader>ff', ':Files<CR>')
map('n', '<leader>fF', ':AllFiles<CR>')

map('n', '<leader>fg', ':Rg<CR>')
map('n', '<leader>fG', ':Rg<space>')

map('n', '<leader>fb', ':Buffers<CR>')
