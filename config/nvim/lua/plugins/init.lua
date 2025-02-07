return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function()
            vim.cmd([[colorscheme tokyonight-night]])
            -- vim.cmd([[colorscheme tokyonight-day]])
        end,
    },
    {
        "folke/which-key.nvim",
        dependencies = {
            "echasnovski/mini.icons"
        },
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require("which-key")
            wk.register(
                {
                    { "<leader>b", group = "Buffer" },
                    { "<leader>c", group = "Code" },
                    { "<leader>f", group = "File" },
                    { "<leader>s", group = "Search" },
                    { "<leader>u", group = "Util" },
                    { "<leader>w", group = "Window" },
                    { "<leader>x", group = "Fix" },
                }
            )
        end,
    },
    {
        "folke/lazydev.nvim",
        opts = {}
    },
    {
        "akinsho/toggleterm.nvim",
        config = function()
            require("toggleterm").setup {
                size = function(term)
                    if term.direction == "horizontal" then
                        return 12
                    elseif term.direction == "vertical" then
                        return math.max(vim.o.columns * 0.3, 40)
                    end
                end
            }
        end,
        cmd = "ToggleTerm",
        keys = {
            { "<leader>t",  "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Open Term" },
            { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "Open Term Vertical" },
            { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>",      desc = "Open Term Floating" },
        }
    },
    {
        "nvim-pack/nvim-spectre",
        dependencies = {
            { "nvim-lua/plenary.nvim" },
        },
        keys = {
            { "<leader>sr", function() require("spectre").toggle() end, desc = "Open Spectre" },
        }
    }
}
