local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local c = ls.choice_node
local i = ls.insert_node
local f = ls.function_node
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

local get_visual = function(_, parent)
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
  s("diag_transfo_nat", fmt(
  [[#align(center, diagram($
    {F}({X}) edge({a}_{X}, "->") edge("d", {F}(f), "->") & {G}({X}) edge("d", {G}(f), "->", label-side: #left)\
    {F}({Y}) edge({a}_{Y}, "->") & {G}({Y})
    $))
    {exit}]],
    {F = i(1, 'F'),
     G = i(2, 'G'),
     a = i(3, 'α'),
     X = i(4, 'X'),
     Y = i(5, 'Y'),
     exit = i(0)
    },
    {
      repeat_duplicates = true
    })
  ),
  s("diag_adjonction_compat_gauche", fmt(
    [[#align(center, diagram($
      Hom({L} {X}, {Y}) edge(φ_({X}, {Y}), "->") edge("d", – ∘ {L} {f}, "<-") & Hom({X}, {R} {Y}) edge("d", – ∘ {f}, "<-", label-side: #left)\
      Hom({L} {Xp}, {Y}) edge(φ_({Xp}, {Y}), "->") & Hom({Xp}, {R} {Y})
      $))
      {exit}
    ]],
    {L = i(1, 'L'),
     R = i(2, 'R'),
     X = i(3, 'X'),
     Xp = i(4, "X'"),
     Y = i(5, 'Y'),
     f = i(6, 'f'),
     exit = i(0)
    },
    {
      repeat_duplicates = true
    })
  ),
  s("diag_adjonction_compat_droite", fmt(
    [[#align(center, diagram($
      Hom({L} {X}, {Y}) edge(φ_({X}, {Y}), "->") edge("d", {g} ∘ –, "->") & Hom({X}, {R} {Y}) edge("d", {R} {g} ∘ –, "->", label-side: #left)\
      Hom({L} {X}, {Yp}) edge(φ_({X}, {Yp}), "->") & Hom({X}, {R} {Yp})
      $))
      {exit}
    ]],
    {L = i(1, 'L'),
     R = i(2, 'R'),
     X = i(3, 'X'),
     Y = i(4, "Y"),
     Yp = i(5, "Y'"),
     g = i(6, 'g'),
     exit = i(0)
    },
    {
      repeat_duplicates = true
    })
  ),
  s("sec", fmt( -- suite exacte courte
  [[#align(center, diagram($
    0 edge("->") & {A} edge("{i}", "->") & {B} edge("{p}", "->") & {C} edge("->") & 0
    $))
    {exit}]],
    {A = i(1, 'A'),
     B = i(2, 'B'),
     C = i(3, 'C'),
     i = i(4, 'ι'),
     p = i(5, 'π'),
     exit = i(0)
    })),
  s("diag_mayer_vietoris", fmt(
  [[#align(center, diagram($
    H_{p} ({A} ∩ {B}) edge("->") & H_{p} ({A}) ⊕ H_{p} ({B}) edge("->") & H_{p} ({X}) edge("->") & H_{pm} ({A} ∩ {B}) edge("->") & H_{pm} ({A}) ⊕ H_({pm}) ({B})
    $))
    {exit}]],
    {A = i(1, 'A'),
     B = i(2, 'B'),
     X = i(3, 'X'),
     p = i(4, 'p'),
     pm = f(function(args, _, _)
	-- Compute p-1 if p is a literal number, otherwise return "(p - 1)"
	local pm = tonumber(args[1][1])
	if pm ~= nil then
	  return tostring(pm-1)
	else
	  return "(" .. args[1][1] .. " - 1)"
	end
      end, {4}, {}),
     exit = i(0)
    },
    {
      repeat_duplicates = true
    })
  ),
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
  s({trig = "grid", dscr = "Create a grid layout."},
    fmt([[
#grid(columns: ({cols}))[{content}]
{exit}]],
      {
	cols=i(1, "auto, auto"), content=i(2), exit=i(0)
      }
    )
  ),
}
