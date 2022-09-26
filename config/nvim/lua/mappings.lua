local utils = require("utils")
local bind = utils.bind

bind("n", "<Leader>ff", ":NvimTreeToggle<CR>", "silent", "noremap")

bind("n", "j", 'v:count ? "j" : "gj"', "expr")
bind("n", "k", 'v:count ? "k" : "gk"', "expr")
bind("n", "<Down>", 'v:count ? "j" : "gj"', "expr")
bind("n", "<Up>", 'v:count ? "k" : "gk"', "expr")

bind("v", "<", "<gv")
bind("v", ">", ">gv")

bind("n", "<leader>eo", ":TroubleToggle<CR>")
bind("n", "<leader>eq", ":TroubleToggle quickfix<CR>")

bind("n", "<leader>mc", ":make<CR>")

bind("n", "<S-t>", ":enew<CR>") -- new buffer
bind("n", "<C-t>b", ":tabnew<CR>") -- new tab

-- move between tabs

bind("n", "<TAB>", ":BufferLineCycleNext<CR>")
bind("n", "<S-Tab>", ":BufferLineCyclePrev<CR>")

-- get out of terminal mode
bind("t", "<ESC>", "<C-\\><C-n>")
-- hide a term from within terminal mode
bind("t", "JK", "<C-\\><C-n> :lua require('utils').close_buffer() <CR>")
-- pick a hidden term
bind("n", "<leader>W", ":Telescope terms <CR>")

bind("n", "<leader>ws", ":split<CR>")
bind("n", "<leader>wv", ":vsplit<CR>")


bind("n", "[e", ":cprev<CR>")
bind("n", "]e", ":cnext<CR>")

-- Open terminals
-- TODO this opens on top of an existing vert/hori term, fixme
bind("n", "<leader>tw", ":execute 'terminal fish' | let b:term_type = 'wind' | startinsert <CR>", "silent")
bind(
	"n",
	"<leader>tv",
	":execute 'vnew' | execute 'terminal fish' | let b:term_type = 'vert' | startinsert <CR>",
	"silent"
)
bind(
	"n",
	"<leader>ts",
	":execute 15 .. 'new' | execute  'terminal fish' | let b:term_type = 'hori' | startinsert <CR>",
	"silent"
)

bind("n", "<leader>tf", require("telescope.builtin").find_files, "silent")
bind("n", "<leader>tg", require("telescope.builtin").live_grep, "silent")
bind("n", "<leader>tb", require("telescope.builtin").buffers, "silent")
bind("n", "<leader>th", require("telescope.builtin").help_tags, "silent")

--bind("n","<leader>la",require("telescope.builtin").lsp_code_actions,"silent")
bind("n", "<leader>ls", require("telescope.builtin").lsp_document_symbols, "silent")
bind("n", "<leader>lS", require("telescope.builtin").lsp_workspace_symbols, "silent")
bind("n", "<leader>la", vim.lsp.buf.code_action, "silent")

bind("n", "z=", require("telescope.builtin").spell_suggest)

vim.api.nvim_create_autocmd("filetype", {
	pattern = "rust",
	callback = function()
		bind("n", "<Leader>mc", ":make check<CR>", "silent")
		bind("n", "<Leader>mC", ":make clean<CR>", "silent")
		bind("n", "<Leader>ml", ":make clippy<CR>", "silent")
		bind("n", "<Leader>md", ":make doc<CR>", "silent")
		bind("n", "<Leader>mD", ":make doc --open<CR>", "silent")
		bind("n", "<Leader>mb", ":make build<CR>", "silent")
		bind("n", "<Leader>mt", ":make test<CR>", "silent")
		bind("n", "<Leader>mr", ":make run<CR>", "silent")
	end,
})

vim.api.nvim_create_autocmd("filetype", {
	pattern = "tex",
	callback = function()
		bind("n", "<Leader>mc", ":VimtexCompile<CR>", "silent")
		vim.o.spell = true
		vim.cmd([[set colorcolumn=100]])
		vim.cmd([[set tw=100]])
	end,
})
