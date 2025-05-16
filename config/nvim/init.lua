local entry_files = {
    "opts",
    "autocmd",
    "keymap",
    "plugin",
    "lsp",
}

for _, source in ipairs(entry_files) do
    local ok, fault = pcall(require, source)
    if not ok then
        vim.notify("Failed to load config file `" .. source .. "`:\n\t" .. fault, vim.log.levels.ERROR)
    end
end
