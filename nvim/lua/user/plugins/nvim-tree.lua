local status, nvim_tree = pcall(require, 'nvim-tree')
if not status then
    return
end

local tree_cb = require('nvim-tree.config').nvim_tree_callback

nvim_tree.setup({
    git = { ignore = false },
    view = {
        width = 50,
        mappings = {
            custom_only = false,
            list = {
                { key = 'v', cb = tree_cb('vsplit') }
            }
        }
    },
    actions = {
        open_file = {
            -- quit_on_open = true,
            resize_window = true
        }
    },
    renderer = {
        indent_markers = {
            enable = true
        },
        highlight_opened_files = 'all',
        group_empty = false,
        -- For Windows, download a font from Nerd Fonts
        -- https://github.com/kyazdani42/nvim-web-devicons/issues/76#issuecomment-998656272
        icons = {
            show = {
                git = true,
                folder = true,
                file = true,
                folder_arrow = true
            },
            glyphs = {
                default = '',
                symlink = '',
                git = {
                    unstaged = 'ﱤ',
                    staged = 'ﱣ',
                    unmerged = '',
                    renamed = '➜',
                    deleted = '',
                    untracked = '◌',
                    ignored = ''
                },
                folder = {
                    default = '',
                    open = '',
                    empty = '',
                    empty_open = '',
                    symlink = '',
                }
            }
        }
    },
    filters = {
        custom = {
        }
    }
})

local map = require('lib.keymap').keymap

map('n', '<leader>n', ':NvimTreeFindFileToggle<CR>:NvimTreeResize 50<CR>')

vim.cmd([[
    augroup NvimTreeKeymap
        autocmd!
        autocmd FileType NvimTree nmap <silent><buffer> <leader><leader> :NvimTreeFindFileToggle<CR>
        autocmd FileType NvimTree nmap <silent><buffer> <leader>cd <C-]>
    augroup end
]])
