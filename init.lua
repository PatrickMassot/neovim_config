-- ============================================================================
-- OPTIONS
-- ============================================================================

-- TODO: récupérer (et éditer) la config de which-key et celle de telescope
-- regarder config mdd pour inspiration

-- vim.lsp.log.set_level 'debug'

vim.opt.termguicolors = true

vim.opt.number = false                            -- line number
vim.opt.scrolloff = 10                            -- keep 10 lines above/below cursor
vim.opt.sidescrolloff = 10                        -- keep 10 columns to left/right of cursor

vim.opt.tabstop = 2                               -- tabwidth
vim.opt.shiftwidth = 2                            -- indent width
vim.opt.softtabstop = 2                           -- soft tab stop not tabs on tab/backspace
vim.opt.expandtab = true                          -- use spaces instead of tabs
vim.opt.smartindent = true                        -- smart auto-indent
vim.opt.autoindent = true                         -- copy indent from current line

vim.opt.ignorecase = true                         -- case insensitive search
vim.opt.smartcase = true                          -- case sensitive if uppercase in string
vim.opt.hlsearch = true                           -- highlight search matches
vim.opt.incsearch = true                          -- show matches as you type

vim.opt.signcolumn = 'yes'                        -- always show a sign column
-- vim.opt.colorcolumn = "100"                       -- show a column at 100 position chars
vim.opt.showmatch = true                          -- highlights matching brackets
vim.opt.cmdheight = 1                             -- single line command line
vim.opt.completeopt = 'menuone,noinsert,noselect' -- completion options
vim.opt.lazyredraw = true                         -- do not redraw during macros
vim.opt.synmaxcol = 300                           -- syntax highlighting limit
vim.opt.fillchars = { eob = ' ' }                 -- hide "~" on empty lines
vim.o.textwidth = 80                              -- default text width

local undodir = vim.fn.expand '~/.vim/undodir'
if
    vim.fn.isdirectory(undodir) == 0 -- create undodir if nonexistent
then
  vim.fn.mkdir(undodir, 'p')
end

vim.opt.backup = false                 -- do not create a backup file
vim.opt.writebackup = false            -- do not write to a backup file
vim.opt.undofile = true                -- do create an undo file
vim.opt.undodir = undodir              -- set the undo directory
vim.opt.updatetime = 300               -- faster completion
vim.opt.timeoutlen = 500               -- timeout duration
vim.opt.ttimeoutlen = 0                -- key code timeout
vim.opt.autoread = true                -- auto-reload changes if outside of neovim
vim.opt.autowrite = false              -- do not auto-save

vim.opt.hidden = true                  -- allow hidden buffers
vim.opt.errorbells = false             -- no error sounds
vim.opt.backspace = 'indent,eol,start' -- better backspace behaviour
vim.opt.autochdir = false              -- do not autochange directories
vim.opt.iskeyword:append '-'           -- include - in words
vim.opt.path:append '**'               -- include subdirs in search
vim.opt.mouse = 'a'                    -- enable mouse support
vim.opt.clipboard:append 'unnamedplus' -- use system clipboard

vim.o.breakindent = true               -- enable break indent for wrapped lines

-- Folding: requires treesitter available at runtime; safe fallback if not
vim.opt.foldmethod = 'expr'                          -- use expression for folding
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- use treesitter for folding
vim.opt.foldlevel = 99                               -- start with all folds open

vim.opt.splitbelow = true                            -- horizontal splits go below
vim.opt.splitright = true                            -- vertical splits go right

vim.opt.wildmenu = true                              -- tab completion
vim.opt.wildmode = 'longest:full,full'               -- complete longest common match, full completion list, cycle through with Tab
vim.opt.diffopt:append 'linematch:60'                -- improve diff display
vim.opt.redrawtime = 10000                           -- increase neovim redraw tolerance
vim.opt.maxmempattern = 20000                        -- increase max memory

vim.o.winborder = 'rounded'                          -- popups borders (eg. S-k)
vim.opt.title = true                                 -- Use file name as window title

vim.cmd 'set spelllang=en,fr'

vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_open_on_warning = '0'

vim.g.mailheaders_settings = {
  addresses = '$HOME/.config/mutt/addresses',
  set_mappings = true,
}
vim.api.nvim_create_user_command('MailFilter', function()
  vim.cmd 'silent g/Vous ne recevez pas souvent/d'
  vim.cmd 'silent g/Vous n’obtenez pas souvent/d'
  vim.cmd "silent g/You don't often get email/d"
  vim.cmd '1'
end, {})

-- Neovide configuration

vim.o.guifont = 'JetBrainsMono Nerd Font:h20'
if vim.fn.hostname() == 'portable-patrick' then
  vim.o.guifont = 'JetBrainsMono Nerd Font:h8'
end
if vim.fn.hostname() == 'fixe-massy' then
  vim.o.guifont = 'JetBrainsMono Nerd Font:h12'
end
if vim.fn.hostname() == 'pc93-178' then
  vim.o.guifont = 'JetBrainsMono Nerd Font:h12'
end

if vim.g.neovide then
  local map = vim.keymap.set

  local function neovideScale(amount)
    local temp = vim.g.neovide_scale_factor + amount

    if temp < 0.5 then
      return
    end

    vim.g.neovide_scale_factor = temp
    vim.api.nvim_command 'redraw!'
  end

  map('n', '<C-+>', function()
    neovideScale(0.1)
  end)

  map('n', '<C-->', function()
    neovideScale(-0.1)
  end)
end

if vim.fn.executable 'rg' then
  vim.o.grepprg = 'rg --hidden --vimgrep --no-heading --smart-case $*'
  vim.o.grepformat = '%f:%l:%c:%m,%f:%l:%m'
elseif vim.fn.filereadable '/usr/local/bin/grep' then -- newer grep
  vim.o.grepprg = '/usr/local/bin/grep'
end

vim.diagnostic.config { virtual_text = true } -- use online diagnostics

-- ============================================================================
-- KEYMAPS
-- ============================================================================
vim.g.mapleader = ' '      -- space for leader
vim.g.maplocalleader = ' ' -- space for localleader

-- better movement in wrapped text
vim.keymap.set('n', 'j', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true, desc = 'Down (wrap-aware)' })
vim.keymap.set('n', '<DOWN>', function()
  return vim.v.count == 0 and 'gj' or 'j'
end, { expr = true, silent = true, desc = 'Down (wrap-aware)' })
vim.keymap.set('n', 'k', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true, desc = 'Up (wrap-aware)' })
vim.keymap.set('n', '<UP>', function()
  return vim.v.count == 0 and 'gk' or 'k'
end, { expr = true, silent = true, desc = 'Up (wrap-aware)' })

vim.keymap.set('n', '<leader>c', ':nohlsearch<CR>', { desc = 'Clear search highlights' })

vim.keymap.set('n', 'n', 'nzzzv', { desc = 'Next search result (centered)' })
vim.keymap.set('n', 'N', 'Nzzzv', { desc = 'Previous search result (centered)' })
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Half page down (centered)' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Half page up (centered)' })

vim.keymap.set('x', '<leader>p', '"_dP', { desc = 'Paste without yanking' })
vim.keymap.set({ 'n', 'v' }, '<leader>x', '"_d', { desc = 'Delete without yanking' })

vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Move to bottom window' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Move to top window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })
vim.keymap.set('i', '<C-h>', '<ESC><C-w>hi', { desc = 'Move to left window' })
vim.keymap.set('i', '<C-j>', '<ESC><C-w>ji', { desc = 'Move to bottom window' })
vim.keymap.set('i', '<C-k>', '<ESC><C-w>ki', { desc = 'Move to top window' })
vim.keymap.set('i', '<C-l>', '<ESC><C-w>li', { desc = 'Move to right window' })
vim.keymap.set('n', '<C->>', '<C-w>10>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-<>', '<C-w>10<', { desc = 'Decrease window width' })
vim.keymap.set('i', '<C->>', '<ESC><C-w>10>i', { desc = 'Increase window width' })
vim.keymap.set('i', '<C-<>', '<ESC><C-w>10<i', { desc = 'Decrease window width' })

vim.keymap.set('n', '<leader>sv', ':vsplit<CR>', { desc = 'Split window vertically' })
vim.keymap.set('n', '<leader>sh', ':split<CR>', { desc = 'Split window horizontally' })

vim.keymap.set('n', '<A-j>', ':m .+1<CR>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', ':m .-2<CR>==', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

vim.keymap.set('v', '<', '<gv', { desc = 'Indent left and reselect' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent right and reselect' })

vim.keymap.set('n', 'J', 'mzJ`z', { desc = 'Join lines and keep cursor position' })

vim.keymap.set('i', '<C-BS>', '<C-W>', { noremap = true })

vim.keymap.set('n', '<C-q>', ':q<CR>', { noremap = true })
vim.keymap.set('n', '<C-s>', ':w<CR>', { noremap = true })

vim.keymap.set('n', '<leader>pa', function() -- show file path
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  print('file:', path)
end, { desc = 'Copy full file path' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', function()
  vim.diagnostic.jump { count = -1 }
end, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', function()
  vim.diagnostic.jump { count = 1 }
end, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<C-f>', vim.lsp.buf.format)

-- LuaSnip keymaps
vim.keymap.set({ 'i' }, '<C-c>', '<cmd>lua require("luasnip.extras.select_choice")()<cr>')
vim.keymap.set(
  { 'i' },
  '<C-tab>',
  '<cmd>lua require("luasnip").exit_out_of_region(require("luasnip").session.current_nodes[vim.api.nvim_get_current_buf()])<cr>'
)

-- Aerial keymaps
vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>')

-- Flash keymaps
vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
  require('flash').jump()
end, { desc = 'Flash' })
vim.keymap.set({ 'n', 'x', 'o' }, 'S', function()
  require('flash').treesitter()
end, { desc = 'Flash Treesitter' })
vim.keymap.set({ 'o' }, 'r', function()
  require('flash').remote()
end, { desc = 'Remote Flash' })

-- actions-preview keymaps
vim.keymap.set({ 'v', 'n' }, 'ga', function()
  require('actions-preview').code_actions()
end)

-- ============================================================================
-- AUTOCMDS
-- ============================================================================

local augroup = vim.api.nvim_create_augroup('UserConfig', { clear = true })

-- highlight yanked text
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.hl.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- return to last cursor position
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  desc = 'Restore last cursor position',
  callback = function()
    if vim.o.diff then -- except in diff mode
      return
    end

    local last_pos = vim.api.nvim_buf_get_mark(0, '"') -- {line, col}
    local last_line = vim.api.nvim_buf_line_count(0)

    local row = last_pos[1]
    if row < 1 or row > last_line then
      return
    end

    pcall(vim.api.nvim_win_set_cursor, 0, last_pos)
  end,
})

-- wrap, linebreak and spellcheck on markdown and text files
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'markdown', 'text', 'gitcommit', 'org' },
  callback = function()
    if not vim.bo.buflisted then
      return
    end
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.spell = true
  end,
})

-- Org mode files settings
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'org' },
  callback = function()
    vim.opt.conceallevel = 1
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = { 'typst' },
  callback = function()
    require('typst-preview').setup {
      open_cmd = 'firefox %s -P typst-preview --class typst-preview',
      dependencies_bin = {
        tinymist = 'tinymist',
      },
    }
    vim.keymap.set({ 'n' }, '<C-p>', '<cmd>TypstPreview<cr>', { buffer = true })
    vim.keymap.set({ 'n' }, '<C-S-p>', '<cmd>TypstPreview slide<cr>', { buffer = true })
  end,
})

vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    local name, kind = ev.data.spec.name, ev.data.kind
    if name == 'nvim-treesitter' and kind == 'update' then
      if not ev.data.active then
        vim.cmd.packadd 'nvim-treesitter'
      end
      vim.cmd 'TSUpdate'
    end
    if name == 'telescope-fzf-native.nvim' and (kind == 'install' or kind == 'update') then
      vim.system({ 'make' }, { cwd = ev.data.path })
    end
  end,
})

-- ============================================================================
-- PLUGINS (vim.pack)
-- ============================================================================
local gh = function(x)
  return 'https://github.com/' .. x
end
vim.pack.add {
  -- General UI
  gh 'nvim-tree/nvim-tree.lua',
  gh 'nvim-tree/nvim-web-devicons',
  {
    src = gh 'nvim-treesitter/nvim-treesitter',
    branch = 'main', -- it’s the new one: master does not support 0.12
  },
  gh 'nvim-treesitter/nvim-treesitter-textobjects',
  gh 'stevearc/aerial.nvim',
  gh 'nvim-lualine/lualine.nvim',
  gh 'folke/which-key.nvim',

  -- Telescope
  gh 'nvim-lua/plenary.nvim',
  gh 'nvim-telescope/telescope.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
  gh 'benfowler/telescope-luasnip.nvim',
  gh 'nvim-telescope/telescope-ui-select.nvim',
  gh 'jvgrootveld/telescope-zoxide',
  gh 'nvim-telescope/telescope-fzf-native.nvim',

  -- Notifications
  gh 'rcarriga/nvim-notify',
  gh 'j-hui/fidget.nvim',

  -- Color schemes
  {
    src = gh 'catppuccin/nvim',
    name = 'catppuccin',
  },
  gh 'Mofiqul/vscode.nvim',

  -- General editing
  gh 'folke/flash.nvim',
  gh 'MagicDuck/grug-far.nvim',
  gh 'monaqa/dial.nvim',
  gh 'nvim-mini/mini.surround',

  -- Language Server Protocols, code action and snippets
  gh 'neovim/nvim-lspconfig',
  gh 'mason-org/mason.nvim',
  gh 'mason-org/mason-lspconfig.nvim',
  gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  gh 'folke/trouble.nvim',
  -- gh 'creativenull/efmls-configs-nvim',
  {
    src = gh 'saghen/blink.cmp',
    version = vim.version.range '1.*',
  },
  gh 'folke/lazydev.nvim',
  gh 'kosayoda/nvim-lightbulb',
  gh 'aznhe21/actions-preview.nvim',
  {
    src = gh 'L3MON4D3/LuaSnip',
    build = (function()
      return 'make install_jsregexp'
    end)(),
  },

  -- Git stuff
  gh 'tpope/vim-fugitive',
  gh 'lewis6991/gitsigns.nvim',

  -- File type specific plugins

  {
    src = gh 'chomosuke/typst-preview.nvim',
    build = ':TypstPreviewUpdate',
  },
  gh 'Julian/lean.nvim',
  gh 'lervag/vimtex',
  gh 'saghen/blink.compat',
  gh 'micangl/cmp-vimtex',
  'https://codeberg.org/pmassot/mail-headers.nvim.git',

  -- Orgmode and friends
  gh 'nvim-orgmode/orgmode',
  gh 'chipsenkbeil/org-roam.nvim',
  gh 'nvim-orgmode/telescope-orgmode.nvim',
  gh 'danilshvalov/org-modern.nvim',     -- nice menus
  gh 'hamidi-dev/org-super-agenda.nvim', -- nice agenda
  gh 'lukas-reineke/headlines.nvim',     -- orgmode headline formatting
}

vim.cmd 'colorscheme catppuccin-macchiato'

-- ============================================================================
-- PLUGIN CONFIGS
-- ============================================================================

require('nvim-tree').setup {
  view = {
    width = 35,
  },
  filters = {
    dotfiles = false,
  },
  renderer = {
    group_empty = true,
  },
}
vim.keymap.set('n', '<leader>t', function()
  require('nvim-tree.api').tree.toggle()
end, { desc = 'Toggle NvimTree' })

require('gitsigns').setup {
  -- See `:help gitsigns.txt`
  signs = {
    add = { text = '┃' },
    change = { text = '┃' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  signcolumn = true,
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map({ 'n', 'v' }, ']c', function()
      if vim.wo.diff then
        return ']c'
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Jump to next hunk' })

    map({ 'n', 'v' }, '[c', function()
      if vim.wo.diff then
        return '[c'
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return '<Ignore>'
    end, { expr = true, desc = 'Jump to previous hunk' })

    -- Actions
    -- visual mode
    map('v', '<leader>hs', function()
      gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'stage git hunk' })
    map('v', '<leader>hr', function()
      gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'reset git hunk' })
    -- normal mode
    map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
    map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
    map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
    map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
    map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
    map('n', '<leader>hb', function()
      gs.blame_line { full = false }
    end, { desc = 'git blame line' })
    map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
    map('n', '<leader>hD', function()
      gs.diffthis '~'
    end, { desc = 'git diff against last commit' })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
  end,
}

require('notify').setup { background_color = '#000000' }
vim.notify = require 'notify'
-- require("notify").setup({ render = "wrapped-compact", max_width = 100 })
-- vim.notify = function(...)
-- 	vim.notify = require("notify")
-- 	return vim.notify(...)
-- end

-- ============================================================================
-- LSP, Linting, Formatting & Completion
-- ============================================================================

require('mason').setup {}
require('mason-lspconfig').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    'lua_ls',
    'stylua',
    'pyright',
    'tinymist',
  },
}

-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  virtual_text = {
    source = 'if_many',
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
}

local function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, function(_, result, _)
    if result == nil or vim.tbl_isempty(result) then
      vim.notify 'No definition found.'
      return nil
    end
    if vim.islist(result) then
      result = result[1]
    end
    vim.lsp.util.preview_location(result, { border = 'single' })
  end)
end

local function lsp_on_attach(ev)
  local client = vim.lsp.get_client_by_id(ev.data.client_id)
  if not client then
    return
  end

  -- local bufnr = ev.buf
  -- local opts = { noremap = true, silent = true, buffer = bufnr }

  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = ev.buf, desc = 'LSP: ' .. desc })
  end

  -- Find references for the word under your cursor.
  map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

  -- Jump to the implementation of the word under your cursor.
  --  Useful when your language has ways of declaring types without an actual implementation.
  map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

  -- Jump to the definition of the word under your cursor.
  --  This is where a variable was first declared, or where a function is defined, etc.
  --  To jump back, press <C-t>.
  map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

  -- WARN: This is not Goto Definition, this is Goto Declaration.
  --  For example, in C this would take you to the header.
  map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

  -- Fuzzy find all the symbols in your current document.
  --  Symbols are things like variables, functions, types, etc.
  map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

  -- Fuzzy find all the symbols in your current workspace.
  --  Similar to document symbols, except searches over your entire project.
  map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

  -- Jump to the type of the word under your cursor.
  --  Useful when you're not sure what type a variable is and you want to see
  --  the definition of its *type*, not where it was *defined*.
  map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

  -- Peek at definition instead of jumping
  map('gK', peek_definition, '[G]oto pee[k]ed Definition')

  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, ev.buf) then
    local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
      buffer = ev.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      buffer = ev.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd('LspDetach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
      callback = function(ev2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = ev2.buf }
      end,
    })
  end

  -- Toggle inlay hints
  if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, ev.buf) then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = ev.buf })
    end, '[T]oggle Inlay [H]ints')
  end

  -- Tinymist config
  if client.name == 'tinymist' then
    vim.keymap.set('n', '<leader>tp', function()
      client:exec_cmd({
        title = 'pin',
        command = 'tinymist.pinMain',
        arguments = { vim.api.nvim_buf_get_name(0) },
      }, { bufnr = ev.buf })
    end, { desc = '[T]inymist [P]in', noremap = true })

    vim.keymap.set('n', '<leader>tu', function()
      client:exec_cmd({
        title = 'unpin',
        command = 'tinymist.pinMain',
        arguments = { vim.v.null },
      }, { bufnr = ev.buf })
    end, { desc = '[T]inymist [U]npin', noremap = true })
  end
end

vim.api.nvim_create_autocmd('LspAttach', { group = augroup, callback = lsp_on_attach })

vim.keymap.set('n', '<leader>q', function()
  vim.diagnostic.setloclist { open = true }
end, { desc = 'Open diagnostic list' })
vim.keymap.set('n', '<leader>dl', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })

require('blink.cmp').setup {
  keymap = { preset = 'default' },
  appearance = { nerd_font_variant = 'mono' },
  completion = {
    -- By default, you may press `<c-space>` to show the documentation.
    -- Optionally, set `auto_show = true` to show the documentation after a delay.
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
    -- Do not show auto-completion automatically, need a keypress
    menu = {
      -- show_on_keyword = false,
      auto_show = false,
    },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'lazydev', 'buffer', 'vimtex' },
    providers = {
      snippets = {
        min_keyword_length = 2,
        score_offset = 6,
      },
      lsp = {
        min_keyword_length = 0,
        score_offset = 3,
      },
      buffer = {
        min_keyword_length = 3,
        score_offset = 2,
      },
      path = {
        min_keyword_length = 2,
        score_offset = 1,
      },
      lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      vimtex = {
        name = 'vimtex',
        min_keyword_length = 0,
        module = 'blink.compat.source',
        score_offset = 80,
      },
    },
  },
  snippets = { preset = 'luasnip' },

  fuzzy = {
    implementation = 'prefer_rust',
    prebuilt_binaries = { download = true },
  },
  signature = { enabled = true },
}

vim.lsp.config['*'] = {
  capabilities = require('blink.cmp').get_lsp_capabilities(),
}

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
      telemetry = { enable = false },
    },
  },
})
vim.lsp.config('pyright', {})

vim.lsp.config('tinymist', {
  single_file_support = true,
  offset_encoding = 'utf-8',
  settings = {
    formatterMode = 'typstyle',
    formatterProseWrap = true,
    formatterPrintWidth = 80,
    exportPdf = 'never',
    semanticTokens = 'disable',
    preview = { background = { enabled = true } },
  },
})
-- vim.lsp.config("bashls", {})
-- vim.lsp.config("ts_ls", {})

-- do
-- local luacheck = require("efmls-configs.linters.luacheck")
-- local stylua = require("efmls-configs.formatters.stylua")

-- local flake8 = require("efmls-configs.linters.flake8")
-- local black = require("efmls-configs.formatters.black")
--
-- local prettier_d = require("efmls-configs.formatters.prettier_d")
-- local eslint_d = require("efmls-configs.linters.eslint_d")
--
-- local fixjson = require("efmls-configs.formatters.fixjson")
--
-- local shellcheck = require("efmls-configs.linters.shellcheck")
-- local shfmt = require("efmls-configs.formatters.shfmt")
--
-- vim.lsp.config("efm", {
-- 	filetypes = {
-- 		"css",
-- 		"html",
-- 		"javascript",
-- 		"javascriptreact",
-- 		"json",
-- 		"jsonc",
-- 		"lua",
-- 		"markdown",
-- 		"python",
-- 		"sh",
-- 		"typescript",
-- 		"typescriptreact",
-- 		"vue",
-- 	},
-- 	init_options = { documentFormatting = true },
-- 	settings = {
-- 		languages = {
-- 			css = { prettier_d },
-- 			html = { prettier_d },
-- 			javascript = { eslint_d, prettier_d },
-- 			javascriptreact = { eslint_d, prettier_d },
-- 			json = { eslint_d, fixjson },
-- 			lua = { luacheck, stylua },
-- 			markdown = { prettier_d },
-- 			python = { flake8, black },
-- 			sh = { shellcheck, shfmt },
-- 			typescript = { eslint_d, prettier_d },
-- 			typescriptreact = { eslint_d, prettier_d },
-- 			vue = { eslint_d, prettier_d },
-- 		},
-- 	},
-- })
-- end

vim.lsp.enable {
  'lua_ls',
  'pyright',
  'ts_ls',
  -- 'efm',
  'org',
}

---------------------------------------------------------------------
--- Telescope
---------------------------------------------------------------------
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    layout_strategy = 'flex',
  },
  pickers = {
    colorscheme = {
      enable_preview = true,
    },
  },
}

-- Enable telescope fzf native, if installed
require('telescope').load_extension 'fzf'

-- require('telescope').load_extension('ultisnips')
require('telescope').load_extension 'luasnip'
require('telescope').load_extension 'zoxide'
require('telescope').load_extension 'ui-select'

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == '' then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ':h')
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist('git -C ' .. vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
  if vim.v.shell_error ~= 0 then
    print 'Not a git repository. Searching on current working directory'
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep {
      search_dirs = { git_root },
    }
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', function()
  return require('telescope.builtin').buffers { file_ignore_patterns = { 'lean://' } }
end, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end

vim.keymap.set('n', '<leader>f/', telescope_live_grep_open_files, { desc = '[F]ind [/] in Open Files' })
vim.keymap.set('n', '<leader>fb', function()
  return require('telescope.builtin').buffers { file_ignore_patterns = { 'lean://' } }
end, { desc = '[F]ind [B]uffer' })
vim.keymap.set('n', '<leader>fs', require('telescope.builtin').builtin, { desc = '[F]ind [S]elect Telescope' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[F]ind current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[F]ind by [G]rep' })
vim.keymap.set('n', '<leader>fG', ':LiveGrepGitRoot<cr>', { desc = '[F]ind by [G]rep on Git Root' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[F]ind [D]iagnostics' })
vim.keymap.set('n', '<leader>fj', require('telescope.builtin').jumplist, { desc = '[F]ind [J]ump' })
vim.keymap.set('n', '<leader>fr', require('telescope.builtin').lsp_references, { desc = '[F]ind [R]eferences' })
vim.keymap.set('n', '<leader>fa', require('telescope.builtin').lsp_dynamic_workspace_symbols,
  { desc = '[F]ind [A]ll symbols in workspace' })
-- vim.keymap.set('n', '<leader>fu', require('telescope').extensions.ultisnips.ultisnips, { desc = '[F]ind [U]ltisnips snippets' })
vim.keymap.set('n', '<leader>fl', require('telescope').extensions.luasnip.luasnip, { desc = '[F]ind [L]uaSnip snippets' })
vim.keymap.set('n', '<leader>fc', require('telescope').extensions.zoxide.list, { desc = '[F]ind and [Change] directory' })

require('luasnip.loaders.from_lua').load { paths = { '~/.config/nvim/LuaSnip/' } }

require('luasnip').config.set_config { -- Setting LuaSnip config
  -- Use <Tab> (or some other key if you prefer) to trigger visual selection
  store_selection_keys = '<Tab>',
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_y = {
      --- Display Lean file progress when still processing, otherwise
      --- fallback to cursor progress via the normal lualine component.
      function()
        if vim.bo.filetype ~= 'lean' then
          return require 'lualine.components.progress' ()
        end

        local percentage = require('lean.progress').percentage()
        if percentage >= 100 then
          return require 'lualine.components.progress' ()
        end
        return string.format('Processing… %.f%%%%', percentage)
      end,
    },
  },
}

require('flash').setup()

require('lazydev').setup()

require('which-key').setup {
  triggers = {
    { '<auto>', mode = 'nso' },
  },
  icons = {
    -- set icon mappings to true if you have a Nerd Font
    mappings = true,
    -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
    -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
    keys = {},
  },

  -- Document existing key chains
  spec = {
    { '<leader>d',  group = '[D]iff' },
    { '<leader>h',  group = 'Git [H]unk' },
    { '<leader>f',  group = '[F]ind using Telescope' },
    { '<leader>n',  group = '[N]otes' },
    { '<leader>s',  group = '[S]plit' },
    { '<leader>ol', group = '[Org] [L]ink' },
    { '<leader>oi', group = '[Org] [I]nsert' },
    { '<leader>ox', group = '[Org] Clock' },
  },
}

require('mini.surround').setup {
  mappings = {
    add = '',          -- Add surrounding in Normal and Visual modes
    delete = 'ds',     -- Delete surrounding
    find = 'fs',       -- Find surrounding (to the right)
    find_left = '',    -- Find surrounding (to the left)
    highlight = 'hs',  -- Highlight surrounding
    replace = 'cs',    -- Replace surrounding

    suffix_last = 'l', -- Suffix to search with "prev" method
    suffix_next = 'n', -- Suffix to search with "next" method
  },
}

require('lean').setup {
  -- lsp = {
  --   init_options = { editDelay = 0 },
  -- },
  mappings = true,
  abbreviations = {
    enable = true,
    extra = {},
    leader = ',',
  },
  goal_markers = { accomplished = '✓', unsolved = '' },
  stderr = {
    on_lines = function(lines)
      local opts = {
        timeout = 3000,
        render = 'wrapped-compact',
      }

      local _, _, maybe_level, rest = lines:find '^(%w+): (.*)'
      -- Lean uses warning rather than warn...
      -- and some message don't have any level...
      -- surely there's another way we should do this.
      local level = vim.log.levels[(maybe_level or ''):upper()]
      if not level then
        rest = lines
      end
      vim.notify(rest, level, opts)
    end,
  },
}

require('nvim-lightbulb').setup {
  autocmd = { enabled = true },
}

require('actions-preview').setup {
  telescope = {
    sorting_strategy = 'ascending',
    layout_strategy = 'vertical',
    layout_config = {
      width = 0.8,
      height = 0.9,
      prompt_position = 'top',
      preview_cutoff = 20,
      preview_height = function(_, _, max_lines)
        return max_lines - 15
      end,
    },
  },
}

local LinkEMailType = {}

---@return string
function LinkEMailType:get_name()
  return 'email'
end

---@param link string - The current value of the link, for example: "email:google.com"
---@return boolean - When true, link was handled, when false, continue to the next source
function LinkEMailType:follow(link)
  if not vim.startswith(link, 'email:') then
    return false
  end
  -- Get the part after the `email:` part
  local url = link:sub(7)
  vim.system { 'kitty', 'neomutt', '-e', '""push l~i' .. url .. '<enter><enter>""' }
  return true
end

local Menu = require 'org-modern.menu'
require('orgmode').setup {
  org_agenda_files = '~/Nextcloud/orgfiles/**/*',
  org_default_notes_file = '~/Nextcloud/orgfiles/refile.org',
  org_capture_templates = {
    t = { description = 'Todo', template = '* TODO %?\n %u' },
    i = { description = 'Idée', template = '* Idée %?\n %u' },
  },
  org_use_property_inheritance = false,
  mappings = {
    org = {
      org_refile = nil,
      org_todo = '<C-d>',
    },
    capture = { org_capture_refile = nil },
    agenda = {
      org_agenda_refile = nil,
      org_agenda_todo = '<C-d>',
    },
  },
  hyperlinks = {
    sources = {
      LinkEMailType,
    },
  },
  ui = {
    menu = {
      handler = function(data)
        Menu:new({
          window = {
            margin = { 1, 0, 1, 0 },
            padding = { 0, 1, 0, 1 },
            title_pos = 'center',
            border = 'single',
            zindex = 1000,
          },
          icons = {
            separator = '➜',
          },
        }):open(data)
      end,
    },
  },
}

require('org-roam').setup {
  directory = '~/Nextcloud/orgfiles/roam',
}

vim.keymap.set('n', '<leader>oA', '<cmd>OrgSuperAgenda<cr>')

require('org-super-agenda').setup {
  -- Where to look for .org files
  org_files = {},
  org_directories = { '~/Nextcloud/orgfiles/' }, -- recurse for *.org
  exclude_files = {},
  exclude_directories = {},

  -- TODO states + their quick filter keymaps and highlighting
  -- Optional: add `shortcut` field to override the default key (first letter)
  todo_states = {
    { name = 'TODO',     keymap = 'ot', color = '#FF5555', strike_through = false, fields = { 'filename', 'todo', 'headline', 'priority', 'date', 'tags' } },
    { name = 'PROGRESS', keymap = 'op', color = '#FFAA00', strike_through = false, fields = { 'filename', 'todo', 'headline', 'priority', 'date', 'tags' } },
    { name = 'WAITING',  keymap = 'ow', color = '#BD93F9', strike_through = false, fields = { 'filename', 'todo', 'headline', 'priority', 'date', 'tags' } },
    { name = 'DONE',     keymap = 'od', color = '#50FA7B', strike_through = true,  fields = { 'filename', 'todo', 'headline', 'priority', 'date', 'tags' } },
  },

  -- Agenda keymaps (inline comments explain each)
  keymaps = {
    filter_reset = 'oa',     -- reset all filters
    toggle_other = 'oo',     -- toggle catch-all "Other" section
    filter = 'of',           -- live filter (exact text)
    filter_fuzzy = 'oz',     -- live filter (fuzzy)
    filter_query = 'oq',     -- advanced query input
    undo = 'u',              -- undo last change
    reschedule = 'cs',       -- set/change SCHEDULED
    set_deadline = 'cd',     -- set/change DEADLINE
    cycle_todo = 't',        -- cycle TODO state
    set_state = 's',         -- set state directly (st, sd, etc.) or show menu
    reload = 'r',            -- refresh agenda
    refile = 'R',            -- refile via Telescope/org-telescope
    hide_item = 'x',         -- hide current item
    preview = 'K',           -- preview headline content
    clock_in = 'I',          -- clock in on current headline
    clock_out = 'O',         -- clock out active clock
    clock_cancel = 'X',      -- cancel active clock
    clock_goto = 'gI',       -- jump to active/recent clocked task
    reset_hidden = 'gX',     -- clear hidden list
    fold_all = 'zM',         -- collapse all groups
    unfold_all = 'zR',       -- expand all groups
    toggle_duplicates = 'D', -- duplicate items may appear in multiple groups
    cycle_view = 'ov',       -- switch view (classic/compact)
    bulk_mark = 'm',         -- toggle mark on current item (● indicator)
    bulk_unmark_all = 'M',   -- clear all marks
    bulk_reselect = 'gv',    -- reselect last marks
    bulk_action = 'B',       -- run action on all marked items
    open_view = 'V',         -- open custom view picker
  },

  -- Window/appearance
  window = {
    width = 0.8,
    height = 0.7,
    border = 'rounded',
    title = 'Org Super Agenda',
    title_pos = 'center',
    margin_left = 0,
    margin_right = 0,
    fullscreen_border = 'none', -- border style when using fullscreen
  },

  -- Group definitions (order matters; first match wins unless allow_duplicates=true)
  groups = {
    {
      name = '📅 Today',
      matcher = function(i)
        return i.scheduled and i.scheduled:is_today()
      end,
      sort = { by = 'scheduled_time', order = 'asc' },
    },
    {
      name = '🗓️ Tomorrow',
      matcher = function(i)
        return i.scheduled and i.scheduled:days_from_today() == 1
      end,
      sort = { by = 'scheduled_time', order = 'asc' },
    },
    {
      name = '☠️ Deadlines',
      matcher = function(i)
        return i.deadline and i.todo_state ~= 'DONE' and not i:has_tag 'personal'
      end,
      sort = { by = 'deadline', order = 'asc' },
    },
    {
      name = '⭐ Important',
      matcher = function(i)
        return i.priority == 'A' and (i.deadline or i.scheduled)
      end,
      sort = { by = 'date_nearest', order = 'asc' },
    },
    {
      name = '⏳ Overdue',
      matcher = function(i)
        return i.todo_state ~= 'DONE' and
        ((i.deadline and i.deadline:is_past()) or (i.scheduled and i.scheduled:is_past()))
      end,
      sort = { by = 'date_nearest', order = 'asc' },
    },
    {
      name = '🏠 Personal',
      matcher = function(i)
        return i:has_tag 'personal'
      end,
    },
    {
      name = '💼 Work',
      matcher = function(i)
        return i:has_tag 'work'
      end,
    },
    {
      name = '📆 Upcoming',
      matcher = function(i)
        local days = require('org-super-agenda.config').get().upcoming_days or 10
        local d1 = i.deadline and i.deadline:days_from_today()
        local d2 = i.scheduled and i.scheduled:days_from_today()
        return (d1 and d1 >= 0 and d1 <= days) or (d2 and d2 >= 0 and d2 <= days)
      end,
      sort = { by = 'date_nearest', order = 'asc' },
    },
  },

  -- Defaults & behavior
  upcoming_days = 10,
  hide_empty_groups = true, -- drop blank sections
  keep_order = false,       -- keep original org order (rarely useful)
  allow_duplicates = false, -- if true, an item can live in multiple groups
  group_format = '* %s',    -- group header format
  other_group_name = 'Other',
  show_other_group = false, -- show catch-all section
  show_tags = true,         -- draw tags on the right
  show_filename = true,     -- include [filename]
  heading_max_length = 70,
  persist_hidden = false,   -- keep hidden items across reopen
  view_mode = 'compact',    -- 'classic' | 'compact'

  classic = { heading_order = { 'filename', 'todo', 'priority', 'headline' }, short_date_labels = false, inline_dates = true },
  compact = { filename_min_width = 10, label_min_width = 12 },

  -- Global fallback sort for groups that omit `sort`
  group_sort = { by = 'date_nearest', order = 'asc' },

  -- Popup mode: auto-detected when launched via the tmux script (ORG_SUPER_AGENDA_POPUP=1).
  -- Override only if you use a different popup mechanism.
  popup_mode = {
    enabled = vim.env.ORG_SUPER_AGENDA_POPUP == '1',
    hide_command = 'tmux detach-client',
  },

  debug = false,

  -- Custom views: reusable named views with pre-configured filters
  custom_views = {
    -- work_week = {
    --   name = "Work This Week",
    --   keymap = "<leader>ow",
    --   filter = "tag:work sched>=0 sched<7 -is:done",
    -- },
  },
}
require('headlines').setup {
  org = {
    fat_headlines = false,
  },
  markdown = {
    fat_headlines = false,
  },
}

require('telescope').load_extension 'orgmode'

do
  local ext = require('telescope').extensions.orgmode
  vim.keymap.set('n', '<leader>oh', ext.search_headings, { desc = 'Org headlines' })
  vim.keymap.set('n', '<leader>ot', ext.search_tags, { desc = 'Org tags' })
  vim.keymap.set('n', '<leader>or', ext.refile_heading, { desc = 'Org refile' })
  vim.keymap.set('n', '<leader>oI', ext.insert_link, { desc = 'Org insert link' })
end

vim.api.nvim_create_autocmd('User', {
  pattern = 'TSUpdate',
  callback = function()
    require('nvim-treesitter.parsers').mail = {
      install_info = {
        path = '~/soft/tree-sitter-mail/',
        queries = 'queries/mail',
      },
    }
  end,
})

require('nvim-treesitter')
    .install({ 'c', 'cpp', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash', 'typst',
      'mail' })
    :wait(300000) -- wait max. 5 minutes

require('nvim-treesitter-textobjects').setup {
  select = {
    enable = true,
    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
  },
  move = {
    enable = true,
    set_jumps = true, -- whether to set jumps in the jumplist
  },
  swap = {
    enable = true,
  },
}

for k, v in pairs {
  -- You can use the capture groups defined in textobjects.scm
  ['aa'] = '@parameter.outer',
  ['ia'] = '@parameter.inner',
  ['af'] = '@function.outer',
  ['if'] = '@function.inner',
  ['ac'] = '@class.outer',
  ['ic'] = '@class.inner',
} do
  vim.keymap.set({ 'x', 'o' }, k, function()
    require('nvim-treesitter-textobjects.select').select_textobject(v, 'textobjects')
  end)
end

vim.keymap.set({ 'n', 'x', 'o' }, ']m', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@class.outer', 'textobjects')
end)
-- You can also pass a list to group multiple queries.
vim.keymap.set({ 'n', 'x', 'o' }, ']o', function()
  require('nvim-treesitter-textobjects.move').goto_next_start({ '@loop.inner', '@loop.outer' }, 'textobjects')
end)
-- You can also use captures from other query groups like `locals.scm` or `folds.scm`
vim.keymap.set({ 'n', 'x', 'o' }, ']s', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@local.scope', 'locals')
end)
vim.keymap.set({ 'n', 'x', 'o' }, ']z', function()
  require('nvim-treesitter-textobjects.move').goto_next_start('@fold', 'folds')
end)

vim.keymap.set({ 'n', 'x', 'o' }, ']M', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '][', function()
  require('nvim-treesitter-textobjects.move').goto_next_end('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '[m', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
  require('nvim-treesitter-textobjects.move').goto_previous_start('@class.outer', 'textobjects')
end)

vim.keymap.set({ 'n', 'x', 'o' }, '[M', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@function.outer', 'textobjects')
end)
vim.keymap.set({ 'n', 'x', 'o' }, '[]', function()
  require('nvim-treesitter-textobjects.move').goto_previous_end('@class.outer', 'textobjects')
end)

local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

-- Repeat movement with ; and ,
-- ensure ; goes forward and , goes backward regardless of the last direction
vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

-- vim way: ; goes to the direction you were moving.
-- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
-- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

-- Optionally, make builtin f, F, t, T also repeatable with ; and ,
vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typst', 'mail', 'python', 'bash' }, -- start treesitter highlighting for those file types
  callback = function()
    vim.treesitter.start()
  end,
})
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'mail' },
  callback = function()
    require('which-key').add {
      { '<leader>e', group = '[E]dit header' },
    }
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typst', 'lua', 'python', 'lean' },
  callback = function()
    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '',
      command = ':%s/\\s\\+$//e',
    })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'typst' }, -- enable typst-related treesitter text objects
  callback = function()
    for k, v in pairs {
      -- You can use the capture groups defined in textobjects.scm
      ['i$'] = '@typst_math.inner',
      ['a$'] = '@typst_math.outer',
      ['fn'] = '@typst_function.name',
    } do
      vim.keymap.set({ 'x', 'o' }, k, function()
        require('nvim-treesitter-textobjects.select').select_textobject(v, 'textobjects')
      end)
    end
  end,
})

local augend = require 'dial.augend'
require('dial.config').augends:register_group {
  default = {
    augend.integer.alias.decimal,
    augend.integer.alias.hex,

    augend.constant.new {
      elements = { '₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉' },
      word = false,
      cyclic = true,
    },
    augend.constant.new {
      elements = { '⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹' },
      word = false,
      cyclic = true,
    },
  },
}
vim.keymap.set('n', '<C-a>', function()
  require('dial.map').manipulate('increment', 'normal')
end)
vim.keymap.set('n', '<C-x>', function()
  require('dial.map').manipulate('decrement', 'normal')
end)

vim.api.nvim_create_user_command('Beamer', function()
  vim.cmd 'colorscheme vscode'
  vim.cmd 'set bg=light'
  vim.cmd 'set guifont=DroidSansM_Nerd_Font:b'
  vim.cmd "lua require 'lean.config'().infoview.view_options.show_term_goals = false"
end, { nargs = 0 })
