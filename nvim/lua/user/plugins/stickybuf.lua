local status, stickybuf = pcall(require, 'stickybuf')
if not status then
    return
end

stickybuf.setup({})
