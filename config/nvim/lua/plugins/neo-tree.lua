local M = {
	"nvim-neo-tree/neo-tree.nvim",
	cmd = "Neotree",
}

M.dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	{
		"s1n7ax/nvim-window-picker",
		config = function()
			require("window-picker").setup({
				autoselect_one = true,
				include_current = false,
				filter_rules = {
					-- filter using buffer options
					bo = {
						-- if the file type is one of following, the window will be ignored
						filetype = { "neo-tree", "neo-tree-popup", "notify", "Trouble" },

						-- if the buffer type is one of following, the window will be ignored
						buftype = { "terminal", "quickfix" },
					},
				},
				other_win_hl_color = "#e35e4f",
			})
		end,
	},
}

function M.config()
	vim.fn.sign_define("DiagnosticSignError", { text = " ", texthl = "DiagnosticSignError" })
	vim.fn.sign_define("DiagnosticSignWarn", { text = " ", texthl = "DiagnosticSignWarn" })
	vim.fn.sign_define("DiagnosticSignInfo", { text = " ", texthl = "DiagnosticSignInfo" })
	vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticSignHint" })

	require("neo-tree").setup({
		window = {
			width = 25,
			mappings = {
				["S"] = "split_with_window_picker",
				["s"] = "vsplit_with_window_picker",
				["<CR>"] = "open_with_window_picker",
			},
		},
	})
end

return M
