local wk = require("which-key")

wk.register({
    w = {
        name = "+window",
        s = { ":split<CR>", "Split horizontally" },
        v = { ":vsplit<CR>", "Split vertically" },
    },
    s = {
        name = "+search",
    },
    f = {
        name = "+file",
    },
    x = {
        name = "+diagnostics",
        l = { "<cmd>lopen<cr>", "Location" },
        q = { "<cmd>copen<cr>", "Quickfix" },
    },
    t = {
        name = "+term",
        w = {
            function()
                require("nvterm.terminal").toggle("float")
            end,
            "Open terminal in window",
        },
        v = {
            function()
                require("nvterm.terminal").toggle("vertical")
            end,
            "Open terminal vertically",
        },
        s = {
            function()
                require("nvterm.terminal").toggle("horizontal")
            end,
            "Open terminal horizontally",
        },
    },
    e = { "<cmd>Neotree toggle<cr>", "Explore file tree" },
}, { prefix = "<leader>" })

vim.api.nvim_create_autocmd("filetype", {
    pattern = "tex",
    callback = function()
        wk.register({
            l = {
                name = "language",
                c = { ":VimtexCompile<CR>", "Compile" },
                g = { ":VimtexView<CR>", "Show text" },
            },
        }, { prefix = "<leader>" })
        vim.wo.spell = true
        vim.wo.colorcolumn = 100
        vim.bo.tw = 100
    end,
})

-- Make up and down behave better with wrapping lines
vim.keymap.set("n", "j", "v:count ? 'j' : 'gj'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count ? 'k' : 'gk'", { expr = true, silent = true })

-- Move window
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })


-- window resize keys
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize +2<CR>", { desc = "Grow window vertically" })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize -2<CR>", { desc = "Shrink window vertically" })
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { desc = "Grow window horizontally" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { desc = "Shrink window horizontally" })

-- move line
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Swap line down" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Swap selection down" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true, desc = "Swap line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Swap line up" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Swap selection down" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true, desc = "Swap line up" })

vim.keymap.set("n", "z=", "<cmd>Telescope spell_suggest<CR>", { silent = true, desc = "Suggest spelling" })

-- Reselect visual selection after indent.
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Make search map always move in a single direction
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Enable escaping terminal with Esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

vim.api.nvim_create_autocmd("filetype", {
    pattern = "rust",
    callback = function()
        wk.register({
            m = {
                name = "make",
                m = {
                    name = "run with make",
                    c = { "<cmd>Make check<CR>", "Check" },
                    C = { "<cmd>Make clippy<CR>", "Clippy" },
                    n = { "<cmd>Make clean<CR>", "Clean" },
                    d = { "<cmd>Make doc<CR>", "Document" },
                    b = { "<cmd>Make build<CR>", "Build" },
                    t = { "<cmd>Make test<CR>", "test" },
                    r = { "<cmd>Make run<CR>", "run" },
                },
                c = { "<cmd>Cargo check<CR>", "Check" },
                C = { "<cmd>Cargo clippy<CR>", "Clippy" },
                n = { "<cmd>Cclean<CR>", "Clean" },
                d = { "<cmd>Cdoc<CR>", "Document" },
                b = { "<cmd>Cbuild<CR>", "Build" },
                t = { "<cmd>Ctest<CR>", "test" },
                r = { "<cmd>Crun<CR>", "run" },
            },
        }, { prefix = "<leader>" })
    end,
})
