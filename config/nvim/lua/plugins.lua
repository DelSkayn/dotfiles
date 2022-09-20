return require("packer").startup(function()
	use("wbthomason/packer.nvim")

	-- Icons
	use("kyazdani42/nvim-web-devicons")

	-- File tree
	use({
		"kyazdani42/nvim-tree.lua",
		required = "kyazdani42/nvim-web-devicons",
		cmd = "NvimTreeToggle",
		config = function()
			require("config.nvim_tree")
		end,
	})

	-- Status line
	use({
		"hoob3rt/lualine.nvim",
		config = function()
			if vim.g.started_by_firenvim then
				return
			end
			require("config.statusline")
		end,
	})

	-- Line containing open buffers
	use({
		"akinsho/bufferline.nvim",
		config = function()
			if vim.g.started_by_firenvim then
				return
			end
			require("bufferline").setup({
				options = {
					buffer_close_icon = "",
					close_icon = "",
					max_name_length = 14,
					max_prefix_length = 13,
					tab_size = 20,
					diagnostics = "nvim_lsp",
					offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
				},
			})
		end,
	})

	-- Line which key
	use({
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			})
		end,
	})

	use({
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup()
		end,
	})

	-- Improved syntax highlighting
	use({
		"nvim-treesitter/nvim-treesitter",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"bash",
					"lua",
					"rust",
					"python",
					"javascript",
					"cpp",
				},
				highlight = {
					enable = true,
				},
			})
		end,
	})

	-- LSP integration
	use({
		"neovim/nvim-lspconfig",
		config = function()
			require("config.lsp")
		end,
	})
	use({
		"onsails/lspkind-nvim",
		event = "BufEnter",
		config = function()
			require("lspkind").init()
		end,
	})
	use({
		"ray-x/lsp_signature.nvim",
		after = "nvim-lspconfig",
		config = function()
			require("lsp_signature").setup({
				bind = true,
				doc_lines = 2,
				floating_window = true,
				fix_pos = true,
				hint_enable = true,
				hint_prefix = " ",
				hint_scheme = "String",
				hi_parameter = "Search",
				max_height = 22,
				max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
				handler_opts = {
					border = "single", -- double, single, shadow, none
				},
				zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
				padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
			})
		end,
	})
	use({
		"L3MON4D3/LuaSnip",
		config = function()
			require("luasnip").config.set_config({
				history = true,
				updateevents = "TextChanged,TextChangedI",
			})
		end,
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/cmp-buffer",
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
		},
		config = function()
			require("config.nvim_cmp")
		end,
	})
	use({ "saadparwaiz1/cmp_luasnip" })
	use({
		"folke/trouble.nvim",
		requires = "kyazdani42/nvim-web-devicons",
		cmd = {
			"Trouble",
			"TroubleClose",
			"TroubleToggle",
			"TroubleRefresh",
		},
		config = function()
			require("trouble").setup({})
		end,
	})

	use({
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufRead", "BufNewFile" },
		config = function()
			require("config.null-ls")
		end,
	})

	-- Parenthesis highlighting
	use({ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" })

	-- File searcher and manager
	use({
		"nvim-telescope/telescope.nvim",
		requires = {
			{ "nvim-lua/plenary.nvim" },
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				run = "make",
			},
		},
		config = function()
			require("config/telescope")
		end,
	})

	use({ "nvim-telescope/telescope-ui-select.nvim" })

	-- Improved ui
	use({ "stevearc/dressing.nvim" })

	-- Theme
	use({
		"folke/tokyonight.nvim",
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	})

	-- Latex support
	use({
		"lervag/vimtex",
		config = function()
			vim.g.tex_flavor = "latex"
			vim.g.vimtex_view_method = "zathura"
		end,
	})

	-- Rust lang support
	use({
		"rust-lang/rust.vim",
		ft = "rust",
		config = function()
			vim.g.rustfmt_autosave = 1
		end,
	})

	-- Support for postgress syntax
	use({
		"lifepillar/pgsql.vim",
		ft = "sql",
		config = function()
			vim.g["sql_type_default"] = "pgsql"
		end,
	})

	-- Misc languages support
	use({ "cespare/vim-toml" })
	use("tikhomirov/vim-glsl")
	use("blankname/vim-fish")

	-- Browser integration
	use({
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	})
end)
