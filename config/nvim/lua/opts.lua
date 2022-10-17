vim.o.shell = "/usr/bin/bash"

vim.opt.shortmess = "atOI"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.scrolljump = 5
vim.opt.scrolloff = 3
vim.opt.wrap = false
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.autowrite = true
--vim.opt.mousehide = true
vim.opt.hidden = true
--vim.opt.t_Co = 256
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.showmatch = true
vim.opt.matchtime = 5
vim.opt.report = 0
vim.opt.linespace = 0
vim.opt.pumheight = 20
vim.opt.expandtab = true
vim.opt.guifont = "monospace"

--vim.opt.t_ut=""

vim.opt.winminheight = 0
vim.opt.wildmode = { "list:longest", "full" }

vim.opt.listchars = { tab = "→ ", eol = "↵", trail = "·", extends = "↷", precedes = "↶" }

--vim.opt.whichwrap = vim.opt.whichwrap .. "<,>,h,l"

--vim.opt.termencoding="utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "ucs-bom", "gb18030", "gbk", "gb2313", "cp936" }

vim.opt.wildignore:append({ "*swp", "*.class", "*.pyc", "*.png", "*.jpg", "*.gif", "*.zip" })
vim.opt.wildignore:append({ "*/tmp/*", "*.o", "*.obj", "*.so" })

vim.opt.mouse = "a"

vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false

vim.opt.background = "dark"
vim.opt.cursorline = true
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.fillchars = { stl = " ", stlnc = " ", fold = " ", vert = "▎", eob = " " }
vim.opt.directory = "/tmp//,."
vim.opt.backupdir = "/tmp//,."
vim.opt.undodir = "/tmp//,."

vim.opt.clipboard = { "unnamedplus", "unnamed" }
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.termguicolors = true

vim.g.mapleader = " "
vim.opt.completeopt = { "menuone", "noselect" }

if vim.g.started_by_firenvim then
	vim.api.nvim_set_option("laststatus", 0)
end

local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

-- Don't show any numbers inside terminals
vim.cmd([[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]])

vim.api.nvim_create_autocmd("BufWritePre",{
    pattern = "*",
    callback = vim.lsp.buf.format
})

vim.api.nvim_create_autocmd("filetype",{
    pattern = "javascript,typescript,javascriptreact,typescriptreact",
    callback = function()
        vim.opt.shiftwidth = 2
        vim.opt.tabstop = 2
        vim.opt.softtabstop = 2
    end
})

-- disable statusline on some ft
vim.api.nvim_create_autocmd("BufEnter,BufWinEnter,WinEnter,CmdwinEnter,TermEnter", {
	pattern = "*",
	callback = function()
		hidden = { "NvimTree", "terminal", "Trouble" }
		local api = vim.api
		local buftype = api.nvim_buf_get_option(0, "ft")
		if vim.tbl_contains(hidden, buftype) then
			api.nvim_set_option("laststatus", 0)
			return
		end
		if vim.g.started_by_firenvim then
			api.nvim_set_option("laststatus", 0)
		else
			api.nvim_set_option("laststatus", 2)
		end
	end,
})
