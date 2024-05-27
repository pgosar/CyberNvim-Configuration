require("user.language-server-configs.ls_init")
local lsp_ok, lsp_zero = pcall(require, "lsp-zero")
if lsp_ok then
	lsp_zero.setup()
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.offsetEncoding = { "utf-16" }
	require("lspconfig").clangd.setup({ capabilities = capabilities })
end

local dap_ok, _ = pcall(require, "nvim-dap")
if dap_ok then
	require("dap-python").setup("~/.virtualenvs/debugpy/bin/python")
end

HOME_PATH = os.getenv("HOME") .. "/"
MASON_PATH = HOME_PATH .. ".local/share/nvim/mason/packages/"
local codelldb_path = MASON_PATH .. "codelldb/extension/adapter/codelldb"
local liblldb_path = MASON_PATH .. "codelldb/extension/lldb/lib/liblldb.so"

local rust_ok, rt = pcall(require, "rust-tools")
if rust_ok and lsp_ok then
	rt.setup({
		server = {
			on_attach = function(_, bufnr)
				-- Hover actions
				vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			end,
		},
		dap = {
			adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
		},
	})
end

require("user.plugin-configs.treesitter")

vim.g.rust_recommended_style = false

local spell_words = {}
for word in io.open(vim.fn.stdpath("config") .. "/spell/en.utf-8.add", "r"):lines() do
	table.insert(spell_words, word)
end

vim.cmd.colorscheme("catppuccin")
