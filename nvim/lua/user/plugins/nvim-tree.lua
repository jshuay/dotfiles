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
        add_trailing = true,
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
                    unstaged = '',
                    staged = 'ﰂ',
                    unmerged = '',
                    renamed = '➜',
                    deleted = '',
                    untracked = '⬚',
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

map('n', '<leader>n', '<cmd>NvimTreeFindFileToggle<CR>:NvimTreeResize 50<CR>')

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('NvimTreeKeymap', { clear = true }),
    pattern = { 'NvimTree' },
    callback = function(args)
        local bmap = require('lib.keymap').buf_keymap

        bmap(args.buf, 'n', '<leader><leader>', '<cmd>NvimTreeFindFileToggle<CR>')
        bmap(args.buf, 'n', '<leader>cd', '<C-]>', { noremap = false })
    end
})

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('NvimTreeHighlightOverrides', { clear = true }),
    pattern = { 'NvimTree' },
    callback = function()
        vim.api.nvim_set_hl(0, 'NvimTreeExecFile', { fg = '#ebdbb2', ctermfg = 223 })
        vim.api.nvim_set_hl(0, 'NvimTreeSpecialFile', { fg = '#ebdbb2', ctermfg = 223 })
        vim.api.nvim_set_hl(0, 'NvimTreeOpenedFile', { fg = '#fabd2f', ctermfg = 214 })
    end
})
