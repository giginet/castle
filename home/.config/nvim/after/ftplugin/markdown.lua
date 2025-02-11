vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.wrap = true
vim.opt_local.conceallevel = 2
vim.keymap.set('n', '<C-x><C-x>', function()
  local current_file = vim.fn.expand('%:p')
  local cmd = '/usr/bin/open -a "Marked 2.app" ' .. vim.fn.shellescape(current_file)
  vim.fn.system(cmd)
end, { buffer = 0, noremap = true, silent = true, desc = 'Open current file in Marked 2' })
