vim.filetype.add({
  extension = {
    apns = { ft = 'json', syntax = 'json' },
    pif = { ft = 'json', syntax = 'json' },
    xctestplan = { ft = 'json', syntax = 'json' },
  },
  filename = {
    ['Package.resolved'] = { ft = 'json', syntax = 'json' },
    ['.swift-format'] = { ft = 'json', syntax = 'json' },
  },
})
