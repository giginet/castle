vim.fn["ddc#custom#patch_global"]('ui', 'native')

vim.fn["ddc#custom#patch_global"]('sources', {
  'around',
  'file',
  'lsp',
})

vim.fn["ddc#custom#patch_global"]('sourceOptions', {
  _ = {
    matchers = {'matcher_fuzzy'},
    sorters = {'sorter_fuzzy'},
    converters = {'converter_fuzzy'},
  },
  around = {
    mark = 'around',
  },
  lsp = {
    mark = 'lsp',
    forceCompletionPattern = "\\.\\w*|:\\w*|->\\w*",
  },
  file = {
    mark = 'file',
    isVolatile = true,
    forceCompletionPattern = '\\S/\\S*',
  }
})

vim.fn["ddc#enable"]()
