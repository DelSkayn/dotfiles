local M = {
	"nvimtools/none-ls.nvim",
}

function M.has_formatter(ft)
	local sources = require("null-ls.sources")
	local available = sources.get_available(ft, "NULL_LS_FORMATTING")
	return #available > 0
end

function M.config(options)
	local nls = require("null-ls")
	nls.setup({
		debounce = 150,
		safe_after_format = false,
		sources = {
			nls.builtins.formatting.stylua,
			nls.builtins.formatting.prettier,
		},
		on_attach = options.on_attach,
	})
end

return M
