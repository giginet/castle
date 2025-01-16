require('utils')

local home_dir = vim.fn.expand('$HOME')

-- Setup Options
local options = {
  cindent = true,
  cinoptions = "g0",
  directory = home_dir .. "/.vimbackup",
  title = true,
  mouse = "a",

  encoding = "utf-8",
  fileencoding = "utf-8",
  hlg = "en",
  langmenu = "en_US.UTF-8",

  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smarttab = true,
  smartindent = true,
  showmatch = true,
  matchtime = 1,
  backspace = "indent,eol,start",
  virtualedit = "block",

  number = true,
  list = true,
  ruler = true,
  wrap = false,

  hlsearch = true,
  incsearch = true,
  smartcase = true,
  grepprg = "grep\\ -nH\\ $*",
  undofile = true,
  undodir = home_dir .. "/.vim/undo",

  termguicolors = true,
  winblend = 0,
}


vim.opt.clipboard:append{'unnamedplus'}
vim.cmd[[language en_US]]

for k, v in pairs(options) do
  vim.opt[k] = v
end


vim.g.python2_host_prog = home_dir .. '/.pyenv/shims/python2'
vim.g.python3_host_prog = home_dir .. '/.pyenv/shims/python'

-- Install Plugins
require('plugins')
vim.api.nvim_create_augroup('lua', {})
vim.api.nvim_create_autocmd({'BufWritePost'}, {
  group = 'lua',
  pattern = {'plugins/init.lua'},
  callback = function()
    vim.api.nvim_echo({{"Please execute :Lazy sync", "WarningMsg"}}, false, {})
  end,
})

vim.filetype.add({
  extension = {
    log = "log",
  },
})

-- Set keymaps
noremap("<C-w>%", ":vsp<CR>")
noremap("<C-w><Bar>", ":vsp<CR>")
noremap("<C-w>\"", ":sp<CR>")
noremap("<C-w>_", ":sp<CR>")
noremap("<C-w>p", ":tabp<CR>")
noremap("<C-w>n", ":tabn<CR>")
noremap("<C-w>c", ":tabnew<CR>")
noremap("<C-w>q", ":tabclose<CR>")

map("<up>", "<nop>")
map("<down>", "<nop>")
map("<left>", "<nop>")
map("<right>", "<nop>")

noremap("<C-k>", "<C-u>")
noremap("<C-j>", "<C-d>")
