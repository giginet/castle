vim.cmd('filetype on')
vim.opt_local.cindent = true

-- インデント設定
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true
vim.opt_local.shiftround = true

vim.opt_local.modelines = 0

vim.opt.path:append('lib')