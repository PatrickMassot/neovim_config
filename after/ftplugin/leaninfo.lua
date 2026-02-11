vim.opt_local.winfixwidth = false
vim.opt_local.winfixheight = false
vim.cmd.wincmd('=')

local select_fn = vim.iter(vim.api.nvim_buf_get_keymap(0, 'n')):find(function(maparg) return maparg.lhs == 'gK' end)
		.callback
vim.api.nvim_buf_set_keymap(
	0, 'n', 'k', -- or whatever key
	'', { callback = select_fn })

