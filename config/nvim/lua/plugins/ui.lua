local noice = {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		"rcarriga/nvim-notify",
	},
	config = function()
		require("noice").setup({
			lsp = {
				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
				override = {
					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
					["vim.lsp.util.stylize_markdown"] = true,
					["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
				},
			},
			-- you can enable a preset for easier configuration
			presets = {
				bottom_search = true, -- use a classic bottom cmdline for search
				command_palette = true, -- position the cmdline and popupmenu together
				long_message_to_split = true, -- long messages will be sent to a split
				inc_rename = false, -- enables an input dialog for inc-rename.nvim
				lsp_doc_border = false, -- add a border to hover docs and signature help
			},
		})
	end,
}

local dressing = {
	"stevearc/dressing.nvim",
	lazy = true,
	init = function()
		vim.ui.select = function(...)
			require("lazy").load({ plugins = { "dressing.nvim" } })
			vim.ui.select(...)
		end
	end,
}

local trouble = {
	"folke/trouble.nvim",
	keys = {
		{
			"<leader>xx",
			function()
				require("trouble").toggle("diagnostics")
			end,
			desc = "Toggle trouble",
		},
		{
			"<leader>xe",
			function()
				require("trouble").toggle("diagnostics"):filter({ severity = vim.diagnostic.severity.ERROR })
			end,
			desc = "Toggle trouble errors only",
		},
		{
			"]t",
			function()
				require("trouble").next({ jump = true })
			end,
			desc = "Next trouble",
		},
		{
			"[t",
			function()
				require("trouble").prev({ jump = true })
			end,
			desc = "Previous trouble",
		},
	},
}

local todo = {
	"folke/todo-comments.nvim",
	cmd = { "TodoTrouble", "TodoTelescope" },
	config = true,
    -- stylua: ignore
    keys = {
        { "]c",         function() require("todo-comments").jump_next() end, desc = "Next todo comment" },
        { "[c",         function() require("todo-comments").jump_prev() end, desc = "Previous todo comment" },
        { "<leader>xc", "<cmd>TodoTrouble<cr>",                              desc = "Todo (Trouble)" },
        { "<leader>xC", "<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>",      desc = "Todo/Fix/Fixme (Trouble)" },
        { "<leader>st", "<cmd>TodoTelescope<cr>",                            desc = "Todo" },
        { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>",    desc = "Todo/Fix/Fixme" },
    },
}

return { noice, dressing, trouble, todo }
