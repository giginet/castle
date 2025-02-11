vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.apns", "*.pif", "Package.resolved", "*.xctestplan", ".swift-format" },
  callback = function()
    vim.cmd("setlocal filetype=json syntax=json")
  end,
})
