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
    'neovim/nvim-lspconfig',
    config = function()
      require('plugins.settings.nvim-lspconfig')
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {"mason.nvim", "nvim-lspconfig"},
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    config = function()
      require("plugins.settings.nvim-treesitter")
    end,
  },
  'Shougo/context_filetype.vim',
  {
    'hrsh7th/nvim-cmp',
    config = function()
      require('plugins.settings.nvim-cmp')
    end,
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    dependencies = {'hrsh7th/nvim-cmp'},
  },
  {
    'hrsh7th/cmp-buffer',
    dependencies = {'hrsh7th/nvim-cmp'},
  },
  {
    'hrsh7th/cmp-path',
    dependencies = {'hrsh7th/nvim-cmp'},
  },
  {
    'onsails/lspkind.nvim'
  },
  {
    'osyo-manga/vim-precious',
    dependencies = {'context_filetype.vim', 'vim-quickrun'}
  },
  'rbgrouleff/bclose.vim',
  {
    'vim-denops/denops.vim',
  },
  {
    'github/copilot.vim',
    lazy = false,
    cmd = {'Copilot'},
    config = function()
      local keymap = vim.keymap.set
      keymap(
        "i",
        "<C-c>",
        'copilot#Accept("<CR>")',
        { silent = true, expr = true, script = true, replace_keycodes = false }
      )
      vim.g.copilot_no_tab_map = true
      noremap('<C-c><Tab>', ':Copilot<CR>')
      vim.b.copilot_enabled = true
      vim.g.copilot_filetypes = {
        env = false,
      }
    end,
  },
  {
    'tpope/vim-bundler',
    ft = {'ruby'},
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
  "wojciech-kulik/xcodebuild.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-tree.lua",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("xcodebuild").setup({
    })
  end,
  },
  {
    'tfnico/vim-gradle',
    ft = {'gradle'},
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
    'elzr/vim-json',
    ft = {'json'},
    config = function()
      vim.g.vim_json_syntax_conceal = false
    end,
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
    'rust-lang/rust.vim',
    ft = {'rust'},
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
    'tpope/vim-git',
    ft = {'git', 'gitcommit', 'gitconfig', 'gitrebase'}
  },
  {
    'apple/pkl-neovim',
    dependencies = {'nvim-treesitter/nvim-treesitter'},
  },
  {
    'Shougo/vimproc.vim',
    build = 'make',
  },
  {
    'thinca/vim-quickrun',
    cmd = {'QuickRun'},
    dependencies = {'vimproc.vim'},
    config = function()
      vim.keymap.set(
        'n',
        '<C-x><C-x>',
        ':QuickRun<CR>',
        { silent = true, }
      )
      vim.g.loaded_quicklaunch = true

      local quickrun_config = {
       ['*'] = {
         runner = 'vimproc'
       },
       markdown = {
         outputter = 'null',
         command = '/usr/bin/open',
         cmdopt = '-a',
         args = 'Marked\\ 2',
         exec = '%c %o %a %s',
       },
       ['markdown.slide'] = {
         outputter = 'null',
         command = '/usr/bin/open',
         cmdopt = '-a',
         args = 'Deckset',
         exec = '%c %o %a %s',
       },
       swift = {
         command = '/usr/bin/xcrun',
         args = 'swift',
         exec = '%c %a %s',
       }
      }
      vim.g.quickrun_config = quickrun_config
    end,
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
    'giginet/denops-deckset.vim',
    ft = {'markdown', 'markdown.slide'},
    cmd = {'InsertCodeHighlight', 'InsertLink'},
    keys = {'<C-s>_', '<C-s>l'},
    dependencies = {'denops.vim'},
    config = function()
      vim.g['deckset#show_slide_numbers'] = true
      vim.g['deckset#show_slide_count'] = true
      vim.g['deckset#autoscale'] = false
      vim.g['deckset#theme'] = 'Simple, 2'
      noremap('<C-s>_', ':InsertCodeHighlight<CR>')
      noremap('<C-s>l', ':InsertLink<CR>')
    end
  },
  'tyru/open-browser.vim',
  {
    'tyru/open-browser-github.vim',
    dependencies = {'open-browser.vim'},
    cmd = {'OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq', 'OpenGithubProject',},
    keys = {'<C-g>o', '<C-g>i', '<C-g>p', '<C-g>g'},
    config = function()
      noremap('<C-g>o', ":OpenGithubFile<CR>")
      vim.keymap.set('v', '<C-g>o', ":'<,'>OpenGithubFile<CR>", { noremap = true, silent = true })
      vim.g.openbrowser_github_always_use_commit_hash = false
      vim.g.openbrowser_github_url_exists_check = 'no'
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
          width = 20,
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

          vim.keymap.set('n', '<CR>', api.node.open.tab)
          vim.keymap.set('n', '|', api.node.open.vertical)
          vim.keymap.set('n', '_', api.node.open.horizontal)
        end
      })
    end
  },
  {
    'iberianpig/tig-explorer.vim',
    dependencies = {'bclose.vim'},
    cmd = {'TigOpenCurrentFile', 'TigOpenProjectRootDir', 'TigGrep', 'TigGrepResume', 'TigBlame'},
    keys = {'<C-g>', '<C-g>l', '<C-g>b', '<C-g>g'},
    config = function()
      nnoremap('<C-g>', ':TigOpenProjectRootDir<CR>')
      nnoremap('<C-g>l', ':TigOpenCurrentFile<CR>')
      nnoremap('<C-g>b', ':TigBlame<CR>')
      nnoremap('<C-g>g', ':TigGrep<CR>')
    end,
  },

  'airblade/vim-gitgutter',

  {
    'keith/investigate.vim',
    keys = {'gK'},
    config = function()
      vim.g.investigate_use_dash = true
    end,
  },

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
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {
      workspaces = {
        {
          name = "Documents",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents",
        },
      },
    },
  },
})
