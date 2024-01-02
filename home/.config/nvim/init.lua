require('utils')

local home_dir = vim.fn.expand('$HOME')

-- Setup Options
local options = {
  cindent = true,
  cinoptions = "g0",
  directory = home_dir .. "/.vimbackup",
  smartindent = true,
  title = true,
  mouse = "a",

  encoding = "utf-8",
  fileencoding = "utf8",
  hlg = "en",

  tabstop = 2,
  shiftwidth = 2,
  expandtab = true,
  smarttab = true,
  showmatch = true,
  matchtime = 1,
  backspace = "indent,eol,start",
  virtualedit = "block",

  number = true,
  list = true,
  ruler = true,
  wrap = false,
  shellslash = true,

  hlsearch = true,
  incsearch = true,
  smartcase = true,
  --    grepprg = "grep\ -nH\ $*"
  undofile = true,
  undodir = home_dir .. "/.vim/undo",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.clipboard:append{'unnamedplus'}

vim.api.nvim_set_var(
  'python2_host_prog',
  home_dir .. '/.pyenv/shims/python2'
)
vim.api.nvim_set_var(
  'python3_host_prog',
  home_dir .. '/.pyenv/shims/python'
)

-- Install Plugins
require('plugins')
vim.cmd[[autocmd BufWritePost plugins.lua PackerCompile]]

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
noremap("<C-k>", "<C-d>")
