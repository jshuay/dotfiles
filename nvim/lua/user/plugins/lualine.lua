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

