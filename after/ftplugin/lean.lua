-- vim.opt_local.winwidth = 105
vim.bo.textwidth = 100

vim.opt_local.conceallevel = 0

vim.keymap.set({'n', 'i'}, '<C-.>', function() vim.lsp.buf.code_action({apply=true}) end, { desc = 'Apply first code action' })

vim.opt_local.signcolumn = "yes"

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})
