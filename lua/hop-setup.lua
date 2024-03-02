local hop = require('hop')
vim.keymap.set('', '<LocalLeader>s', function()
    hop.hint_char2({ direction = nil, current_line_only = false })
  end, {remap=true})
