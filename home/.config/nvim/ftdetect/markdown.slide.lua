vim.filetype.add({
  pattern = {
    ['*/slide/*.md'] = { ft = 'markdown.slide', syntax = 'markdown' },
  },
})