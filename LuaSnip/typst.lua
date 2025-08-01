local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
-- local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local rep = require("luasnip.extras").rep

local function arrow()
  return {t'"->"', t'"->>"', t'"hook->"', t'"=>"', t'"==>"', t'"|->"'}
end

local function dash()
  return {t'', t', "dashed"'}
end

local get_visual = function(args, parent)
  if (#parent.snippet.env.LS_SELECT_RAW > 0) then
    return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
  else  -- If LS_SELECT_RAW is empty, return a blank insert node
    return sn(nil, i(1))
  end
end

return {
  s("diag_square", fmt(
    [[
#align(center, diagram($
  {A} edge({a1f}, {a1k}{d1}) edge("d", {a2f}, {a2k}{d2}) & {B} edge("d", {a3f}, {a3k}{d3}, label-side: #left)\
  {C} edge({a4f}, {a4k}{d4}) & {D}
  $))
{exit}]],
    {A = i(1, '"top left"'),
     B = i(2, '"top right"'),
     C = i(3, '"bottom left"'),
     D = i(4, '"bottom right"'),
     a1f = i(5, '"top map"'),
     a2f = i(6, '"left map"'),
     a3f = i(7, '"right map"'),
     a4f = i(8, '"bottom map"'),
     a1k = c(9, arrow()),
     a2k = c(10, arrow()),
     a3k = c(11, arrow()),
     a4k = c(12, arrow()),
     d1 = c(13, dash()),
     d2 = c(14, dash()),
     d3 = c(15, dash()),
     d4 = c(16, dash()),
     exit = i(0)})),
  s("diag_two_squares", fmt(
    [[
#align(center, diagram($
  {A} edge({f1}, {f1k}) edge("d", {g1}, {g1k}) & {B} edge({f2}, {f2k}) edge("d", {g2}, {g2k}) & {C} edge("d", {g3}, {g3k}, label-side: #left)\
  {D} edge({h1}, {h1k}) & {E} edge({h2}, {h2k}) & {F}

  $))
{exit}]],
    {A = i(1, '"top left"'),
     B = i(2, '"top center"'),
     C = i(3, '"top right"'),
     D = i(4, '"bottom left"'),
     E = i(5, '"bottom center"'),
     F = i(6, '"bottom right"'),
     f1 = i(7, '"top left map"'),
     f2 = i(8, '"top right map"'),
     g1 = i(9, '"left down map"'),
     g2 = i(10, '"center down map"'),
     g3 = i(11, '"right down map"'),
     h1 = i(12, '"bottom left map"'),
     h2 = i(13, '"bottom right map"'),
     f1k = c(14, arrow()),
     f2k = c(15, arrow()),
     g1k = c(16, arrow()),
     g2k = c(17, arrow()),
     g3k = c(18, arrow()),
     h1k = c(19, arrow()),
     h2k = c(20, arrow()),
     exit = i(0)})),
  s("diag_lift", fmt(
    [[
#align(center, diagram($
  {A} edge({f1}, {a1}{d1}) edge("d", {f2}, {a2}{d2}) & {B} \
  {C} edge("ur", {f3}, {a3}{d3}, label-side: #right)
  $))
{exit}]],
    {A=i(1, '"top left"'), B=i(2, '"top right"'), C=i(3, '"bottom"'),
      f1=i(4, '"top map"'), f2=i(5, '"left map"'), f3=i(6, '"diagonal map"'),
      a1 = c(7, arrow()), a2 = c(8, arrow()), a3 = c(9, arrow()),
      d1 = c(10, dash()), d2 = c(11, dash()), d3 = c(12, dash()),
      exit = i(0)
    })
  ),
  s("diag_delta", fmt(
    [[
#align(center, diagram($
  & {A} edge("dl", {a1f}, {a1k}{d1}) edge("d", {a2f}, {a2k}{d2}, label-sep: #0.05em) edge("dr", {a3f}, {a3k}{d3}, label-side: #left)& \
  {B} edge({a4f}, {a4k}{d4}, label-side: #right)  & {C} edge({a5f}, {a5k}{d5}, label-side: #right) & {D}
  $))
{exit}]],
    {A = i(1, '"top"'),
     B = i(2, '"bottom left"'),
     C = i(3, '"bottom center"'),
     D = i(4, '"bottom right"'),
     a1f = i(5, '"diag left map"'),
     a2f = i(6, '"center map"'),
     a3f = i(7, '"diag right map"'),
     a4f = i(8, '"bottom left"'),
     a5f = i(9, '"bottom right"'),
     a1k = c(10, arrow()),
     a2k = c(11, arrow()),
     a3k = c(12, arrow()),
     a4k = c(13, arrow()),
     a5k = c(14, arrow()),
     d1 = c(15, dash()),
     d2 = c(16, dash()),
     d3 = c(17, dash()),
     d4 = c(18, dash()),
     d5 = c(19, dash()),
     exit = i(0)})),
  s("thm", fmt([[
#{}[
  {}
]
{}]], {i(1), i(2), i(0)})),
  s({trig = "center", dscr = "Center current visual selection."},
    fmt([[
#align(center)[{}]
{}]],
      {
	d(1, get_visual), i(0)
      }
    )
  ),
}
