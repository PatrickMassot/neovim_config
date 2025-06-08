-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Incremental search
vim.o.incsearch = true

vim.o.scrolloff = 8

vim.o.shiftwidth = 2

vim.o.textwidth = 80

-- Split opening
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Make line numbers default
vim.wo.number = false

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 750
vim.o.timeoutlen = 750

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- Use file name as window title
vim.opt.title = true

-- vim.cmd("colorscheme kanagawa")
vim.cmd('colorscheme catppuccin-macchiato " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha')
vim.cmd("let g:vimtex_quickfix_open_on_warning = 0")

-- Neovide configuration

vim.o.guifont = "JetBrainsMono Nerd Font:h20"
if vim.fn.hostname() == "portable-pmassot" then
  vim.o.guifont = "JetBrainsMono Nerd Font:h7"
end
if vim.fn.hostname() == "fixe-massy" then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
end
if vim.fn.hostname() == "pc93-178" then
  vim.o.guifont = "JetBrainsMono Nerd Font:h12"
end


if vim.g.neovide then
  local map = vim.keymap.set

  local function neovideScale(amount)
    local temp = vim.g.neovide_scale_factor + amount

    if temp < 0.5 then
      return
    end

    vim.g.neovide_scale_factor = temp
    vim.api.nvim_command("redraw!")
  end

  map("n", "<C-+>", function()
    neovideScale(0.1)
  end)

  map("n", "<C-->", function()
    neovideScale(-0.1)
  end)
end

-- vim.g.neovide_cursor_vfx_mode = "pixiedust"

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


if vim.fn.executable('rg') then
  vim.o.grepprg = 'rg --hidden --vimgrep --no-heading --smart-case $*'
  vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
elseif vim.fn.filereadable('/usr/local/bin/grep') then  -- newer grep
  vim.o.grepprg = '/usr/local/bin/grep'
end

-- Affichage diagnostiques en ligne
vim.diagnostic.config({virtual_text=true})

-- Raccourci pour utiliser les diagnostiques en lignes virtuelles
-- https://www.reddit.com/r/neovim/comments/1jo9oe9/i_set_up_my_config_to_use_virtual_lines_for/
local diag_config1 = {
  virtual_text = {
    severity = {
      max = vim.diagnostic.severity.WARN,
    },
  },
  virtual_lines = {
    severity = {
      min = vim.diagnostic.severity.ERROR,
    },
  },
}
local diag_config2 = {
  virtual_text = true,
  virtual_lines = false,
}
vim.diagnostic.config(diag_config2)
local diag_config_basic = true
vim.keymap.set("n", "gK", function()
  diag_config_basic = not diag_config_basic
  if diag_config_basic then
    vim.diagnostic.config(diag_config2)
  else
    vim.diagnostic.config(diag_config1)
  end
end, { desc = "Toggle diagnostic virtual_lines" })

-- Bordure popups (par exemple S-k)
vim.o.winborder = 'rounded'

-- vim: ts=2 sts=2 sw=2 et
