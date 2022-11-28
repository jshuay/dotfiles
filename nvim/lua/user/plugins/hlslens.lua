local hlslens_status, _ = pcall(require, 'hlslens')
if not hlslens_status then
    return
end

local scrollbar_search_status, scrollbar_search = pcall(require, 'scrollbar.handlers.search')
if not scrollbar_search_status then
    return
end

vim.o.hlsearch = true

-- hlslens.setup()

local map = require('lib.keymap').keymap

map('n', 'n', "<cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>")
map('n', 'N', "<cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>")
map('n', '*', "*<cmd>lua require('hlslens').start()<CR>")
map('n', '#', "#<cmd>lua require('hlslens').start()<CR>")
map('n', 'g*', "g*<cmd>lua require('hlslens').start()<CR>")
map('n', 'g#', "g#<cmd>lua require('hlslens').start()<CR>")

-- For some reason, using '<cmd>' causes the clear to be delayed. Explicitly
-- using ':' makes it clear immediately.
map('n', '<leader>c/', ":noh<CR>")

-- Integration with scrollbar
scrollbar_search.setup({
    -- calm_down = true,
    nearest_float_when = 'never',
    override_lens = function(render, posList, nearest, idx, _)
        if nearest then
            local line_number, column = unpack(posList[idx])
            local total_count = #posList
            local text = ('[%d/%d]'):format(idx, total_count)
            local chunks = { { ' ', 'ScrollbarSearchCustom' }, { text, 'ScrollbarSearchCustom' } }
            render.setVirt(0, line_number - 1, column - 1, chunks, nearest)
        end
    end
})
