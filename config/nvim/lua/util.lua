local M = {}

function M.erro(msg, name)
	vim.notify(msg, vim.log.levels.ERROR, { title = name or "init.lua" })
end

function M.warn(msg, name)
	vim.notify(msg, vim.log.levels.WARN, { title = name or "init.lua" })
end

function M.info(msg, name)
	vim.notify(msg, vim.log.levels.INFO, { title = name or "init.lua" })
end

function M.debug(msg, name)
	vim.notify(msg, vim.log.levels.DEBUG, { title = name or "init.lua" })
end

function M.trace(msg, name)
	vim.notify(msg, vim.log.levels.TRACE, { title = name or "init.lua" })
end

return M
