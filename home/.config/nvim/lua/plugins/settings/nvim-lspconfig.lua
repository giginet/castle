-- Setup language servers using Neovim 0.11+ native API
-- mason-lspconfig v2 automatically enables servers via vim.lsp.enable()

require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "bashls",
    "clangd",
    "denols",
    "docker_compose_language_service",
    "dockerls",
    "jsonls",
    "lua_ls",
    "marksman",
    "pylsp",
    "solargraph",
    "taplo",
    "yamlls",
  },
  -- automatic_enable = true is the default in v2
}

-- Custom settings for specific servers using vim.lsp.config
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        pathStrict = true,
        path = { "?.lua", "?/init.lua" },
      },
      workspace = {
        library = {
          "/opt/homebrew/share/nvim/runtime/lua",
          "/opt/homebrew/share/nvim/runtime/lua/vim",
          "/opt/homebrew/share/nvim/runtime/lua/vim/lsp",
        }
      },
    },
  },
})

-- sourcekit is not managed by mason, enable it manually
vim.lsp.config('sourcekit', {})
vim.lsp.enable('sourcekit')

-- Global mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
