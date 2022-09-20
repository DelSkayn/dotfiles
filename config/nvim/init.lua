pcall(require, "impatient")

for _, source in ipairs({
	"plugins",
	"opts",
	"mappings",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.api.nvim_err_writeln("Failed to load " .. source .. "\n\t" .. fault)
	end
end
