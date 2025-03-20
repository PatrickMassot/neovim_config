-- vim.opt_local.winwidth = 105
vim.bo.textwidth = 0


vim.keymap.set({'n', 'i'}, '<C-.>', function() vim.lsp.buf.code_action({apply=true}) end, { desc = 'Apply first code action' })

