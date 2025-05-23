local M = {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
        "MunifTanjim/nui.nvim",
        "3rd/image.nvim",              -- Optional image support in preview window: See `# Preview Mode` for more information
        {
            's1n7ax/nvim-window-picker',
            version = '2.*',
            config = function()
                require 'window-picker'.setup({
                    filter_rules = {
                        include_current_win = false,
                        autoselect_one = true,
                        -- filter using buffer options
                        bo = {
                            -- if the file type is one of following, the window will be ignored
                            filetype = { 'neo-tree', "neo-tree-popup", "notify", "trouble", "noice" },
                            -- if the buffer type is one of following, the window will be ignored
                            buftype = { 'terminal', "quickfix" },
                        },
                    },
                })
            end,
        }
    },
    keys = {
        { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle file tree" }
    }
}

function M.config()
    require("neo-tree").setup({
        window = {
            width = 25,
            mappings = {
                ["s"] = "split_with_window_picker",
                ["v"] = "vsplit_with_window_picker",
                ["<CR>"] = "open_with_window_picker",
            },
        },
    })
end

return M
