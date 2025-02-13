local mod_cmp = {
    "hrsh7th/nvim-cmp",
    version = false, -- last release is way too old
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
    },
}

function mod_cmp.opts()
    local cmp = require("cmp")
    local defaults = require("cmp.config.default")();
    return {
        completion = {
            completeopt = "menu,menuone,noinster"
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
            ["<C-b>"] = cmp.mapping.scroll_docs(-4),
            ["<C-f>"] = cmp.mapping.scroll_docs(4),
            ["<C-Space>"] = cmp.mapping.complete(),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<S-CR>"] = cmp.mapping.confirm({
                behavior = cmp.ConfirmBehavior.Replace,
                select = true,
            }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ["<C-CR>"] = function(fallback)
                cmp.abort()
                fallback()
            end,
        }),
        sources = cmp.config.sources({
            { name = "nvim_lsp" },
            { name = "path" },
        }, {
            { name = "buffer" },
        }),
        sorting = defaults.sorting
    }
end

function mod_cmp.config(_, opts)
    for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
    end
    require("cmp").setup(opts)
end

local snip = {
    "L3MON4D3/LuaSnip",
    dependencies = {
        {
            "nvim-cmp",
            opts = function(_, opts)
                opts.snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end
                }
                table.insert(opts.sources, { name = "luasnip" })
            end
        }
    },
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",

    keys = {
        {
            "<tab>",
            function()
                return require("luasnip").jumpable(1) and "<Plug>luasnip-jump-next" or "<tab>"
            end,
            expr = true,
            silent = true,
            mode = "i",
        },
        { "<tab>",   function() require("luasnip").jump(1) end,  mode = "s" },
        { "<s-tab>", function() require("luasnip").jump(-1) end, mode = { "i", "s" } },
    },
}

return { mod_cmp, snip }
