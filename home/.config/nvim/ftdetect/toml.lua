vim.filetype.add({
  extension = {
    toml = 'toml',
  },
  filename = {
    ['Pipfile'] = 'toml',
    ['pylintrc'] = 'toml',
    ['.pylintrc'] = 'toml',
  },
})
