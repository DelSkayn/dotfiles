local M = {
	"neovim/nvim-lspconfig",
	name = "lsp",
	event = "BufReadPre",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
	},
}

local servers = {
	tsserver = {},
	rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true },
				checkOnSave = {
					command = "clippy",
					extraArgs = { "--no-deps" },
				},
			},
		},
	},
}

function M.format()
	if vim.lsp.buf.format then
		vim.lsp.buf.format()
	else
		vim.lsp.buf.formatting_sync()
	end
end

local function on_attach_formatting(client, bufnr)
	local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
	local enable = false

	local is_null = client.name == "null-ls"
	local nls = require("plugins.null-ls")

	if nls.has_formatter(ft) then
		enable = is_null
	else
		enable = not is_null
	end

	client.server_capabilities.documentFormattingProvider = enable

	if client.server_capabilities.documentFormattingProvider then
		vim.cmd([[
        augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("plugins.lspconfig").format()
        augroup END
        ]])
	end
end

local function on_attach_keymap(client, bufnr)
	local wk = require("which-key")

	local map = {
		["<leader>"] = {
			l = {
				name = "+lang",
				R = { vim.lsp.buf.rename, "Rename" },
				r = { vim.lsp.buf.references, "Lookup References" },
				a = { vim.lsp.buf.code_action, "Code Actions" },
			},
		},

		["[d"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
		["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" },

		["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
		["gD"] = { vim.lsp.buf.definition, "Goto Declaration" },
		["gT"] = { vim.lsp.buf.type_definition, "Goto Type" },
		["K"] = { vim.lsp.buf.hover, "Hover" },
		["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Help" },
	}
	wk.register(map)
end

function M.config()
	local nls = require("plugins.null-ls")

	require("mason").setup()
	require("mason-lspconfig").setup()

	local function on_attach(client, bufnr)
		on_attach_formatting(client, bufnr)
		on_attach_keymap(client, bufnr)
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

	local options = {
		on_attach = on_attach,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
	}

	for server, opts in pairs(servers) do
		opts = vim.tbl_deep_extend("force", {}, options, opts or {})
		if server == "tsserver" then
			require("typescript").setup({ server = opts })
		else
			require("lspconfig")[server].setup(opts)
		end
	end

	nls.setup(options)
end

return M
