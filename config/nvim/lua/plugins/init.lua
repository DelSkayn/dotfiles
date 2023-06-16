return {
	"jose-elias-alvarez/typescript.nvim",
	"MunifTanjim/nui.nvim",
	{
		"rust-lang/rust.vim",
		ft = "rust",
	},
	"folke/which-key.nvim",
	{
		"NvChad/nvterm",
		config = function()
			require("nvterm").setup()
		end,
	},
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
			-- vim.cmd([[colorscheme tokyonight-day]])
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
