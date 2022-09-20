require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.eslint,
		require("null-ls").builtins.diagnostics.fish,
		require("null-ls").builtins.completion.spell,
		require("null-ls").builtins.diagnostics.glslc,
		--require("null-ls").builtins.diagnostics.luacheck,
	},
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			vim.api.nvim_create_autocmd("BufWritePre", {
				desc = "Auto format before save",
				pattern = "<buffer>",
				callback = vim.lsp.buf.formatting_sync,
			})
		end
	end,
})
