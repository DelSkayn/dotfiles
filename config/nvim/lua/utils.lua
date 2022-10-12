-- module to easier create keybinds

local M = {}

M.bind = function(mode, lhs, rhs, ...)
	-- for every optional argument we make a field in the opts table
	-- the field will be set to true
	-- we do this because the neovim api wants {thing1: true, thing2: true, ...}
	local opt = {}
	for _, a in ipairs({ ... }) do
		opt[a] = true
	end

	if type(rhs) ~= "function" and type(rhs) ~= "string" then
		print("invalid binding!!!")
		print(type(rhs))
		print(debug.traceback())
	end

	return vim.keymap.set(mode, lhs, rhs, opt)
end

M.bind_buf = function(buf, mode, lhs, rhs, ...)
	-- for every optional argument we make a field in the opts table
	-- the field will be set to true
	-- we do this because the neovim api wants {thing1: true, thing2: true, ...}
	local opt = { buffer = buf }
	for _, a in ipairs({ ... }) do
		opt[a] = true
	end

	-- if we pass in a lua function
	if type(rhs) ~= "function" and type(rhs) ~= "string" then
		print("invalid binding!!!")
		print(type(rhs))
		print(debug.traceback())
		return
	end

	return vim.keymap.set( mode, lhs, rhs, opt)
end

return M
