local status, scrollbar = pcall(require, 'scrollbar')
if not status then
    return
end

local diagnostics_symbols = require('user.diagnostics_symbols')

scrollbar.setup({
    excluded_filetypes = {
        'prompt',
        'TelescopePrompt',
        'NvimTree',
        'aerial'
    },
    excluded_buftypes = {
        'terminal',
        'nofile'
    },
    handle = {
        highlight = 'ScrollbarHandleCustom'
    },
    marks = {
        Cursor = {
            text = '|',
            color = '#fabd2f',
            highlight = 'ScrollbarCursorCustom'
        },
        Search = {
            text = { '', '' },
            highlight = 'ScrollbarSearchCustom'
        },
        Error = {
            text = { diagnostics_symbols.ERROR, diagnostics_symbols.ERROR },
        },
        Warn = {
            text = { diagnostics_symbols.WARN, diagnostics_symbols.WARN },
        },
        Info = {
            text = { diagnostics_symbols.INFO, diagnostics_symbols.INFO },
        },
        Hint = {
            text = { diagnostics_symbols.HINT, diagnostics_symbols.HINT },
        },
        GitAdd = {
        },
        GitChange = {
        },
        GitDelete = {
        },
    },
    handlers = {
        gitsigns = true,
        search = true
    }
})

require("scrollbar.handlers.gitsigns").setup({})
