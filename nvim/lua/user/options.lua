vim.o.number = true

vim.o.foldenable = false

vim.o.backspace = 'indent,eol,start'

-- Node / Javascript files lag without this
-- vim.o.re = 0

-- Smoother horizontal and vertical scrolling
vim.o.sidescroll = 4
vim.o.scrolloff = 8

vim.o.smartindent = true
vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.incsearch = true
vim.o.hlsearch = false

vim.o.backup = true
vim.o.backupdir = vim.fn.stdpath('data') .. '/backup//'
--vim.cmd([[
    -- augroup UpdateBackupExt
        -- autocmd!
        -- autocmd BufWritePre * let &bex = strftime('.backup-%Y-%m-%dT%T~')
    -- augroup end
-- ]])

vim.o.ruler = true
vim.o.wrap = false
-- vim.o.colorcolumn = '120'

-- Allows moving cursor with mouse
vim.o.mouse = 'a'

-- Allows for multiple buffers in single view
vim.o.hidden = true

-- Enable this to use clipboard for unnamed register
-- vim.o.clipboard:append('unnamedplus')

-- Side gutter
vim.o.signcolumn = 'auto:2'

-- Show unwanted characters
vim.o.list = true
vim.o.listchars = 'tab:▸ ,trail:·'

vim.o.title = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.splitright = true
vim.o.splitbelow = true

-- Hides VISUAL indicator at bottom when entering visual mode
vim.o.showmode = false

vim.o.termguicolors = true

vim.o.background = 'dark'

vim.o.undofile = true

vim.o.showcmd = false

vim.o.spell = true
vim.o.spelllang = 'en_us'
vim.o.spellsuggest = 'best,9'
