local lsp = {
    "neovim/nvim-lspconfig",
    event = "BufEnter",
    dependencies = {
        { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
        { "folke/neodev.nvim",  opts = {} },
        "neovim/nvim-lspconfig",
        "mason.nvim",
        "williamboman/mason-lspconfig.nvim"
    },
    opts = {
        servers = {
            lua_ls = {
                -- mason = false, -- set to false if you don't want this server to be installed with mason
                -- Use this to add any additional keymaps
                -- for specific lsp servers
                ---@type LazyKeysSpec[]
                -- keys = {},
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
                },
            },
        },
        setup = {}
    }
}

lsp.config = function(_, opts)
    require("neoconf").setup()
    require("neodev").setup({
        library = { plugins = { "nvim-dap-ui" }, types = true }
    })
    require("mason").setup()
    require("mason-lspconfig").setup({
        ensure_installed = opts.ensure_installed or {},
    })

    local lspconfig = require("lspconfig")
    local util = require("util")

    require("mason-lspconfig").setup_handlers {
        function(server_name)
            local config = opts.servers[server_name] or {}
            if config.mason == nil or config.mason == true then
                config.mason = true
                lspconfig[server_name].setup(require('blink.cmp').get_lsp_capabilities(config))
            end
        end,
    }

    for server, config in pairs(opts.servers) do
        if not config.mason then
            config.capabilities = require('blink.cmp').get_lsp_capabilities(config.capabilities)
            lspconfig[server].setup(config)
        end
    end

    util.on_attach(function()
        vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", { desc = "Lsp Info" })
        vim.keymap.set("n", "gd", function() require("telescope.builtin").lsp_definitions({ reuse_win = true }) end,
            { desc = "Goto Definition" })
        vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", { desc = "References" })
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
        vim.keymap.set("n", "gI", function() require("telescope.builtin").lsp_implementations({ reuse_win = true }) end,
            { desc = "Goto Implementation" })
        vim.keymap.set("n", "gy", function() require("telescope.builtin").lsp_type_definitions({ reuse_win = true }) end,
            { desc = "Goto T[y]pe Definition" })
        vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover" })
        vim.keymap.set("n", "gK", vim.lsp.buf.signature_help, { desc = "Signature Help" })
        vim.keymap.set("i", "<c-k>", vim.lsp.buf.signature_help, { desc = "Signature Help" })
        vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
        vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, { desc = "Run Codelens" })
        vim.keymap.set("n", "<leader>cc", vim.lsp.codelens.refresh, { desc = "Run Codelens" })
        vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "Rename" })
    end)

    util.on_attach(function(client, bufnr)
        local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })

        if require("plugins.null-ls").has_formatter(ft) then
            if client.name ~= "null-ls" then
                client.server_capabilities.documentFormattingProvider = false
            end
        end

        if client.server_capabilities.documentFormattingProvider then
            local id = vim.api.nvim_create_augroup("LspFormat", { clear = false })
            vim.api.nvim_clear_autocmds({
                group = id,
                buffer = bufnr,
            })
            vim.api.nvim_create_autocmd({ "BufWritePre" }, {
                group = id,
                buffer = bufnr,
                callback = function()
                    require("plugins.lsp").format()
                end
            })
        end
    end
    )
end

local mason = {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    opts = {
        ensure_installed = {
            "stylua",
            "shfmt",
            "rust-analyzer",
            "json-lsp"
            -- "flake8",
        },
    },
    ---@param opts MasonSettings | {ensure_installed: string[]}
    config = function(_, opts)
        require("mason").setup(opts)
        local mr = require("mason-registry")
        local function ensure_installed()
            for _, tool in ipairs(opts.ensure_installed) do
                local p = mr.get_package(tool)
                if not p:is_installed() then
                    p:install()
                end
            end
        end
        if mr.refresh then
            mr.refresh(ensure_installed)
        else
            ensure_installed()
        end
    end,
}

local M = { lsp, mason };

function M.format()
    if vim.lsp.buf.format then
        vim.lsp.buf.format()
    else
        vim.lsp.buf.formatting_sync()
    end
end

return M
