return {
	"jose-elias-alvarez/typescript.nvim",
	"ManifTanjim/nui.nvim",
	"folke/which-key.nvim",
	{
		"nvim-telescope/telescope-ui-select.nvim",
		event = "VeryLazy",
	},
	{
		"stevearc/dressing.nvim",
		event = "VeryLazy",
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"lervag/vimtex",
		config = function()
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_view_method = "zathura"
		end,
		event = "VeryLazy",
	},
	{
		"williamboman/mason.nvim",
		cmd = { "Mason" },
	},
	{
		"williamboman/mason-lspconfig.nvim",
	},
}
