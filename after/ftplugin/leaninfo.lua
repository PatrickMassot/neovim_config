vim.opt_local.winfixwidth = false
vim.opt_local.winfixheight = false
vim.cmd.wincmd('=')
vim.bo.textwidth = 100

vim.opt_local.signcolumn = "yes"

vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '',
  command = ":%s/\\s\\+$//e"
})
