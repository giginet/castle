local opts = { noremap = true }

local keymap = vim.api.nvim_set_keymap
function noremap(lhs, rhs)
  keymap("n", lhs, rhs, opts)
end

function map(lhs, rhs)
  keymap("", lhs, rhs, {})
end

