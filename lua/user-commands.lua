vim.api.nvim_create_user_command('Beamer',
  function()
    vim.cmd("colorscheme vscode")
    vim.cmd("set bg=light")
    vim.cmd("set guifont=DroidSansM_Nerd_Font:b")
  end, {nargs = 0})
