local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufRead", "BufNewFile" },
}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"lua",
			"rust",
			"python",
			"javascript",
			"cpp",
			"vim",
			"regex",
			"markdown",
			"markdown_inline",
		},
		highlight = {
			enable = true,
		},
	})
end

return M
