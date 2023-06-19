local M = {
	"stevearc/overseer.nvim",
	opts = {},
	cmd = "Make",
}

function M.config()
	require("overseer").setup({
		templates = { "builtin", "user.cpp_build" },
	})

	vim.api.nvim_create_user_command("Make", function(params)
		local args = vim.fn.expandcmd(params.args)
		-- Insert args at the '$*' in the makeprg
		local cmd, num_subs = vim.o.makeprg:gsub("%$%*", args)
		if num_subs == 0 then
			cmd = cmd .. " " .. args
		end
		local task = require("overseer").new_task({
			cmd = cmd,
			components = {
				{
					"on_output_quickfix",
					open = not params.bang,
					open_height = 8,
					set_diagnostics = true,
					errorformat = vim.bo.errorformat,
					relative_file_root = vim.fn.getcwd() .. "/..",
				},
				"default",
			},
		})
		task:start()
	end, {
		desc = "Run your makeprg as an Overseer task",
		nargs = "*",
		bang = true,
	})
end

return M
