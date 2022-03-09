vim.cmd("set nocompatible");

require("packer").startup(function()
    -- The package manager
    use 'wbthomason/packer.nvim'

    use 'kyazdani42/nvim-web-devicons'

    use 'mhinz/vim-startify'
    -- A completion framework
    use 'hrsh7th/nvim-compe'
    use 'hrsh7th/vim-vsnip'
    use 'neovim/nvim-lspconfig'
    use 'folke/lsp-trouble.nvim'
    use 'glepnir/lspsaga.nvim'

    -- A file tree
    -- use 'preservim/nerdtree'
    use 'kyazdani42/nvim-tree.lua'

    -- The status bar
    --use 'vim-airline/vim-airline'
    use {
        'hoob3rt/lualine.nvim',
        requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use 'romgrk/barbar.nvim'

    -- Better syntax highlighting
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- A theme
    use {"npxbr/gruvbox.nvim", requires = {"rktjmp/lush.nvim"}}
    use 'folke/tokyonight.nvim'

    -- language support
    use 'rust-lang/rust.vim'   
    use 'tikhomirov/vim-glsl'
    use 'ziglang/zig.vim'
    use 'ron-rs/ron.vim'

    use 'liuchengxu/vim-which-key'

    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
end)

require("opts")();
local autofunc = require("autofunc");
local bind = require("bind");

function lsp_on_attach(client,bufnr)
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        hi LspReferenceRead cterm=bold ctermbg=red guibg=#464646
        hi LspReferenceText cterm=bold ctermbg=red guibg=#464646
        hi LspReferenceWrite cterm=bold ctermbg=red guibg=#464646
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
            ]],false);
    end
end

require("nvim-treesitter.configs").setup{
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
        disable = {"python"},
    }
}

local tree_cb = require("nvim-tree.config").nvim_tree_callback
vim.g.nvim_tree_bindings = {
    {key = {"i"}, cb = tree_cb("split")},
    {key = {"s"}, cb = tree_cb("vsplit")},
}
vim.g.nvim_tree_quit_on_open = 1
vim.g.nvim_tree_ignore = { '.git' }

require('lspconfig').rust_analyzer.setup{
    on_attach = lsp_on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            }
        }
    }
}

require('lspconfig').svelte.setup{}

require('lspconfig').pyls.setup{}

require('lspconfig').tsserver.setup{}

require('compe').setup{
    enabled = true,
    source = {
        path = true;
        buffer = true;
        nvim_lsp = true;
        nvim_lua = true;
    }
}

require("lualine").setup{
    options = {theme = 'gruvbox'},
    extensions = {'nvim-tree'},
}

require("trouble").setup{}


local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

-- Use (s-)tab to:
--- move to prev/next item in completion menuone
--- jump to prev/next snippet's placeholder
local tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif vim.fn.call("vsnip#available", {1}) == 1 then
        return t "<Plug>(vsnip-expand-or-jump)"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return vim.fn['compe#complete']()
    end
end
local s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

bind("i","<Tab>",tab_complete,"silent","noremap");
bind("i","<S-Tab>",s_tab_complete,"silent","noremap");

bind("i","<C-Space>",vim.fn["compe#complete"],"silent","noremap");
bind("i","<CR>",function() return vim.fn["compe#confirm"](t"<CR>") end,"silent","noremap");

bind("n","<Leader>ff",":NvimTreeToggle<CR>","silent","noremap");
bind("n","<Leader>mc",":make<CR>","silent");

autofunc("filetype","rust",function()
    bind("n","<Leader>mc",":Cargo check<CR>","silent");
    bind("n","<Leader>mC",":Cargo clean<CR>","silent");
    bind("n","<Leader>ml",":Cargo clippy<CR>","silent");
    bind("n","<Leader>md",":Cargo doc<CR>","silent");
    bind("n","<Leader>mD",":Cargo doc --open<CR>","silent");
    bind("n","<Leader>mb",":Cargo build<CR>","silent");
    bind("n","<Leader>mt",":Cargo test<CR>","silent");
    bind("n","<Leader>mr",":Cargo run<CR>","silent");
    autofunc("BufWritePre","<buffer>",vim.lsp.buf.formatting_sync);
end)

autofunc("filetype","svelte",function()
    vim.opt.tabstop=2
    vim.opt.shiftwidth=2
end)

bind("n","<Leader>ws",":split<CR>","silent","noremap");
bind("n","<Leader>wv",":vsplit<CR>","silent","noremap");
bind("n","<Leader>en",":cn<CR>","silent","noremap");
bind("n","<Leader>ep",":cp<CR>","silent","noremap");

bind("n","<A-,>",":BufferPrevious<CR>","silent","noremap");
bind("n","<A-.>",":BufferNext<CR>","silent","noremap");
bind("n","<A-<>",":BufferMovePrevious<CR>","silent","noremap");
bind("n","<A->>",":BufferMoveNext<CR>","silent","noremap");

bind("n","<A-c>",":BufferClose<CR>","silent","noremap");

bind("n","<A-1>",":BufferGoto  1<CR>","silent","noremap");
bind("n","<A-2>",":BufferGoto  2<CR>","silent","noremap");
bind("n","<A-3>",":BufferGoto  3<CR>","silent","noremap");
bind("n","<A-4>",":BufferGoto  4<CR>","silent","noremap");
bind("n","<A-5>",":BufferGoto  5<CR>","silent","noremap");
bind("n","<A-6>",":BufferGoto  6<CR>","silent","noremap");
bind("n","<A-7>",":BufferGoto  7<CR>","silent","noremap");
bind("n","<A-8>",":BufferGoto  8<CR>","silent","noremap");
bind("n","<A-9>",":BufferGoto  9<CR>","silent","noremap");

bind("n","<Leader>ld",vim.lsp.buf.definition,"silent","noremap","cmd");
bind("n","<Leader>li",vim.lsp.buf.implementation,"silent","noremap","cmd");
bind("n","<Leader>le",vim.lsp.buf.declaration,"silent","noremap","cmd");
bind("n","<Leader>lf",vim.lsp.buf.formatting,"silent","noremap","cmd");
bind("n","<Leader>ls",vim.lsp.buf.workspace_symbol,"silent","noremap","cmd");
bind("n","<Leader>lR",require("lspsaga.rename").rename,"silent","noremap","cmd");
bind("n","<Leader>lr",require("lspsaga.provider").lsp_finder,"silent","noremap","cmd");
bind("n","<Leader>la",require("lspsaga.codeaction").code_action,"silent","noremap","cmd");
bind("v","<Leader>la",require("lspsaga.codeaction").range_code_action,"silent","noremap","cmd");
bind("v","<Leader>lD",require("lspsaga.hover").render_hover_doc,"silent","noremap","cmd");

bind("n","<Leader>fs",require("telescope.builtin").find_files,"noremap","cmd");
bind("n","<Leader>fg",require("telescope.builtin").live_grep,"noremap","cmd");
bind("n","<Leader>fb",require("telescope.builtin").buffers,"noremap","cmd");
bind("n","<Leader>fh",require("telescope.builtin").help_tags,"noremap","cmd");

bind("n","<Leader>eo","<cmd>LspTroubleToggle<CR>","noremap","silent");

bind("n","<Leader>ec",":e $MYVIMRC<CR>","noremap");

bind("t","<Esc>","<C-\\><C-n>","silent","noremap");

bind("v","<","<gv","noremap","silent");
bind("v",">",">gv","noremap","silent");

vim.cmd[[autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl]]

-- vim.g.airline_powerline_fonts = 1;
-- vim.g["airline#extensions#tabline#enabled"] = 1;

vim.o.background = "dark";
vim.cmd[[colorscheme gruvbox]];
vim.g.gruvbox_italicize_string = 1;

--vim.g.tokyonight_style = "night"
--vim.g.tokyonight_italic_comments = true
--vim.g.tokyonight_dark_sidebar = true
--vim.g.tokyonight_sidebars = {"qf","vista_kind","terminal","packer"}

--vim.cmd[[colorscheme tokyonight]]
