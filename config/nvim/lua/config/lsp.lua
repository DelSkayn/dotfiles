local lspconfig = require("lspconfig")
local bind_buf = require("utils").bind_buf
local bind = require("utils").bind

bind("n", "<leader>ln", vim.lsp.diagnostic.goto_prev, "noremap", "silent")
bind("n", "<leader>lp", vim.lsp.diagnostic.goto_next, "noremap", "silent")
bind("n", "<liader>lq", vim.lsp.diagnostic.set_loclist, "noremap", "silent")

local function on_attach(client, bufnr)
	vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

	local function bind(...)
		bind_buf(bufnr, ...)
	end

	-- require("lsp_signature").on_attach()

	-- Mappings.

	bind("n", "<leader>le", vim.lsp.buf.declaration, "noremap", "silent")
	bind("n", "<leader>ld", vim.lsp.buf.definition, "noremap", "silent")
	bind("n", "K", vim.lsp.buf.hover, "noremap", "silent")
	bind("n", "<leader>li", vim.lsp.buf.implementation, "noremap", "silent")
	bind("n", "<C-k>", vim.lsp.buf.signature_help, "noremap", "silent")
	bind("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "noremap", "silent")
	bind("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "noremap", "silent")
	-- bind("n", "<leader>wl", print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "noremap","silent")
	bind("n", "<leader>lD", vim.lsp.buf.type_definition, "noremap", "silent")
	bind("n", "<leader>lR", vim.lsp.buf.rename, "noremap", "silent")
	bind("n", "<leader>lr", vim.lsp.buf.references, "noremap", "silent")
	bind("n", "<leader>li", vim.lsp.diagnostic.show_line_diagnostics, "noremap", "silent")

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		bind("n", "<leader>f", vim.lsp.buf.formatting, "noremap", "silent")
	elseif client.resolved_capabilities.document_range_formatting then
		bind("n", "<leader>f", vim.lsp.buf.range_formatting, "noremap", "silent")
	end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

lspconfig["rust_analyzer"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		["rust-analyzer"] = {
			procMacro = { enabled = true },
			diagnostics = {
				enable = true,
				disabled = { "unresolved-proc-macro" },
				enableExperimental = true,
			},
		},
	},
})
lspconfig["tsserver"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig["jdtls"].setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

-- replace the default lsp diagnostic symbols
function lspSymbol(name, icon)
	vim.fn.sign_define("LspDiagnosticsSign" .. name, { text = icon, numhl = "LspDiagnosticsDefaul" .. name })
end

lspSymbol("Error", "")
lspSymbol("Warning", "")
lspSymbol("Information", "")
lspSymbol("Hint", "")

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
	virtual_text = {
		prefix = "",
		spacing = 0,
	},
	signs = true,
	underline = true,
	-- set this to true if you want diagnostics to show in insert mode
	update_in_insert = false,
})

-- suppress error messages from lang servers
vim.notify = function(msg, log_level, _opts)
	if msg:match("exit code") then
		return
	end
	if log_level == vim.log.levels.ERROR then
		vim.api.nvim_err_writeln(msg)
	else
		vim.api.nvim_echo({ { msg } }, true, {})
	end
end
