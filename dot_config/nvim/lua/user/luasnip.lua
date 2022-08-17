local status_ok, ls = pcall(require, "luasnip")
if not status_ok then
    return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

ls.config.set_config({
    -- Update more often, :h events for more info.
    update_events = "TextChanged,TextChangedI",
    -- treesitter-hl has 100, use something higher (default is 200).
    ext_base_prio = 300,
    -- minimal increase in priority.
    ext_prio_increase = 1,
    delete_check_events = "TextChanged",
})

ls.add_snippets("all", {
    s(
        { name = "group comment", trig = "gc" },
        fmt(
            [[
        /* ---------------------------
         *     {1} 
         * --------------------------- */ 
    ]]       ,
            {
                i(1, "Group"),
            }
        )
    ),
    s(
        { name = "console.log +", trig = "cll" },
        fmt([[ console.log('{2}', {1}) ]], {
            i(1, "variable"),
            rep(1),
        })
    ),
})
