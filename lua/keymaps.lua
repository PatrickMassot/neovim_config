-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>n',  "<cmd>Neorg index<cr>", { desc = 'Open Neorg' })

vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeToggle<cr>")

vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("i", "<C-h>", "<ESC><C-w>hi")
vim.keymap.set("i", "<C-j>", "<ESC><C-w>ji")
vim.keymap.set("i", "<C-k>", "<ESC><C-w>ki")
vim.keymap.set("i", "<C-l>", "<ESC><C-w>li")
vim.keymap.set("n", "<C->>", "<C-w>10>")
vim.keymap.set("n", "<C-<>", "<C-w>10<")
vim.keymap.set("i", "<C->>", "<ESC><C-w>10>i")
vim.keymap.set("i", "<C-<>", "<ESC><C-w>10<i")

vim.api.nvim_set_keymap('i', '<C-BS>', '<C-W>', {noremap = true})

-- Lean keymaps
vim.keymap.set({"n", "i"}, "<C-S-X>", "<cmd>LeanRefreshFileDependencies<cr>")

-- Aerial keymaps
vim.keymap.set("n", "<leader>a", "<cmd>AerialToggle!<CR>")
-- vim: ts=2 sts=2 sw=2 et
