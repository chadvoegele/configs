local function map(mode, lhs, rhs)
  vim.api.nvim_set_keymap(string.sub(mode, 1, 1), lhs, rhs, {noremap = true})
  if string.len(mode) > 1 then
    return map(string.sub(mode, 2), lhs, rhs)
  end
end

map('nv', 'H', 'hhhhh')
map('nv', 'K', 'kkkkk')
map('nv', 'L', 'lllll')
map('nv', 'J', 'jjjjj')

map('i', '<C-s>', '<esc>:w<cr>')
map('n', '<C-s>', ':w<cr>')
map('i', '<C-q>', '<esc>:q<cr>')
map('n', '<C-q>', ':q<cr>')

-- C-; maps to C-_ with terminal binding
map('invoc', '<C-_>', '<esc>')

map('n', 'U', '<C-r>')

map('n', '<C-p>', "<cmd>lua require('telescope.builtin').find_files()<cr>")
map('n', '<C-j>', "<cmd>lua require('telescope.builtin').buffers({ sort_lastused = true })<cr>")
map('n', '<C-g>', "<cmd>lua require('telescope.builtin').live_grep()<cr>")
