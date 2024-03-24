-- Don't show any numbers inside terminals
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "term://*",
    callback = function()
        vim.wo.number = false
        vim.bo.filetype = "terminal"
    end,
})

-- Change js shift width
vim.api.nvim_create_autocmd("filetype", {
    pattern = "javascript,typescript,javascriptreact,typescriptreact,svelte",
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
    end,
})

-- configurations for latex only
vim.api.nvim_create_autocmd("filetype", {
    pattern = "tex",
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
        vim.opt.colorcolumn = 100
    end,
})

-- disable statusline on some ft
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter", "WinEnter", "CmdwinEnter", "TermEnter" }, {
    pattern = "*",
    callback = function()
        local hidden = { "NvimTree", "terminal", "Trouble" }
        local buftype = vim.opt.ft:get()
        if vim.tbl_contains(hidden, buftype) then
            vim.opt.laststatus = 0
            return
        end
        vim.opt.laststatus = 2
    end,
})
