vim.filetype.add({
  extension = {
    toml = { ft = 'toml', syntax = 'toml' },
  },
  filename = {
    ['Pipfile'] = { ft = 'toml', syntax = 'toml' },
    ['pylintrc'] = { ft = 'toml', syntax = 'toml' },
    ['.pylintrc'] = { ft = 'toml', syntax = 'toml' },
  },
})