-- use a user-config.lua file to provide your own configuration

local M = {}

-- add any null-ls sources you want here
M.setup_sources = function(b)
	return {
		b.formatting.clang_format,
		b.completion.luasnip,
		b.completion.tags,
		b.formatting.stylua,
		b.formatting.cbfmt,
		b.formatting.gofumpt,
		b.formatting.black,
		b.formatting.cmake_format,
		b.formatting.prettierd.with({
			filetypes = {
				"javascript",
				"javascriptreact",
				"typescript",
				"typescriptreact",
				"html",
				"css",
			},
		}),
		b.formatting.verible_verilog_format,
		b.diagnostics.verilator,
		b.diagnostics.checkmake,
		b.diagnostics.cmake_lint,
		b.diagnostics.pylint,
		b.diagnostics.revive,
		b.code_actions.gitrebase,
		b.code_actions.gitsigns,
		b.code_actions.gomodifytags,
		b.code_actions.proselint,
		b.code_actions.refactoring,
		b.hover.dictionary,
	}
end

-- add null_ls sources to auto-install
M.ensure_installed = {
	null_ls = {
		"clangd",
		"codelldb",
		"cspell",
		"css-lsp",
		"debugpy",
		"delve",
		"gofumpt",
		"goimports-reviser",
		"gopls",
		"html-lsp",
		"jq",
		"json-lsp",
		"lua-language-server",
		"prettierd",
		"pyright",
		"rust-analyzer",
		"shfmt",
		"stylua",
		"svlangserver",
		"typescript-language-server",
		"verible",
		"wgsl-analyzer",
	},
	dap = {
		"python",
	},
}

M.formatting_servers = {
	["rust_analyzer"] = { "rust" },
	["null-ls"] = {
		"lua",
		"javascript",
		"javascriptreact",
		"typescript",
		"typescriptreact",
		"html",
		"css",
		"json",
		"python",
		"sh",
		"bash",
		"zsh",
		"go",
		"cpp",
		"c",
		"cmake",
	},
}

M.enable_plugins = {
	autosave = false,
}

M.options = {
	opt = {
		-- swapfile = false,
	},
}

M.plugins = {
	"simrat39/rust-tools.nvim",
	"mfussenegger/nvim-dap-python",
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		dependencies = {
			"zbirenbaum/copilot-cmp",
			config = function()
				require("copilot_cmp").setup()
			end,
		},
		config = function()
			require("user.plugin-configs.copilot")
		end,
	},
}

M.user_conf = function()
	require("user.init")
	vim.g.rust_recommended_style = false
end

return M
