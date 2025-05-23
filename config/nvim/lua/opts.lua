-- File setting default configs

vim.opt.shortmess = "atOIF"
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
vim.opt.hidden = true
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

vim.opt.winminheight = 0
vim.opt.wildmode = { "list:longest", "full" }

vim.opt.listchars = { tab = "→ ", eol = "↵", trail = "·", extends = "↷", precedes = "↶" }

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
