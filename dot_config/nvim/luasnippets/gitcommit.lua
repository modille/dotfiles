local ls = require("luasnip")

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmta = require("luasnip.extras.fmt").fmta

local snippets, autosnippets = {}, {}

local commit_msg = s(
  "commit-msg",
  fmta(
    [[<type><scope>: <description>

<optional-body>
]],
    {
      type = c(1, {
        t("fix"),
        t("feat"),
        t("build"),
        t("chore"),
        t("ci"),
        t("docs"),
        t("style"),
        t("refactor"),
        t("test"),
        t("perf"),
      }),
      scope = c(2, {
        i(1, ""),
        {
          t("("),
          i(1, "scope"),
          t(")"),
        },
      }),
      description = i(3, "short-description"),
      ["optional-body"] = i(4, "# longer description"),
    }
  )
)
table.insert(snippets, commit_msg)

return snippets, autosnippets
