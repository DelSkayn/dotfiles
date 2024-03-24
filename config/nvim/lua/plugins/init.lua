return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        config = function()
            vim.cmd([[colorscheme tokyonight]])
            -- vim.cmd([[colorscheme tokyonight-day]])
        end,
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
            local wk = require("which-key")
            wk.register({
                c = { name = "+Code" },
                b = { name = "+Buffer" },
                f = { name = "+File" },
                w = { name = "+Window" },
                x = { name = "+Fix" },
                s = { name = "+Search" },
                u = { name = "+Util" },
            }, { prefix = "<leader>" })
        end,
    },
    {
        "folke/neodev.nvim",
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
            { "nvim-pack/plenary.nvim" },
        },
        keys = {
            { "<leader>sr", function() require("spectre").toggle() end, desc = "Open Spectre" },
        }
    }
}
