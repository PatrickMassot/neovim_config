vim.api.nvim_create_user_command('Beamer',
  function()
    vim.cmd("colorscheme vscode")
    vim.cmd("set bg=light")
    vim.cmd("set guifont=DroidSansM_Nerd_Font:b")
    vim.cmd("lua require 'lean.config'().infoview.view_options.show_term_goals = false")
  end, {nargs = 0})

local group = vim.api.nvim_create_augroup("lean_autocmd", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "leaninfo" },
	callback = function()
		vim.api.nvim_buf_set_keymap(0, 'n', 'n', '<cmd>/• <CR>', { noremap = true, silent = true })
	end,
	group = group
})
