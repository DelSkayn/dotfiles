return require("packer").startup(function()
    use 'wbthomason/packer.nvim'

    use "kyazdani42/nvim-web-devicons"

    use {
        'kyazdani42/nvim-tree.lua',
        required = 'kyazdani42/nvim-web-devicons',
        cmd = "NvimTreeToggle",
        config = function()
            local g = vim.g
            local tree_cb = require("nvim-tree.config").nvim_tree_callback
            local mappings = {
                { key = "v", cb = tree_cb "vsplit"},
                { key = "s", cb = tree_cb "split"},
            }

            g.nvim_tree_root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }

            g.nvim_tree_show_icons = {
                git = 1,
                folders = 1,
                files = 1,
                -- folder_arrows= 1
            }

            g.nvim_tree_window_picker_exclude = {
                filetype ={
                    "Trouble",
                    "terminal",
                    "qf"
                },
                buftype = {
                    "quickfix"
                }
            }

            require('nvim-tree').setup{
                diagnostics = {
                    enable = true,
                    icons = {
                        hint = "",
                        info = "",
                        warning = "",
                        error = "",
                    }
                },
                view = {
                    width = 25,
                    mappings = {
                        list = mappings,
                    },
                }
            }
        end,
    }

    use {
        "hoob3rt/lualine.nvim",
        config = function()
            require("statusline")
        end,
    }

    use {
        "akinsho/nvim-bufferline.lua",
        config = function()
            require("bufferline").setup {
                options = {
                    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
                    buffer_close_icon = "",
                    modified_icon = "",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    max_name_length = 14,
                    max_prefix_length = 13,
                    tab_size = 20,
                    show_tab_indicators = true,
                    enforce_regular_tabs = false,
                    view = "multiwindow",
                    show_buffer_close_icons = true,
                    separator_style = "thin",
                    always_show_bufferline = true,
                    custom_filter = function(buf_number)
                        -- Func to filter out our managed/persistent split terms
                        local present_type, type = pcall(function()
                            return vim.api.nvim_buf_get_var(buf_number, "term_type")
                        end)

                        if present_type then
                            if type == "vert" then
                                return false
                            elseif type == "hori" then
                                return false
                            else
                                return true
                            end
                        else
                            return true
                        end
                    end,
                },
            }
        end,
    }

    use {
        "nvim-treesitter/nvim-treesitter",
        event = {"BufRead","BufNewFile"},
        config = function()
            require("nvim-treesitter.configs").setup{
                ensure_installed = {
                    "bash",
                    "lua",
                    "rust",
                    "python",
                    "javascript",
                    "cpp"
                },
                highlight = {
                    enable = true,
                }
            }
        end
    }


    use {
        "neovim/nvim-lspconfig",
        config = function()
            require("lsp_config")
        end,
    }

    use {
        "onsails/lspkind-nvim",
        event = "BufEnter",
        config = function()
            require("lspkind").init()
        end,
    }

    use {
        "ray-x/lsp_signature.nvim",
        after = "nvim-lspconfig",
        config = function()
            require("lsp_signature").setup {
                bind = true,
                doc_lines = 2,
                floating_window = true,
                fix_pos = true,
                hint_enable = true,
                hint_prefix = " ",
                hint_scheme = "String",
                hi_parameter = "Search",
                max_height = 22,
                max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
                handler_opts = {
                    border = "single", -- double, single, shadow, none
                },
                zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
                padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
            }
        end,
    }

    use {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip").config.set_config{
                history = true,
                updateevents = "TextChanged,TextChangedI",
            }
        end,
    }

    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "hrsh7th/cmp-buffer",
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
        },
        config = function()
            require("nvim_cmp")
        end,
    }

    use { "saadparwaiz1/cmp_luasnip" }

    use {
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        cmd = {
            "Trouble",
            "TroubleClose",
            "TroubleToggle",
            "TroubleRefresh"
        },
        config = function()
            require("trouble").setup{}
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                run = "make",
            },
        },
        config = function()
            require("telescoope")
        end
    }


    use 'folke/tokyonight.nvim'

    use { 
        'lervag/vimtex',
        config = function()
            vim.g.tex_flavor='latex'
            vim.g.vimtex_view_method='zathura'
        end
    }

    -- Language support 
    --
    use { 'rust-lang/rust.vim'}
    use 'cespare/vim-toml'
    use 'tikhomirov/vim-glsl'
    use 'blankname/vim-fish'

    -- use 'marko-cerovac/material.nvim'
    --use 'shaunsingh/nord.nvim'
end)
