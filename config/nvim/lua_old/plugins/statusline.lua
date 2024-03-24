local M = {
	"hoob3rt/lualine.nvim",
	event = "VeryLazy",
}

local lsp_status = function()
	local msg = "No Active Lsp"
	local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
	local clients = vim.lsp.get_active_clients()
	if next(clients) == nil then
		return msg
	end
	for _, client in ipairs(clients) do
		local filetypes = client.config.filetypes
		if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
			return client.name
		end
	end
	return msg
end

local lsp_progress = function()
	local Lsp = vim.lsp.util.get_progress_messages()[1]
	if Lsp ~= nil then
		-- vim.defer_fn(function()
		-- require("lualine").refresh()
		-- end, 250)
	end
	return Lsp
			and string.format(
				" %%<%s %s %s (%s%%%%) ",
				((Lsp.percentage or 0) >= 70 and { "", "", "" } or { "", "", "" })[math.floor(
					vim.loop.hrtime() / 12e7
				) % 3 + 1],
				Lsp.title or "",
				Lsp.message or "",
				Lsp.percentage or 0
			)
		or ""
end

function M.config()
	if vim.g.started_by_firenvim then
		return
	end
	require("lualine").setup({
		options = {
			--section_separators={ " ", ""},
			--component_separators = {"",""},
			theme = "tokyonight",
			--theme = "material-nvim",
			-- theme = "nord",
			disabled_filetypes = { "NvimTree", "terminal", "Trouble", "neo-tree" },
		},
		sections = {
			lualine_a = { {
				"mode",
				icon = " ",
			} },
			lualine_b = {
				{
					"filename",
					icon = " ",
					condition = function()
						return vim.fn.expand("%:t") ~= ""
					end,
				},
			},
			lualine_c = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info" },
					symbols = {
						error = "  ",
						warn = "  ",
						info = "  ",
					},
				},
				{
					lsp_progress,
					cond = function()
						return vim.lsp.util.get_progress_messages()[1] ~= nil
					end,
				},
				{
					lsp_status,
					cond = function()
						return next(vim.lsp.get_active_clients()) ~= nil
					end,
					icon = " ",
				},
			},
			lualine_x = { "branch" },
			lualine_y = { "filetype" },
			lualine_z = {
				{
					"progress",
					icon = " ",
				},
				"location",
			},
		},
		inactive_sections = {
			lualine_a = {
				{
					"mode",
					icon = " ",
				},
			},
			lualine_b = {
				{
					"filename",
					icon = " ",
					condition = function()
						return vim.fn.expand("%:t") ~= ""
					end,
				},
			},
			lualine_c = {
				{
					"diagnostics",
					sources = { "nvim_diagnostic" },
					sections = { "error", "warn", "info" },
					symbols = {
						error = "  ",
						warn = "  ",
						info = " ",
					},
				},
				{
					lsp_status,
					cond = function()
						return next(vim.lsp.get_active_clients()) ~= nil
					end,
					icon = "  ",
				},
			},
			lualine_x = { "branch" },
			lualine_y = { "filetype" },
			lualine_z = {
				{
					"progress",
					icon = " ",
				},
				"location",
			},
		},
		extensions = { "quickfix" },
	})
end

return M
