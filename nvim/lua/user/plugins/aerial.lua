local status, aerial = pcall(require, 'aerial')
if not status then
    return
end

aerial.setup({
    backends = { 'lsp', 'treesitter', 'markdown' },
    show_guides = true,
    close_automatic_events = { "switch_buffer" },
    filter_kind = {
        "Class",
        "Constant",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
        "Variable"
    },
    keymaps = {
        ["?"] = false,
        ["g?"] = false,
        ["<CR>"] = false,
        ["<2-LeftMouse>"] = false,
        ["<C-v>"] = false,
        ["<C-s>"] = false,
        ["p"] = false,
        ["<C-j>"] = false,
        ["<C-k>"] = false,
        ["{"] = false,
        ["}"] = false,
        ["[["] = false,
        ["]]"] = false,
        ["q"] = false,
        ["o"] = false,
        ["za"] = false,
        ["O"] = false,
        ["zA"] = false,
        ["l"] = false,
        ["zo"] = false,
        ["L"] = false,
        ["zO"] = false,
        ["h"] = false,
        ["zc"] = false,
        ["H"] = false,
        ["zC"] = false,
        ["zr"] = false,
        ["zR"] = false,
        ["zm"] = false,
        ["zM"] = false,
        ["zx"] = false,
        ["zX"] = false
    },
    -- open_automatic = function(bufnr)
    --     -- return aerial.num_symbols(bufnr) > 0
    --     return aerial.num_symbols(bufnr) > 0 and not aerial.was_closed()
    -- end
})

local map = require('lib.keymap').keymap

map('n', '<leader>m', '<cmd>AerialToggle<CR>')

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('AerialKeymap', { clear = true }),
    pattern = { 'aerial' },
    callback = function(args)
        local bmap = require('lib.keymap').buf_keymap

        bmap(args.buf, 'n', 'o', '<cmd>lua require("aerial").select()<CR>')
        bmap(args.buf, 'n', 'v', '<cmd>lua require("aerial").select({ split = "v" })<CR>')
        bmap(args.buf, 'n', 's', '<cmd>lua require("aerial").select({ jump = false })<CR>')
        bmap(args.buf, 'n', 'q', '<cmd>AerialClose<CR>')
        bmap(args.buf, 'n', '<2-LeftMouse>', '<cmd>lua require("aerial").select()<CR>')
    end
})

-- Prevents wonky behavior when navigating away from buffer that is not saved.
vim.api.nvim_create_autocmd('QuitPre', {
    group = vim.api.nvim_create_augroup('AerialAutoClose', { clear = true }),
    pattern = { '*' },
    callback = function(args)
        if aerial.is_open({
            bufnr = args.buf
        }) then
            aerial.close()
        end
    end
})

