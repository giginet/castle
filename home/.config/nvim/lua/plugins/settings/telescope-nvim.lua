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
-- Terminals without CSI u send Ctrl-/ as Ctrl-_, so map both
vim.keymap.set('n', '<C-M-/>', '<cmd>Telescope git_grep live_grep<CR>')
vim.keymap.set('n', '<C-M-_>', '<cmd>Telescope git_grep live_grep<CR>')
