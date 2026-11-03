local ls = require("luasnip")

local s = ls.snippet
local f = ls.function_node

return {
  s({ trig = "date", desc = "Today's date (YYYY-MM-DD)" }, f(function()
    return os.date("%Y-%m-%d")
  end)),
}
