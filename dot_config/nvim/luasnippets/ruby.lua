local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node

local snippets, autosnippets = {}, {}

local remote_pry = s("pryr", {
  -- t("require 'pry'; require 'pry-byebug'; binding.remote_pry"),
  t("require 'pry'; binding.remote_pry"),
})

table.insert(snippets, remote_pry)

return snippets, autosnippets
