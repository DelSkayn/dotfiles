local mappings = {
	{ key = "v", action = "vsplit" },
	{ key = "s", action = "split" },
}

require("nvim-tree").setup({
	actions = {
		open_file = {
			window_picker = {
				exclude = {
					filetype = {
						"Trouble",
						"terminal",
						"qf",
					},
					buftype = {
						"quickfix",
						"terminal",
					},
				},
			},
		},
	},
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	view = {
		width = 30,
		mappings = {
			list = mappings,
		},
	},
})
