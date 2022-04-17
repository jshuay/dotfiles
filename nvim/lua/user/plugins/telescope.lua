local telescope = require('telescope')

local actions = require('telescope.actions')

-- Prevent big files from showing in previewer
local previewers = require("telescope.previewers")
local preview_maker = function(filepath, bufnr, opts)
    opts = opts or {}

    filepath = vim.fn.expand(filepath)
    vim.loop.fs_stat(filepath, function(_, stat)
        if not stat then
            return
        end
        if stat.size > 100000 then
            return
        else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
        end
    end)
end

telescope.setup({
    defaults = {
        path_display = { truncate = 1 },
        buffer_previewer_maker = preview_maker,
        mappings = {
            i = {
                ['<Tab>'] = actions.move_selection_next,
                ['<S-Tab>'] = actions.move_selection_previous,
                ['<C-j>'] = actions.preview_scrolling_down,
                ['<C-k>'] = actions.preview_scrolling_up,
            },
            n = {
                ['<C-j>'] = actions.preview_scrolling_down,
                ['<C-k>'] = actions.preview_scrolling_up,
            }

        },
        sorting_strategy = 'ascending',
        scroll_strategy = 'limit',
        layout_strategy = 'vertical',
        layout_config = {
            scroll_speed = 4,
            vertical = {
                height = 0.9,
                preview_cutoff = 1,
                preview_height = 0.65,
                width = 0.9,
                prompt_position = 'top',
                mirror = true
            },
            horizontal = {
                height = 0.9,
                preview_cutoff = 1,
                width = 0.9,
                prompt_position = 'top'
            }
        },
        file_ignore_patterns = { '.git/', '.DS_Store', 'Cargo.lock', 'package%-lock.json' }
    },
    pickers = {
        find_files = {
            hidden = true
        },
        lsp_references = {
            initial_mode = 'normal'
        }
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = 'smart_case'
        }
    }
})

-- telescope.load_extension('fzf')

local map = require('lib.keymap').keymap

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>')
map('n', '<leader>fF', '<cmd>lua require("telescope.builtin").find_files({ no_ignore = true, prompt_title = "All Files" })<CR>')

map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>')

map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers()<CR>')

map('n', '<leader>/', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>')

map('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>')
