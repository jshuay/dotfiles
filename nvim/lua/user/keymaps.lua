local map = require('lib.keymap').keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

map('n', '<leader><CR>', ':source ~/.config/nvim/init.lua<CR>')

map('', '<ScrollWheelUp>', 'k')
map('', '<ScrollWheelDown>', 'j')
map('i', '<ScrollWheelUp>', '<Up>')
map('i', '<ScrollWheelDown>', '<Down>')

-- shortcuts for copy
map('v', '<leader>c', '"*y')
map('v', '<RightMouse>', '"*y')

-- move between windows
map('n', '<leader>h', '<C-w><C-h>')
map('n', '<leader>l', '<C-w><C-l>')
map('n', '<leader>j', '<C-w><C-j>')
map('n', '<leader>k', '<C-w><C-k>')

-- resize windows
map('n', '<C-Up>', ':vertical resize +5<CR>')
map('n', '<C-Down>', ':vertical resize -5<CR>')
map('n', '<C-Right>', ':resize +5<CR>')
map('n', '<C-Left>', ':resize -5<CR>')

-- toggle between last 2 buffers
map('n', '<leader><leader>', '<C-^>')

-- allow go to files that do not exist
map('', 'gf', ':edit <cfile><CR>')

-- reselect after indenting
map('v', '<Tab>', '>gv')
map('v', '<S-Tab>', '<gv')

-- disable keybinding for Ex mode
map('n', 'Q', '<Nop>')

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
map('v', 'y', 'myy`y')
map('v', 'Y', 'myY`y')

