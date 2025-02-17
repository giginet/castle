require('telescope').load_extension('git_grep')
local actions = require('telescope.actions')
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['_'] = actions.file_split,
        ['|'] = actions.file_vsplit,
      }
    }
  },
  extensions = {
    git_grep = {
      cwd = '%:h:p',
      skip_binary_files = true,
      use_git_root = true
    }
  }
}
vim.keymap.set('n', '<C-M-o>', '<cmd>Telescope git_files<CR>')
vim.keymap.set('n', '<C-M-f>', '<cmd>Telescope git_grep live_grep<CR>')
