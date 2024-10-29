return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      local s = luasnip.snippet
      local i = luasnip.insert_node
      local fmt = require("luasnip.extras.fmt").fmt

      luasnip.add_snippets("all", {
        s(
          { name = "group comment", trig = "gc" },
          fmt(
            [[
        /* ---------------------------
         *     {1}
         * --------------------------- */
            ]],
            {
              i(1, "Group"),
            }
          )
        ),
      })
    end,
  },
}
