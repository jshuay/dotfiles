-- For Windows, download a font from Nerd Fonts
-- https://github.com/kyazdani42/nvim-web-devicons/issues/76#issuecomment-998656272
--
vim.g.nvim_tree_highlight_opened_files = 1
-- vim.g.nvim_tree_group_empty = 1

vim.g.nvim_tree_icons = {
    default = "",
    symlink = "",
    git = {
        unstaged = "ﱤ",
        staged = "ﱣ",
        unmerged = "",
        renamed = "➜",
        deleted = "",
        untracked = "◌",
        ignored = ""
    },
    folder = {
        default = "",
        open = "",
        empty = "",
        empty_open = "",
        symlink = "",
    },
}

vim.g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1,
    folder_arrows = 1
}

local tree_cb = require('nvim-tree.config').nvim_tree_callback

require('nvim-tree').setup({
    git = { ignore = false },
    view = {
        mappings = {
            custom_only = false,
            list = {
                { key = 'v', cb = tree_cb('vsplit') }
            }
        }
    },
    actions = {
        open_file = {
            quit_on_open = true,
            resize_window = true
        }
    },
    renderer = {
        indent_markers = {
            enable = true
        }
    },
    filters = {
        custom = {
        }
    }
})

local map = require('lib.keymap').keymap

map('n', '<leader>n', ':NvimTreeFindFileToggle<CR>:NvimTreeResize 35<CR>')

vim.cmd([[
    augroup NvimTreeKeymap
        autocmd!
        autocmd FileType NvimTree nmap <silent><buffer> <leader><leader> :NvimTreeFindFileToggle<CR>:NvimTreeResize 35<CR>
        autocmd FileType NvimTree nmap <silent><buffer> <leader>cd <C-]>
    augroup end
]])
