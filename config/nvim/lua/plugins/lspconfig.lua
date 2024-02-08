local M = {
    "neovim/nvim-lspconfig",
    name = "lsp",
    event = "BufReadPre",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
}


local function get_project_rustanalyzer_settings()
    local handle = io.open(vim.fn.resolve(vim.fn.getcwd() .. '/./.rust-analyzer.json'))
    if not handle then
        return {}
    end
    local out = handle:read("*a")
    handle:close()
    local config = vim.json.decode(out)
    if type(config) == "table" then
        return config
    end
    return {}
end

local default_rust_analyzer_settings = {
    check = {
        command = "clippy",
        features = "all",
        -- extraArgs = { "--no-deps", "--target-dir", "/tmp/rust-analyzer-check" }
    }
}

local servers = {
    tsserver = {},
    rust_analyzer = {
        settings = {
            ["rust-analyzer"] = vim.tbl_deep_extend(
                "force",
                default_rust_analyzer_settings,
                get_project_rustanalyzer_settings(),
                {}
            )
        },
    },
    pyright = {},
    svelte = {},
}

function M.format()
    if vim.lsp.buf.format then
        vim.lsp.buf.format()
    else
        vim.lsp.buf.formatting_sync()
    end
end

local function on_attach_formatting(client, bufnr)
    local ft = vim.api.nvim_buf_get_option(bufnr, "filetype")
    local enable = false

    local is_null = client.name == "null-ls"
    local nls = require("plugins.null-ls")

    if nls.has_formatter(ft) then
        enable = is_null
    else
        enable = not is_null
    end

    client.server_capabilities.documentFormattingProvider = enable

    if client.server_capabilities.documentFormattingProvider then
        vim.cmd([[
        augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("plugins.lspconfig").format()
        augroup END
        ]])
    end
end

local function on_attach_keymap(client, bufnr)
    local wk = require("which-key")

    local map = {
        ["<leader>"] = {
            l = {
                name = "+lang",
                R = { vim.lsp.buf.rename, "Rename" },
                r = { vim.lsp.buf.references, "Lookup References" },
                a = { vim.lsp.buf.code_action, "Code Actions" },
            },
        },

        ["[d"] = { vim.diagnostic.goto_prev, "Prev Diagnostic" },
        ["]d"] = { vim.diagnostic.goto_next, "Next Diagnostic" },

        ["gd"] = { vim.lsp.buf.definition, "Goto Definition" },
        ["gD"] = { vim.lsp.buf.definition, "Goto Declaration" },
        ["gT"] = { vim.lsp.buf.type_definition, "Goto Type" },
        ["K"] = { vim.lsp.buf.hover, "Hover" },
        ["<C-k>"] = { vim.lsp.buf.signature_help, "Signature Help" },
    }
    wk.register(map)
end

function M.config()
    require("mason").setup()

    local function on_attach(client, bufnr)
        on_attach_formatting(client, bufnr)
        on_attach_keymap(client, bufnr)
    end

    local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        require("cmp_nvim_lsp").default_capabilities()
    );

    local options = {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        },
    }

    local handlers = {
        function(server_name)
            local tmp = require("lspconfig")[server_name];
            -- print(vim.inspect(tmp));
            tmp.setup(options)
        end,
    }

    for server, opts in pairs(servers) do
        opts = vim.tbl_deep_extend("force", {}, options, opts or {})
        -- print(vim.inspect(opts));
        if server == "tsserver" then
            handlers[server] = function()
                require("typescript").setup({ server = opts })
            end
        else
            handlers[server] = function()
                require("lspconfig")[server].setup(opts)
            end
        end
    end

    require("mason-lspconfig").setup { handlers = handlers }
end

return M
