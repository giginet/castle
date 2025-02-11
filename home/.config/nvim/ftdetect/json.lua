vim.filetype.add({
  extension = {
    apns = 'json',
    pif = 'json',
    xctestplan = 'json',
  },
  filename = {
    ['Package.resolved'] = 'json',
    ['.swift-format'] = 'json',
  },
})
