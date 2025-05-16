local blink = {
    "saghen/blink.cmp",
    dependencies = "rafamadriz/friendly-snippets",
    version = "*",
    build = "cargo +nightly build --release",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        keymap = {
            preset = "super-tab",
        },
        signature = { enabled = true },
        enabled = function()
            return vim.bo.buftype ~= "prompt"
        end,
        sources = {
            default = { "lazydev", "lsp", "path", "snippets", "buffer" },
            providers = {
                lazydev = {
                    name = "LazyDev",
                    module = "lazydev.integrations.blink",
                    -- make lazydev completions top priority (see `:h blink.cmp`)
                    score_offset = 100,
                },
            },
        },
    },
}

blink.config = function()
    vim.diagnostic.config({
        virtual_lines = true,
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = " ",
                [vim.diagnostic.severity.WARN] = " ",
                [vim.diagnostic.severity.INFO] = " ",
                [vim.diagnostic.severity.HINT] = " ",
            }
        }
    })
end

return { blink }
