require('lualine').setup()

local buffer_info = function()
    local buffer_count = 0
    local bufs = vim.api.nvim_list_bufs()
    for _, buf in pairs(bufs) do
        if vim.api.nvim_buf_get_option(buf, 'buflisted') then
            buffer_count = buffer_count + 1
        end
    end
    return buffer_count
end

local git_blame = require('gitblame')
local git_blame_msg = function()
    local msg = git_blame.get_current_blame_text()
    if string.len(msg) <= 47 then
        return msg
    end
    return string.sub(msg, 1, 47) .. '...'
end
local git_blame_cond = function()
    return vim.g.gitblame_enabled == 1 and git_blame.is_blame_text_available() and
        git_blame.get_current_blame_text() ~= '  Not Committed Yet'
end

require('lualine').setup {
    options = {
        disabled_filetypes = { 'NvimTree' }
    },
    sections = {
        lualine_a = {
            'mode',
        },
        lualine_b = {
            'branch',
            'diff',
            -- '"LSP " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
            { 'diagnostics', sources = { 'nvim_diagnostic' } },
        },
        lualine_c = {
            { 'filename', path = 1 }
        },
        lualine_x = {
            -- 'fileformat',
            { git_blame_msg, cond = git_blame_cond }
        },
        lualine_y = {
            'filetype'
            -- 'encoding',
        },
        lualine_z = {
            { buffer_info },
            'location',
            'progress',
        },
    },
}

