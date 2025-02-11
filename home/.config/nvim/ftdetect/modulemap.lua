vim.filetype.add({
  extension = {
    modulemap = { ft = 'modulemap', syntax = 'modulemap' },
  },
})

-- Set shiftwidth for modulemap files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "modulemap",
  callback = function()
    vim.bo.shiftwidth = 4
  end,
})