-- use a user-config.lua file to provide your own configuration

local M = {}

-- add any null-ls sources you want here
M.setup_sources = function(b)
	return {
		b.formatting.clang_format,
		b.completion.luasnip,
		b.completion.tags,
		b.formatting.stylua,
		b.formatting.autopep8,
		b.formatting.beautysh,
		b.formatting.cbfmt,
		b.formatting.gofumpt,
		b.formatting.jq,
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
		b.diagnostics.checkmake,
		b.diagnostics.clang_check,
		b.diagnostics.cmake_lint,
		b.diagnostics.markdownlint,
		-- b.diagnostics.pylint,
		b.diagnostics.revive,
		b.diagnostics.xo,
		b.code_actions.cspell,
		b.code_actions.xo,
		b.code_actions.gitrebase,
		b.code_actions.gitsigns,
		b.code_actions.gomodifytags,
		b.code_actions.proselint,
		b.code_actions.refactoring,
		b.hover.dictionary,
	}
end

-- add null_ls sources to auto-install
M.null_ls_ensure_installed = {}

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
		"make",
		"markdown",
	},
}

M.enable_plugins = {
	autosave = false,
}

M.plugins = { "mfussenegger/nvim-dap-python" }

M.user_conf = function()
	require("user.language-server-configs.ls_init")
	require("lsp-zero").setup()
	require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.offsetEncoding = { "utf-16" }
	require("lspconfig").clangd.setup({ capabilities = capabilities })
end

return M
