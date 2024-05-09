 local augend = require("dial.augend")
 require("dial.config").augends:register_group{
   default = {
     augend.integer.alias.decimal,
     augend.integer.alias.hex,

     augend.constant.new{
       elements = {'₀', '₁', '₂', '₃', '₄', '₅', '₆', '₇', '₈', '₉' },
       word = false,
       cyclic = true,
     },
     augend.constant.new{
       elements = { '⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹' },
       word = false,
       cyclic = true,
     },
   },
 }
 vim.keymap.set("n", "<C-a>", function()
     require("dial.map").manipulate("increment", "normal")
 end)
 vim.keymap.set("n", "<C-x>", function()
     require("dial.map").manipulate("decrement", "normal")
 end)
