local template_root = vim.fn.stdpath('config') .. '/templates'

vim.opt['tabstop'] = 2
vim.opt['shiftwidth'] = 2
vim.opt['expandtab'] = true

vim.api.nvim_create_augroup( 'template', {} )
vim.api.nvim_create_autocmd( 'BufNewFile', {
  group = 'template',
  callback = function()
    local template_path = template_root .. '/' .. "sh.sh"
    vim.cmd(":0r " .. template_path)
  end
})


