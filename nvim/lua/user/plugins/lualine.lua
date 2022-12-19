local lualine_status, lualine = pcall(require, 'lualine')
if not lualine_status then
    return
end

lualine.setup()

local filename = function()
    local file_name = FILENAME();
    if file_name == '' then
        file_name = '[No Name]'
    end
    if vim.bo.modified then
        file_name = file_name .. ' ' .. '[+]'
    end
    if vim.bo.modifiable == false or vim.bo.readonly == true then
        file_name = file_name .. ' ' .. '[-]'
    end
    return file_name
end

local buffer_info = function()
    local buffer_count = 0
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in pairs(bufs) do
        if vim.api.nvim_buf_get_option(buf, 'buflisted') then
            buffer_count = buffer_count + 1
        end
    end
    return buffer_count .. ' B'
end

-- local gitblame_status, gitblame = pcall(require, 'gitblame')

-- local git_blame_msg = '';
-- local git_blame_cond = false;
-- if gitblame_status then
--     git_blame_msg = function()
--         local msg = gitblame.get_current_blame_text()
--         if string.len(msg) <= 47 then
--             return msg
--         end
--         return string.sub(msg, 1, 47) .. '...'
--     end
--     git_blame_cond = function()
--         return vim.g.gitblame_enabled == 1 and gitblame.is_blame_text_available() and
--             gitblame.get_current_blame_text() ~= '  Not Committed Yet'
--     end
-- end

local col_location = function()
    return vim.fn.col('.') .. ':' .. vim.fn.col('$') .. ' C'
end

local line_location = function()
    return vim.fn.line('.') .. ':' .. vim.fn.line('$') .. ' L'
end

local diagnostics_symbols = require('user.diagnostics_symbols')

lualine.setup ({
    options = {
        disabled_filetypes = { 'NvimTree', 'aerial' }
    },
    sections = {
        lualine_a = {
            'mode',
        },
        lualine_b = {
            'branch',
            'diff',
            -- '"LSP " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
            {
                'diagnostics',
                sources = { 'nvim_diagnostic' },
                symbols = {
                    error = diagnostics_symbols.ERROR,
                    warn = diagnostics_symbols.WARN,
                    info = diagnostics_symbols.INFO,
                    hint = diagnostics_symbols.HINT,
                }
            },
        },
        lualine_c = {
            { filename }
        },
        lualine_x = {
            -- 'fileformat',
            -- { git_blame_msg, cond = git_blame_cond }
        },
        lualine_y = {
            'filetype'
            -- 'encoding',
        },
        lualine_z = {
            { buffer_info },
            { col_location },
            { line_location },
            -- 'location',
            'progress',
        },
    },
})

