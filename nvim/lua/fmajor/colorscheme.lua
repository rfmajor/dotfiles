-- Default options:
require("kanagawa").setup({
	compile = true, -- enable compiling the colorscheme
	undercurl = true, -- enable undercurls
	commentStyle = { italic = true },
	functionStyle = {},
	keywordStyle = { italic = true },
	statementStyle = { bold = true },
	typeStyle = {},
	transparent = false, -- do not set background color
	dimInactive = true, -- dim inactive window `:h hl-NormalNC`
	terminalColors = true, -- define vim.g.terminal_color_{0,17}
	colors = { -- add/modify theme and palette colors
		palette = {},
		theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
	},
	background = {
		dark = "dragon",
		light = "lotus",
	},
	overrides = function(colors) -- add/modify highlights
		return {}
	end,
})

local dark = "kanagawa-dragon"
local light = "catppuccin-latte"

-- setup must be called before loading
if vim.fn.has("macunix") == 1 then
	local command = "defaults read -g AppleInterfaceStyle 2>&1"
	local handle = io.popen(command)
	if handle then
		local result = handle:read("*a")
		result = string.gsub(result, "%s+", "")
		handle:close()
		if result ~= "Dark" then
			vim.cmd("colorscheme " .. light)
		else
			vim.cmd("colorscheme " .. dark)
		end
	else
		vim.cmd("colorscheme " .. dark)
	end
else
	vim.cmd("colorscheme " .. dark)
end
