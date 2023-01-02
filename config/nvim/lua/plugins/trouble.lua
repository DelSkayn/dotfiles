local M = {
	"folke/trouble.nvim",
	cmd = {
		"Trouble",
		"TroubleClose",
		"TroubleToggle",
		"TroubleRefresh",
	},
}

function M.config()
	local wk = require("which-key")
	require("trouble").setup({})
end

return M
