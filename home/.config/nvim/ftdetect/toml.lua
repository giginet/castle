vim.filetype.add({
  extension = {
    toml = { ft = 'toml', syntax = 'toml' },
  },
  filename = {
    ['Pipfile'] = 'toml',
    ['pylintrc'] = 'toml',
    ['.pylintrc'] = 'toml',
  },
})
