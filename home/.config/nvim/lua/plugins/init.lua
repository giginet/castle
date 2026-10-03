require('utils')

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

return require('lazy').setup({
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugins.settings.nvim-treesitter")
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('plugins.settings.telescope-nvim')
    end,
  },
  {
    'davvid/telescope-git-grep.nvim',
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },
  {
    'elzr/vim-json',
    ft = {'json'},
    config = function()
      vim.g.vim_json_syntax_conceal = false
    end,
  },
  {
    'tmux-plugins/vim-tmux',
    ft = {'tmux'},
  },
  {
    'compnerd/modulemap-vim',
    ft = {'modulemap'},
  },
  {
    'keith/xcconfig.vim',
    ft = {'xcconfig'},
  },
  {
    'aklt/plantuml-syntax',
    ft = {'plantuml'},
  },
  {
    'Glench/Vim-Jinja2-Syntax',
    ft = {'jinja'},
  },
  {
    'stephpy/vim-yaml',
    ft = {'yaml'},
  },
  {
    'rhysd/vim-syntax-codeowners',
  },
  {
    'tpope/vim-git',
    ft = {'git', 'gitcommit', 'gitconfig', 'gitrebase'}
  },
  {
    'apple/pkl-neovim',
    dependencies = {'nvim-treesitter/nvim-treesitter'},
  },
  {
    'MeanderingProgrammer/markdown.nvim',
    name = 'render-markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' },
    config = function()
      require('render-markdown').setup({})
    end,
  },
  {
   'numToStr/Comment.nvim',
    opts = {
      toggler = {
        line = '<C-_><C-_>',
      },
      opleader = {
        line = '<C-_><C-_>',
      },
    },
    lazy = false,
  },
  {
    'nvim-tree/nvim-tree.lua',
    cmd = {'NvimTreeToggle'},
    keys = {'<C-n>t'},
    config = function()
      nnoremap('<C-n>t', ':NvimTreeToggle<CR>')
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          custom = {
            '\\.vim$',
            '\\.git$',
            '\\.DS_Store',
            '\\.idea',
            '\\.build',
          }
        },
        on_attach = function()
          local api = require('nvim-tree.api')

          vim.keymap.set('n', '<CR>', api.node.open.edit)
          vim.keymap.set('n', '<C-CR>', api.node.open.tab)
          vim.keymap.set('n', '|', api.node.open.vertical)
          vim.keymap.set('n', '_', api.node.open.horizontal)
        end,
        update_focused_file = {
          enable = true,
          update_root = {
            enable = true,
          },
        },
      })
    end
  },
  'airblade/vim-gitgutter',
  {
    'simnalamburt/vim-mundo',
    cmd = 'MundoToggle',
    keys = {'U'},
    config = function()
      nnoremap('U', ':MundoToggle<CR>')
    end,
  },
  {
    "EdenEast/nightfox.nvim",
    config = function()
      -- Erase all background. background will be rendered by WezTerm
      vim.cmd 'autocmd ColorScheme * highlight Normal ctermbg=none guibg=none'
      vim.cmd 'autocmd ColorScheme * highlight NonText ctermbg=none guibg=none'
      vim.cmd 'autocmd ColorScheme * highlight LineNr ctermbg=none guibg=none'
      vim.cmd 'autocmd ColorScheme * highlight Folded ctermbg=none guibg=none'
      vim.cmd 'autocmd ColorScheme * highlight EndOfBuffer ctermbg=none guibg=none'
      vim.cmd.colorscheme 'duskfox'
    end
  },
})
