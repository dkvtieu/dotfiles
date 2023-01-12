local status_ok, hydra = pcall(require, "hydra")
if not status_ok then
	return
end

local splits = require("smart-splits")

-- Window resizing
hydra({
	name = "window_resizing",
	hint = [[
 ^^    Size     ^^
 ^^-------------^^
 ^   _<C-A-k>_   ^
 _<C-A-h>_ _<C-A-l>_
 ^   _<C-A-j>_   ^   
 ^ _=_ equalize^   
]],
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
			"<C-A-h>",
			function()
				splits.resize_left(2)
			end,
		},
		{
			"<C-A-j>",
			function()
				splits.resize_down(2)
			end,
		},
		{
			"<C-A-k>",
			function()
				splits.resize_up(2)
			end,
		},
		{
			"<C-A-l>",
			function()
				splits.resize_right(2)
			end,
		},
		{ "=", "<C-w>=", { desc = "equalize" } },
		{ "q", nil, { exit = true, desc = false } },
		{ "<Esc>", nil, { exit = true, desc = false } },
	},
})
