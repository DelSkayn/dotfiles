local rustaceanvim = {
    "mrcjkb/rustaceanvim",
    version = '^4',
    lazy = false,
    opts = {
        server = {
            on_attach = function(_, bufnr)
                vim.keymap.set("n", "<leader>cR", function()
                    vim.cmd.RustLsp("codeAction")
                end, { desc = "Code Action", buffer = bufnr })
                vim.keymap.set("n", "<leader>dr", function()
                    vim.cmd.RustLsp("debuggables")
                end, { desc = "Debuggables", buffer = bufnr })
            end,
        }
    },
    config = function(_, opts)
        vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
    end,
}

return {}
