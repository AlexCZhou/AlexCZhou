-- vim setting
vim.opt.number = true

vim.opt.autoindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.shiftround = true

vim.opt.laststatus = 2
vim.opt.hidden = true
vim.opt.backspace = "indent,eol,start"
vim.opt.display = "lastline"
vim.opt.statusline = ""

vim.opt.signcolumn = "yes" -- for lsp

-- GUI
vim.opt.guifont = "JetBrainsMonoNL Nerd Font Mono:h11"


-- highlight on yank
-- highlight yanked text for 200ms using the "Visual" highlight group
vim.cmd[[
    augroup highlight_yank
    autocmd!
    au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Visual", timeout=200})
    augroup END
]]

