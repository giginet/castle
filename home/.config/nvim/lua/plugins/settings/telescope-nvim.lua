require('telescope').setup {
}
vim.keymap.set('n', '<S-o>', '<cmd>Telescope git_files<CR>')
vim.keymap.set('n', '<S-f>', '<cmd>Telescope live_grep<CR>')
