-- See https://github.com/theHamsta/nvim-semantic-tokens/blob/master/doc/nvim-semantic-tokens.txt
local mappings = {
  ['@lsp.type.variable'] = 'Identifier'
}

for from, to in pairs(mappings) do
  vim.cmd.highlight('link ' .. from .. ' ' .. to)
end

local group = vim.api.nvim_create_augroup('LeanAutoOpenClose', {})

vim.api.nvim_create_autocmd('BufWinEnter', {
  group = group,
  pattern = {'*.lean'},
  callback = function ()
    require('lean.infoview').open()
  end
})

vim.api.nvim_create_autocmd({'BufWinLeave', 'QuitPre'}, {
  group = group,
  pattern = {'*.lean'},
  callback = function ()
    local infoview = require('lean.infoview').get_current_infoview()
    if infoview then
      local tab_wins = vim.api.nvim_tabpage_list_wins(0)
      local lean_wins = vim.tbl_filter(function ()
        local buf_ft = vim.bo.filetype
        return buf_ft == 'lean'
      end, tab_wins)
      if #lean_wins <= 1 then
        infoview:close()
      end
    end
  end
})
