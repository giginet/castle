local languages = {
    'bash',
    'dockerfile',
    'git_config',
    'git_rebase',
    'gitattributes',
    'gitcommit',
    'gitignore',
    'graphql',
    'json',
    'kotlin',
    'lua',
    'make',
    'markdown',
    'markdown_inline',
    'python',
    'ruby',
    'rust',
    'sql',
    'swift',
    'toml',
    'vim',
    'vimdoc',
    'yaml',
}

local treesitter = require('nvim-treesitter')
treesitter.setup({})
treesitter.install(languages)

vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    pcall(vim.treesitter.start, args.buf)
  end,
})
