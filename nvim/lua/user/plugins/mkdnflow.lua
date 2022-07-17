local status, mkdnflow = pcall(require, 'mkdnflow')
if not status then
    return
end

local link_name = function(text)
    text = text:gsub(' ', '-'):lower()
    local date = os.date('%Y-%m-%d')
    if text ~= nil and text ~= '' then
        return string.format('%s-%s', date, text)
    end
    return date
end

mkdnflow.setup({
    use_mappings_table = false,
    silent = true,
    links = {
        conceal = true,
        transform_explicit = link_name
    },
    perspective = {
        priority = 'root',
        fallback = 'current',
        root_tell = 'index.md'
    }
})

local mkdnflow_links = require('mkdnflow.links')
local original_create_links = mkdnflow_links.createLink
mkdnflow_links.createLink = function()
    local line = vim.api.nvim_get_current_line()
    if line == nil or line == '' then
        local line_num = vim.api.nvim_win_get_cursor(0)[1]
        local date = os.date('%Y-%m-%d')
        vim.api.nvim_buf_set_lines(0, line_num - 1, line_num, true, { string.format('[%s](%s.md)', date, date) })
        return
    end
    return original_create_links()
end

MKDNFLOW_O_OVERRIDE = function()
    local line_num = vim.api.nvim_win_get_cursor(0)[1]
    if line_num == 1 then
        vim.api.nvim_feedkeys('O', 'n', true)
        return
    end
    local keys = vim.api.nvim_replace_termcodes('k<cmd>MkdnExtendList<CR>A', true, false, true)
    vim.api.nvim_feedkeys(keys, 'n', true)
end

vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('mkdnflowOverrides', { clear = true }),
    pattern = { 'markdown' },
    callback = function(args)
        local bmap = require('lib.keymap').buf_keymap

        bmap(args.buf, 'n', '<leader>v', '^v$')

        bmap(args.buf, 'n', '<CR>', '<cmd>MkdnFollowLink<CR>')
        bmap(args.buf, 'v', '<CR>', '<cmd>MkdnFollowLink<CR><Esc>')
        bmap(args.buf, 'n', '<BS>', '<cmd>MkdnGoBack<CR>')

        bmap(args.buf, 'n', '<Del>', '<cmd>MkdnDestroyLink<CR>')

        bmap(args.buf, 'n', '-', '<cmd>MkdnIncreaseHeading<CR>')
        bmap(args.buf, 'n', '=', '<cmd>MkdnDecreaseHeading<CR>')

        bmap(args.buf, 'n', '<C-Space>', '<cmd>MkdnToggleToDo<CR>')
        bmap(args.buf, 'i', '<CR>', '<cmd>MkdnNewListItem<CR>')
        bmap(args.buf, 'i', '<Tab>', '<C-t><cmd>silent! MkdnUpdateNumbering<CR>')
        bmap(args.buf, 'i', '<S-Tab>', '<C-d><cmd>silent! MkdnUpdateNumbering<CR>')
        bmap(args.buf, 'n', 'o', '<cmd>MkdnExtendList<CR>A')
        bmap(args.buf, 'n', 'O', '<cmd>lua MKDNFLOW_O_OVERRIDE()<CR>')
        bmap(args.buf, 'n', 'dd', 'dd<cmd>silent! MkdnUpdateNumbering<CR>')
        bmap(args.buf, 'n', 'p', 'p<cmd>silent! MkdnUpdateNumbering<CR>')
        bmap(args.buf, 'n', 'P', 'P<cmd>silent! MkdnUpdateNumbering<CR>')
    end
})
