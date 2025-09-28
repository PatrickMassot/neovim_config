local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"

-- our picker function: addresses
local addresses = function(opts)
  opts = opts or {}
  local addresses = {}
  if vim.uv.fs_stat("/home/pmassot/.config/mutt/addresses") then
    for line in io.lines("/home/pmassot/.config/mutt/addresses") do
        addresses[#addresses + 1] = line
    end
  end
  pickers.new(opts, {
    prompt_title = "Addresse",
    finder = finders.new_table {
      results = addresses
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        -- print(vim.inspect(selection))
        vim.api.nvim_put({ selection[1] }, "", false, true)
      end)
      return true
    end,
  }):find()
end

return addresses
