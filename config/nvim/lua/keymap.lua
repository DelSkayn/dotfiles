-- file with basic key bindings and rebindings which are always availeble


-- Make up and down behave better with wrapping lines
vim.keymap.set("n", "j", "v:count ? 'j' : 'gj'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count ? 'k' : 'gk'", { expr = true, silent = true })

-- Move window
vim.keymap.set("n", "<C-h>", "<C-w>h", { silent = true, desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { silent = true, desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { silent = true, desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { silent = true, desc = "Move to right window" })

-- Resize window
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", { desc = "Grow window horizontally" })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", { desc = "Shrink window horizontally" })
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { desc = "Grow window vertically" })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { desc = "Shrink window vertically" })


-- move line
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { silent = true, desc = "Swap line down" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true, desc = "Swap selection down" })
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi", { silent = true, desc = "Swap line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { silent = true, desc = "Swap line up" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true, desc = "Swap selection down" })
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi", { silent = true, desc = "Swap line up" })

-- Reselect visual selection after indent.
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })

-- Make search map always move in a single direction
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- move buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to other buffer" })

-- Also clear search with esc
vim.keymap.set({ "n", "i" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear search" })

-- Enable escaping terminal with Esc
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")


-- Enable escaping terminal with Esc
vim.keymap.set("n", "<leader>fn", "<cmd>enew<cr>", { desc = "Create a new file" })

vim.keymap.set("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location list" })
vim.keymap.set("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix list" })


vim.keymap.set("n", "<leader>ws", "<C-W>s", { desc = "Split window", remap = true })
vim.keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Split window vertical", remap = true })
vim.keymap.set("n", "<leader>wq", "<C-W>c", { desc = "Close window", remap = true })
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })

vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
    local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    severity = severity and vim.diagnostic.severity[severity] or nil
    return function()
        go({ severity = severity })
    end
end
vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- undo breakpoints.
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")
