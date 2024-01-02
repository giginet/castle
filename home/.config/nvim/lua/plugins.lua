require('utils')

-- Bootstrap packer.nvim
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'Shougo/context_filetype.vim'
  use {
    'osyo-manga/vim-precious',
    requires = {'context_filetype.vim', 'vim-quickrun'}
  }
  use 'prabirshrestha/async.vim'
  use 'rbgrouleff/bclose.vim'
  use 'vim-denops/denops.vim'
  use {
    'github/copilot.vim',
    config = function()
      noremap('<C-c><Tab>', ':Copilot<CR>')
      vim.b.copilot_enabled = true
      vim.g.copilot_filetypes = {
        env = false,
      }
    end,
  }
  use {
    'Shougo/deoplete.nvim',
    config = function()
      vim.api.nvim_set_var('deoplete#enable_at_startup', true)
      vim.cmd("call deoplete#custom#option('smart_case', v:true)")
      vim.opt.completeopt:append('noinsert')
    end,
  }
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    run = 'yarn install',
    config = function()
      vim.g.coc_config_home = vim.fn.stdpath('config')
      vim.g.coc_global_extensions = {
        'coc-json',
        'coc-yaml',
        'coc-sourcekit',
        'coc-markdownlint',
        'coc-solargraph',
        'coc-toml',
        'coc-sh',
      }
      vim.cmd('source $HOME/.config/nvim/coc.vim')
    end,
  }

  use 'tpope/vim-bundler'
  use {
    'keith/swift.vim',
    config = function()
      vim.g.syntastic_swift_checkers = {
        'swiftpm',
        'swiftlint',
      }
    end,
  }
  use 'tfnico/vim-gradle'
  use 'cespare/vim-toml'
  use {
    'elzr/vim-json',
    config = function()
      vim.g.vim_json_syntax_conceal = false
    end,
  }
  use 'tmux-plugins/vim-tmux'
  use 'ekalinin/Dockerfile.vim'
  use 'google/vim-jsonnet'
  use 'compnerd/modulemap-vim'
  use 'keith/xcconfig.vim'
  use 'rust-lang/rust.vim'
  use 'aklt/plantuml-syntax'
  use 'Glench/Vim-Jinja2-Syntax'
  use 'stephpy/vim-yaml'

  use {
    'tpope/vim-git',
    ft = {'git', 'gitcommit', 'gitconfig', 'gitrebase'}
  }

  use {
    'Shougo/vimproc.vim',
    run = 'make',
  }

  use {
    'thinca/vim-quickrun',
    cmd = {'QuickRun'},
    require = {'vimproc.vim'},
    setup = function()
      vim.api.nvim_set_keymap(
        'n',
        '<C-x><C-x>', 
        ':QuickRun<CR>',
        { silent = true, }
      )
      vim.g.loaded_quicklaunch = true
    end,
    config = function()
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
  }

  use 'godlygeek/tabular'
  use {
    'plasticboy/vim-markdown',
    ft = {'markdown'},
    require = {'tabular'},
    config = function()
      vim.g.vim_markdown_folding_disabled = true
    end,
  }

  use {
    'giginet/denops-deckset.vim',
    ft = {'markdown', 'markdown.slide'},
    require = {'deops.vim'},
    config = function()
      vim.api.nvim_set_var('deckset#show_slide_numbers', true)
      vim.api.nvim_set_var('deckset#show_slide_count', true)
      vim.api.nvim_set_var('deckset#autoscale', false)
      vim.api.nvim_set_var('deckset#theme', 'Simple, 2')
      noremap('<C-s>_', ':InsertCodeHighlight<CR>')
      noremap('<C-s>l', ':InsertLink<CR>')
    end
  }

  use {
    'Shougo/denite.nvim',
    cmd = {'Denite'},
    config = function()
      vim.cmd([[
        source $HOME/.config/nvim/userautoload/plugins/plugins-denite.vim
        call denite#custom#map('insert', "<C-j>", '<denite:move_to_next_line>', 'noremap')
        call denite#custom#map('insert', "<C-k>", '<denite:move_to_previous_line>', 'noremap')
      ]])
    end,
  }

  use 'tyru/open-browser.vim'

  use {
    'tyru/open-browser-github.vim',
    require = {'open-browser.vim'},
    cmd = {'OpenGithubFile', 'OpenGithubIssue', 'OpenGithubPullReq', 'OpenGithubProject',},
    config = function()
      noremap('<C-g>o', 'execute line(".") . "OpenGithubFile"<CR>')
      keymap('v', '<C-g>o', ":''<','>OpenGithubFile<CR>", { noremap = true, silent = true })
      vim.g.openbrowser_github_always_use_commit_hash = false
      vim.g.openbrowser_github_url_exists_check = 'no'
    end
  }

  use {
    'tomtom/tcomment_vim',
    keys = {'<C-_><C-_>'}
  }

  use {
    'scrooloose/nerdtree',
    cmd = {'NERDTreeToggle'},
    setup = function()
      nnoremap('<C-n>t', ':NERDTreeToggle<CR>')
    end,
    config = function()
      vim.g.NERDTreeShowHidden = true
      vim.g.NERDTreeIgnore = {'\\.vim$', '\\.git$', '\\.DS_Store', '\\.idea', '\\.build'}
    end
  }

  use {
    'iberianpig/tig-explorer.vim',
    require = {'blose.vim'},
    cmd = {'TigOpenCurrentFile', 'TigOpenProjectRootDir', 'TigGrep', 'TigGrepResume', 'TigBlame'},
    config = function()
      nnoremap('<C-g>', ':TigOpenProjectRootDir<CR>')
      nnoremap('<C-g>l', ':TigOpenCurrentFile<CR>')
      nnoremap('<C-g>b', ':TigBlame<CR>')
      nnoremap('<C-g>g', ':TigGrep<CR>')
    end,
  }

  use 'airblade/vim-gitgutter'

  use {
    'keith/investigate.vim',
    keys = {'gK'},
    config = function()
      vim.g.investigate_use_dash = true
    end,
  }

  use {
    'simnalamburt/vim-mundo',
    cmd = 'MundoToggle',
    setup = function()
      nnoremap('U', ':MundoToggle<CR>')
    end,
  }

  use { 
    "catppuccin/nvim", as='catppuccin',
    config = function()
      vim.cmd.colorscheme 'catppuccin'
    end
  }

  if packer_bootstrap then
    require('packer').sync()
  end
end)
