local cache = nil
local function builtin(name, opts)
    return function()
        if cache == nil then
            cache = require("telescope.builtin")
        end
        cache[name](opts or {})
    end
end


return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim"
    },
    cmd = "Telescope",
    keys = {
        { "<leader>/",       builtin("live_grep"),                                          desc = "Grep (root dir)" },
        { "<leader>:",       "<cmd>Telescope command_history<cr>",                          desc = "Command History" },
        { "<leader><space>", builtin("find_files"),                                         desc = "Find Files (root dir)" },
        -- find
        { "<leader>fb",      "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        -- { "<leader>fc", Util.telescope.config_files(), desc = "Find Config File" },
        --{ "<leader>ff", Util.telescope("files"), desc = "Find Files (root dir)" },
        -- { "<leader>fF", Util.telescope("files", { cwd = false }), desc = "Find Files (cwd)" },
        { "<leader>fg",      "<cmd>Telescope git_files<cr>",                                desc = "Find Files (git-files)" },
        { "<leader>fr",      "<cmd>Telescope oldfiles<cr>",                                 desc = "Recent" },
        --{ "<leader>fR", Util.telescope("oldfiles", { cwd = vim.loop.cwd() }), desc = "Recent (cwd)" },
        -- git
        { "<leader>gc",      "<cmd>Telescope git_commits<CR>",                              desc = "commits" },
        { "<leader>gs",      "<cmd>Telescope git_status<CR>",                               desc = "status" },
        -- search
        { '<leader>s"',      "<cmd>Telescope registers<cr>",                                desc = "Registers" },
        { "<leader>sa",      "<cmd>Telescope autocommands<cr>",                             desc = "Auto Commands" },
        { "<leader>sb",      "<cmd>Telescope current_buffer_fuzzy_find<cr>",                desc = "Buffer" },
        { "<leader>sc",      "<cmd>Telescope command_history<cr>",                          desc = "Command History" },
        { "<leader>sC",      "<cmd>Telescope commands<cr>",                                 desc = "Commands" },
        { "<leader>sd",      "<cmd>Telescope diagnostics bufnr=0<cr>",                      desc = "Document diagnostics" },
        { "<leader>sD",      "<cmd>Telescope diagnostics<cr>",                              desc = "Workspace diagnostics" },
        { "<leader>sg",      builtin("live_grep"),                                          desc = "Grep (root dir)" },
        -- { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
        { "<leader>sh",      "<cmd>Telescope help_tags<cr>",                                desc = "Help Pages" },
        { "<leader>sH",      "<cmd>Telescope highlights<cr>",                               desc = "Search Highlight Groups" },
        { "<leader>sk",      "<cmd>Telescope keymaps<cr>",                                  desc = "Key Maps" },
        { "<leader>sM",      "<cmd>Telescope man_pages<cr>",                                desc = "Man Pages" },
        { "<leader>sm",      "<cmd>Telescope marks<cr>",                                    desc = "Jump to Mark" },
        { "<leader>so",      "<cmd>Telescope vim_options<cr>",                              desc = "Options" },
        { "<leader>sR",      "<cmd>Telescope resume<cr>",                                   desc = "Resume" },
        { "<leader>sw",      builtin("grep_string", { word_match = "-w" }),                 desc = "Word (root dir)" },
        --{ "<leader>sw", builtin("grep_string"), desc = "Word (root dir)" },
        { "<leader>sW",      builtin("grep_string", { cwd = false, word_match = "-w" }),    desc = "Word (cwd)" },
        { "<leader>sw",      builtin("grep_string"),                                        mode = "v",                       desc = "Selection (root dir)" },
        { "<leader>sW",      builtin("grep_string", { cwd = false }),                       mode = "v",                       desc = "Selection (cwd)" },
        { "<leader>uC",      builtin("colorscheme"),                                        desc = "Colorscheme with preview" },
        { "<leader>ss",      builtin("lsp_document_symbols"),                               desc = "Goto Symbol", },
        { "<leader>sS",      builtin("lsp_dynamic_workspace_symbols"),                      desc = "Goto Symbol (Workspace)" },
    },
    opts = function()
        local actions = require("telescope.actions")

        local open_with_trouble = require("trouble.sources.telescope").open;

        local find_files_no_ignore = function()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            builtin("find_files", { no_ignore = true, default_text = line })()
        end
        local find_files_with_hidden = function()
            local action_state = require("telescope.actions.state")
            local line = action_state.get_current_line()
            builtin("find_files", { hidden = true, default_text = line })()
        end

        return {
            defaults = {
                prompt_prefix = " ",
                selection_caret = " ",
                -- open files in the first window that is an actual file.
                -- use the current window if no other window is available.
                get_selection_window = function()
                    local wins = vim.api.nvim_list_wins()
                    table.insert(wins, 1, vim.api.nvim_get_current_win())
                    for _, win in ipairs(wins) do
                        local buf = vim.api.nvim_win_get_buf(win)
                        if vim.bo[buf].buftype == "" then
                            return win
                        end
                    end
                    return 0
                end,
                mappings = {
                    i = {
                        ["<c-t>"] = open_with_trouble,
                        ["<a-i>"] = find_files_no_ignore,
                        ["<a-h>"] = find_files_with_hidden,
                        ["<C-Down>"] = actions.cycle_history_next,
                        ["<C-Up>"] = actions.cycle_history_prev,
                        ["<C-f>"] = actions.preview_scrolling_down,
                        ["<C-b>"] = actions.preview_scrolling_up,
                    },
                    n = {
                        ["<c-t>"] = open_with_trouble,
                        ["q"] = actions.close,
                    },
                },
            },
        }
    end
}
