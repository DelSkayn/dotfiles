local lsp = {
    "neovim/nvim-lspconfig",
    event = "BufEnter",
    dependencies = {
        { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
        { "folke/neodev.nvim",  opts = {} },
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
    local cmp = require("cmp_nvim_lsp")
    local util = require("util")

    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp.default_capabilities(),
        opts.capabilities or {}
    )

    local servers = opts.servers

    local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
            capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if server_opts.mason == false then
            return
        end

        if opts.setup[server] then
            if opts.setup[server](server, server_opts) then
                return
            end
        elseif opts.setup["*"] then
            if opts.setup["*"](server, server_opts) then
                return
            end
        end
        require("lspconfig")[server].setup(server_opts)
    end

    local mlsp = require("mason-lspconfig")
    local mason_lsp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)

    local ensure_installed = {} ---@type string[]
    for server, server_opts in pairs(servers) do
        if server_opts then
            server_opts = server_opts == true and {} or server_opts
            -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
            if server_opts.mason == false or not vim.tbl_contains(mason_lsp_servers, server) then
                setup(server)
            else
                ensure_installed[#ensure_installed + 1] = server
            end
        end
    end

    mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })

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
