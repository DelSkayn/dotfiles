require("lualine").setup {
    options = {
        --section_separators={ " ", ""},
        --component_separators = {"",""},
        theme = "tokyonight",
        --theme = "material-nvim",
        -- theme = "nord",
        disabled_filetypes={"NvimTree","terminal", "Trouble"}
    },
    sections = {
        lualine_a = {{
            'mode',
            icon = " "
        }},
        lualine_b = {
            {
                "filename",
                icon = " ",
                condition = function()
                    return vim.fn.expand('%:t') ~= ""
                end
            } 
        },
        lualine_c = {
            {
                "diagnostics",
                sources = {'nvim_diagnostic'},
                sections = {'error','warn','info'},
                symbols = {
                    error = "  ",
                    warn = "  ",
                    info = "  ",
                }
            },{
                function()
                    local msg = 'No Active Lsp'
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then return msg end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                condition = function()
                    return next(vim.lsp.get_active_clients()) ~= nil
                end,
                icon = '  ',
            }
        },
        lualine_x = {'branch'},
        lualine_y = {"filetype"},
        lualine_z = {
            {
                "progress",
                icon = " "
            }, "location"}
    },
    inactive_sections = {
        lualine_a = {
            {
                'mode',
                icon = " "
            }
        },
        lualine_b = {
            {
                "filename",
                icon = " ",
                condition = function()
                    return vim.fn.expand('%:t') ~= ""
                end
            } 
        },
        lualine_c = {
            {
                "diagnostics",
                sources = {'nvim_diagnostic'},
                sections = {'error','warn','info'},
                symbols = {
                    error = "  ",
                    warn = "  ",
                    info = ' ',
                }
            },{
                function()
                    local msg = 'No Active Lsp'
                    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
                    local clients = vim.lsp.get_active_clients()
                    if next(clients) == nil then return msg end
                    for _, client in ipairs(clients) do
                        local filetypes = client.config.filetypes
                        if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                            return client.name
                        end
                    end
                    return msg
                end,
                condition = function()
                    return next(vim.lsp.get_active_clients()) ~= nil
                end,
                icon = '  ',
            }
        },
        lualine_x = {'branch'},
        lualine_y = {"filetype"},
        lualine_z = {
            {
                "progress",
                icon = " "
            }, "location"}
    },
    extensions = {'quickfix'}
}
