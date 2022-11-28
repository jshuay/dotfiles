local status, gitsigns = pcall(require, 'gitsigns')
if not status then
    return
end

gitsigns.setup({
    sign_priority = 9,
})
