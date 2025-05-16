local mason = {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
}


local lsp = {
    "neovim/nvim-lspconfig",
    event = "BufEnter",
    dependencies = {
        { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
        { "folke/lazydev.nvim", ft = "lua",      opts = {} },
        "neovim/nvim-lspconfig",
        mason,
        "williamboman/mason-lspconfig.nvim",
    },
}

lsp.config = function()
    require("neoconf").setup()
    require("mason").setup()
    require("mason-lspconfig").setup {
        ensure_installed = { "lua_ls" }
    }
end


local M = { lsp, mason }

return M
