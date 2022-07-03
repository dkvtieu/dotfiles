local status_ok, hydra = pcall(require, "hydra")
if not status_ok then
    return
end

local splits = require("smart-splits")

-- Window resizing
hydra({
    name = "window_resizing",
    hint = [[
 ^^    Size   ^^
 ^^-----------^^
 ^   _<C-k>_   ^
 _<C-h>_ _<C-l>_
 ^   _<C-j>_   ^   
 ^ _=_ equalize^   
]]   ,
    config = {
        timeout = 4000,
        hint = {
            border = "rounded",
            position = "middle",
        },
    },
    mode = "n",
    body = "<C-w>",
    heads = {
        {
            "<C-h>",
            function()
                splits.resize_left(2)
            end,
        },
        {
            "<C-j>",
            function()
                splits.resize_down(2)
            end,
        },
        {
            "<C-k>",
            function()
                splits.resize_up(2)
            end,
        },
        {
            "<C-l>",
            function()
                splits.resize_right(2)
            end,
        },
        { "=", "<C-w>=", { desc = "equalize" } },
        { "q", nil, { exit = true, desc = false } },
        { "<Esc>", nil, { exit = true, desc = false } },
    },
})
