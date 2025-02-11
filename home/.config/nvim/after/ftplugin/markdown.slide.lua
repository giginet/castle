vim.api.nvim_create_augroup( 'template', {} )
vim.api.nvim_create_autocmd( 'BufNewFile', {
  group = 'template',
  callback = function()
    vim.cmd(":InsertConfiguration<CR>")
  end
})

