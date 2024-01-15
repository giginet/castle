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
  'Shougo/context_filetype.vim',
  {
    'osyo-manga/vim-precious',
    dependencies = {'context_filetype.vim', 'vim-quickrun'}
  },
  'prabirshrestha/async.vim',
  'rbgrouleff/bclose.vim',
  'vim-denops/denops.vim',
  {
    'github/copilot.vim',
    lazy = false,
    cmd = {'Copilot'},
    config = function()
      noremap('<C-c><Tab>', ':Copilot<CR>')
      vim.b.copilot_enabled = true
      vim.g.copilot_filetypes = {
        env = false,
      }
    end,
  },
  {
    'Shougo/deoplete.nvim',
    config = function()
      vim.api.nvim_set_var('deoplete#enable_at_startup', true)
      vim.cmd("call deoplete#custom#option('smart_case', v:true)")
      vim.opt.completeopt:append('noinsert')
    end,
  },
  {
    'neoclide/coc.nvim',
    branch = 'release',
    build = 'yarn install',
    config = function()
      require('coc')
      vim.g.coc_config_home = vim.fn.stdpath('config')
      vim.g.coc_global_extensions = {
        'coc-json',
        'coc-yaml',
        'coc-sourcekit',
        'coc-markdownlint',
        'coc-solargraph',
        'coc-toml',
        'coc-sh',
        'coc-lua',
      }
    end,
  },
  'tpope/vim-bundler',
  {
    'keith/swift.vim',
    config = function()
      vim.g.syntastic_swift_checkers = {
        'swiftpm',
        'swiftlint',
      }
    end,
  },
  'tfnico/vim-gradle',
  'cespare/vim-toml',
  {
    'elzr/vim-json',
    config = function()
      vim.g.vim_json_syntax_conceal = false
    end,
  },
  'tmux-plugins/vim-tmux',
  'ekalinin/Dockerfile.vim',
  'google/vim-jsonnet',
  'compnerd/modulemap-vim',
  'keith/xcconfig.vim',
  'rust-lang/rust.vim',
  'aklt/plantuml-syntax',
  'Glench/Vim-Jinja2-Syntax',
  'stephpy/vim-yaml',
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
      vim.api.nvim_set_keymap(
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
      vim.api.nvim_set_var('deckset#show_slide_numbers', true)
      vim.api.nvim_set_var('deckset#show_slide_count', true)
      vim.api.nvim_set_var('deckset#autoscale', false)
      vim.api.nvim_set_var('deckset#theme', 'Simple, 2')
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
      vim.api.nvim_set_keymap('v', '<C-g>o', ":'<,'>OpenGithubFile<CR>", { noremap = true, silent = true })
      vim.g.openbrowser_github_always_use_commit_hash = false
      vim.g.openbrowser_github_url_exists_check = 'no'
    end,
  },

  {
    'tomtom/tcomment_vim',
    keys = {'<C-_><C-_>'}
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
  'rbgrouleff/bclose.vim',
  {
    'iberianpig/tig-explorer.vim',
    dependencies = {'blose.vim'},
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
})
