local wk = require("which-key")

wk.register({
	w = {
		name = "+window",
		s = { ":split<CR>", "Split horizontally" },
		v = { ":vsplit<CR>", "Split vertically" },
	},
	s = {
		name = "+search",
		g = { "<cmd>Telescope live_grep<cr>", "Grep" },
		b = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Buffer" },
	},
	f = {
		name = "+file",
		t = { "<cmd>Neotree toggle<cr>", "Open file tree" },
		f = { "<cmd>Telescope find_files<cr>", "Find File" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
	},
	t = {
		name = "+term",
		w = {
			"execute 'terminal fish' | let b:term_type = 'wind' | startinsert <CR>",
			"Open terminal in window",
		},
		v = {
			"execute 'vnew' | 'terminal fish' | let b:term_type = 'vert' | startinsert <CR>",
			"Open terminal vertically",
		},
		s = {
			"execute 'new' | 'terminal fish' | let b:term_type = 'vert' | startinsert <CR>",
			"Open terminal horizontally",
		},
	},
	e = {
		name = "+error",
		o = { "<cmd>TroubleToggle<CR>", "Open diagonostics" },
		q = { "<cmd>TroubleToggle quickfix<CR>", "Open quickfix" },
	},
}, { prefix = "<leader>" })

vim.api.nvim_create_autocmd("filetype", {
	pattern = "tex",
	callback = function()
		wk.register({
			l = {
				name = "language",
				c = { ":VimtexCompile<CR>", "Compile" },
			},
		}, { prefix = "<leader>" })
		vim.wo.spell = true
		vim.wo.colorcolumn = 100
		vim.bo.tw = 100
	end,
})

-- Make up and down behave better with wrapping lines
vim.keymap.set("n", "j", "v:count ? 'j' : 'gj'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count ? 'k' : 'gk'", { expr = true, silent = true })

-- window resize keys
vim.keymap.set("n", "<left>", "<C-w>h")
vim.keymap.set("n", "<right>", "<C-w>l")
vim.keymap.set("n", "<up>", "<C-w>k")
vim.keymap.set("n", "<down>", "<C-w>j")

vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize +2<CR>")
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize -2<CR>")
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>")
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>")

-- move line
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true })

-- Reselect visual selectation after indent.
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })
