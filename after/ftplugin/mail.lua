vim.keymap.set('n', '<c-t>', '/^To:<CR>$a <ESC><cmd>lua require("addresses")()<CR>')
vim.keymap.set('n', '<leader>p', '<cmd>lua require("addresses")()<CR>')
vim.keymap.set('n', '<leader>x', 'a,<ESC><cmd>lua require("addresses")()<CR>')
vim.keymap.set('n', '<c-s>', '/Subject:<CR>$a ')
