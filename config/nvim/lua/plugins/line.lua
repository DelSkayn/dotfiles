local M = {
    "hoob3rt/lualine.nvim",
    event = "VeryLazy",
}


local lsp_status = function()
    local msg = "No Active Lsp"
    local buf_ft = vim.opt.ft:get()
    local clients = vim.lsp.get_clients({ bufnr = 0 });
    if next(clients) == nil then
        return msg
    end
    for _, client in ipairs(clients) do
        local filetypes = client.config.filetypes
        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
        end
    end
    return msg
end

function M.config()
    if vim.g.started_by_firenvim then
        return
    end
    require("lualine").setup({
        options = {
            --section_separators={ " ", ""},
            --component_separators = {"",""},
            theme = "tokyonight-night",
            --theme = "material-nvim",
            -- theme = "nord",
            disabled_filetypes = { "NvimTree", "terminal", "Trouble", "neo-tree", "toggleterm" },
        },
        sections = {
            lualine_a = { {
                "mode",
                icon = " ",
            } },
            lualine_b = {
                {
                    "filename",
                    icon = " ",
                    condition = function()
                        return vim.fn.expand("%:t") ~= ""
                    end,
                },
            },
            lualine_c = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn", "info" },
                    symbols = {
                        error = "  ",
                        warn = "  ",
                        info = "  ",
                    },
                },
                {
                    lsp_status,
                    cond = function()
                        return vim.lsp.get_clients({ bufnr = 0 })[1] ~= nil
                    end,
                    icon = " ",
                },
            },
            lualine_x = { "branch" },
            lualine_y = { "filetype" },
            lualine_z = {
                {
                    "progress",
                    icon = " ",
                },
                "location",
            },
        },
        inactive_sections = {
            lualine_a = {
                {
                    "mode",
                    icon = " ",
                },
            },
            lualine_b = {
                {
                    "filename",
                    icon = " ",
                    condition = function()
                        return vim.fn.expand("%:t") ~= ""
                    end,
                },
            },
            lualine_c = {
                {
                    "diagnostics",
                    sources = { "nvim_diagnostic" },
                    sections = { "error", "warn", "info" },
                    symbols = {
                        error = "  ",
                        warn = "  ",
                        info = " ",
                    },
                },
                {
                    lsp_status,
                    cond = function()
                        return next(vim.lsp.get_clients()) ~= nil
                    end,
                    icon = "  ",
                },
            },
            lualine_x = { "branch" },
            lualine_y = { "filetype" },
            lualine_z = {
                {
                    "progress",
                    icon = " ",
                },
                "location",
            },
        },
        extensions = { "quickfix" },
    })
end

return M
