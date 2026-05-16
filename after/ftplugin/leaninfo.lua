vim.opt_local.winfixwidth = false
vim.opt_local.winfixheight = false
vim.cmd.wincmd('=')


-- vim.keymap.del('n', 'gK', { buffer = true })                      -- if you want gK to no longer work
vim.keymap.set('n', 'S', '<Plug>(LeanInfoviewSelect)', { buffer = true })
