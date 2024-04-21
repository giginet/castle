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
      require('lsp')
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
    'Shougo/ddc.vim',
    dependencies = {'vim-denops/denops.vim'},
  },
  {
    'Shougo/ddc-source-lsp',
    dependencies = {'Shougo/ddc.vim'},
  },
  {
    'Shougo/ddc-around',
    dependencies = {'Shougo/ddc.vim'},
  },
  {
    'Shougo/ddc-ui-native',
    dependencies = {'Shougo/ddc.vim'},
  },
  {
    'LumaKernel/ddc-source-file',
    dependencies = {'Shougo/ddc.vim'},
  },
  {
    'tani/ddc-fuzzy',
    dependencies = {'Shougo/ddc.vim'},
  },
  {
    'uga-rosa/ddc-source-lsp-setup',
    dependencies = {'Shougo/ddc.vim'},
  },
  'Shougo/context_filetype.vim',
  {
    'osyo-manga/vim-precious',
    dependencies = {'context_filetype.vim', 'vim-quickrun'}
  },
  'rbgrouleff/bclose.vim',
  'vim-denops/denops.vim',
  {
    'github/copilot.vim',
    lazy = false,
    cmd = {'Copilot'},
    config = function()
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
    'keith/swift.vim',
    ft = {'swift'},
    config = function()
      vim.g.syntastic_swift_checkers = {
        'swiftpm',
        'swiftlint',
      }
    end,
  },
  {
    'tfnico/vim-gradle',
    ft = {'gradle'},
  },
  {
    'cespare/vim-toml',
    ft = {'toml'},
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
    'ekalinin/Dockerfile.vim',
    ft = {'dockerfile'},
  },
  {
    'google/vim-jsonnet',
    ft = {'jsonnet'},
  },
  {
    'rust-lang/rust.vim',
    ft = {'rust'},
  },
  {
    'cespare/vim-toml',
    ft = {'toml'},
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
  'godlygeek/tabular',
  {
    'plasticboy/vim-markdown',
    ft = {'markdown'},
    dependencies = {'tabular'},
    config = function()
      vim.g.vim_markdown_folding_disabled = true
      nnoremap('==', ':TableFormat<CR>')
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
    'scrooloose/nerdtree',
    cmd = {'NERDTreeToggle'},
    keys = {'<C-n>t'},
    config = function()
      nnoremap('<C-n>t', ':NERDTreeToggle<CR>')
      vim.g.NERDTreeShowHidden = true
      vim.g.NERDTreeIgnore = {'\\.vim$', '\\.git$', '\\.DS_Store', '\\.idea', '\\.build'}
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
    "folke/tokyonight.nvim",
    config = function()
      vim.cmd.colorscheme 'tokyonight-night'
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
