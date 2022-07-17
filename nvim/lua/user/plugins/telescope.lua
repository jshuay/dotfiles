local status, telescope = pcall(require, 'telescope')
if not status then
    return
end

local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')

-- Prevent big files from showing in previewer
local previewers = require('telescope.previewers')
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

local quick_fix_action = function(prompt_bufnr)
    if #action_state.get_current_picker(prompt_bufnr):get_multi_selection() == 0 then
        actions.send_to_qflist(prompt_bufnr)
    else
        actions.send_selected_to_qflist(prompt_bufnr)
    end
    -- actions.open_qflist(prompt_bufnr)
    vim.cmd('belowright copen')
end

local pickers = require('telescope.pickers')
local original_update_prefix = pickers._Picker.update_prefix

pickers._Picker.update_prefix = function(self, entry, row)
    self.stats.jy_current_row = row
    self:get_status_updater(self.prompt_win, self.prompt_bufnr)()
    return original_update_prefix(self, entry, row)
end

local original_reset_track = pickers._Picker._reset_track

pickers._Picker._reset_track = function(self)
    self.stats.jy_current_row = 0
    original_reset_track(self)
end

local get_status_text = function(self)
    local selected = #(self:get_multi_selection())
    local num_results = (self.stats.processed or 0) - (self.stats.filtered or 0)
    local current_index = num_results == 0 and 0 or self:get_index((self.stats.jy_current_row or 0))

    if selected ~= 0 then
        return string.format('(Selected: %s) %s / %s', selected, current_index, num_results)
    end
    return string.format('%s / %s', current_index, num_results)
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
                ['<C-q>'] = quick_fix_action,
            },
            n = {
                ['<C-j>'] = actions.preview_scrolling_down,
                ['<C-k>'] = actions.preview_scrolling_up,
                ['<Tab>'] = actions.toggle_selection,
                ['<C-q>'] = quick_fix_action,
            }

        },
        sorting_strategy = 'ascending',
        scroll_strategy = 'limit',
        layout_strategy = 'vertical',
        layout_config = {
            scroll_speed = 4,
            vertical = {
                height = 0.7,
                preview_cutoff = 1,
                preview_height = 0.65,
                width = 0.7,
                prompt_position = 'top',
                mirror = true
            },
            horizontal = {
                height = 0.7,
                preview_cutoff = 1,
                width = 0.7,
                prompt_position = 'top'
            }
        },
        file_ignore_patterns = { '.git/', '.DS_Store', 'Cargo.lock', 'package%-lock.json' },
        get_status_text = get_status_text
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

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('TelescopeHighlightOverrides', { clear = true }),
    pattern = { 'TelescopePrompt' },
    callback = function()
        vim.api.nvim_set_hl(0, 'TelescopePromptCounter', { fg = '#ebdbb2', ctermfg = 223 })
    end
})

local map = require('lib.keymap').keymap

map('n', '<leader>ff', '<cmd>lua require("telescope.builtin").find_files()<CR>')
map('n', '<leader>fF', '<cmd>lua require("telescope.builtin").find_files({ no_ignore = true, prompt_title = "All Files" })<CR>')

map('n', '<leader>fg', '<cmd>lua require("telescope").extensions.live_grep_args.live_grep_args()<CR>')
-- map('n', '<leader>fg', '<cmd>lua require("telescope.builtin").live_grep()<CR>')

map('n', '<leader>fb', '<cmd>lua require("telescope.builtin").buffers({ initial_mode = "normal" })<CR>')

map('n', '<leader>/', '<cmd>lua require("telescope.builtin").current_buffer_fuzzy_find()<CR>')

map('n', 'gr', '<cmd>lua require("telescope.builtin").lsp_references({ trim_text = true, fname_width = 50 })<CR>')

map('n', '<leader>ss', '<cmd>lua require("telescope.builtin").spell_suggest({ layout_strategy = "cursor", layout_config = { height = 0.4, width = 0.15 }, initial_mode = "normal", prompt_title = "Spell", results_title = "" })<CR>')
