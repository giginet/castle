local keymap = vim.keymap.set
function noremap(lhs, rhs)
  keymap("n", lhs, rhs, { noremap = true })
end

function nnoremap(lhs, rhs)
  keymap("n", lhs, rhs, { noremap = true })
end

function map(lhs, rhs)
  keymap("", lhs, rhs, {})
end

