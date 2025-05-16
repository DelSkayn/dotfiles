local util = require("util")

local capabilities = require('blink.cmp').get_lsp_capabilities();
vim.lsp.config('*', {
    capabilities
})


vim.lsp.config('lua_ls', {
    settings = {
        Lua = {
            workspace = {
                checkThirdParty = false,
            },
            codeLens = {
                enable = true,
            },
            completion = {
                callSnippet = "Replace",
            },
        },
    }
})

vim.lsp.enable('rust_analyzer');
vim.lsp.enable('lua_ls');


util.on_attach(function(client, bufnr)
    -- format on save
    if not client:supports_method('textDocument/willSaveWaitUntil')
        and client:supports_method('textDocument/formatting') then
        vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({ bufnr, id = client.id, timeout_ms = 1000 })
            end
        })
    end


    --  Define LSP keybindings.
    vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
    vim.keymap.set("n", "gd", function()
        require("telescope.builtin").lsp_definitions({ reuse_win = true })
    end, { desc = "Goto Definition" })
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
    vim.keymap.set("n", "gI", function()
        require("telescope.builtin").lsp_implementations({ reuse_win = true })
    end, { desc = "Goto Implementation" })
    vim.keymap.set("n", "gy", function()
        require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
    end, { desc = "Goto T[y]pe Definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
    vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
    vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.refresh, { desc = "Run Codelens" })
    vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
end)
