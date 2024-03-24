local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufRead", "BufNewFile" },
}


function M.config()

    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.surrealql = {
      install_info = {
        url = "~/Documents/programming/js/tree-sitter-surrealql", -- local path or git repo
        files = {"src/parser.c"}, -- note that some parsers also require src/scanner.c or src/scanner.cc
        -- optional entries:
        branch = "main", -- default branch in case of git repo if different from master
        generate_requires_npm = false, -- if stand-alone parser without npm dependencies
        requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
      },
      filetype = "surql", -- if filetype does not match the parser name
    }


	require("nvim-treesitter.configs").setup({

		ensure_installed = {
			"bash",
			"lua",
			"rust",
			"python",
			"javascript",
			"cpp",
			"vim",
			"regex",
			"markdown",
			"markdown_inline",
		},
		highlight = {
			enable = true,
		},
	})
end

return M
