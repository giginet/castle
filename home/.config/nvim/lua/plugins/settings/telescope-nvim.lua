require('telescope').load_extension('git_grep')
require('telescope').setup {
  extensions = {
    git_grep = {
      cwd = '%:h:p',
      skip_binary_files = true,
      use_git_root = true
    }
  }
}
vim.keymap.set('n', '<S-o>', '<cmd>Telescope git_files<CR>')
vim.keymap.set('n', '<S-f>', '<cmd>Telescope git_grep live_grep<CR>')
