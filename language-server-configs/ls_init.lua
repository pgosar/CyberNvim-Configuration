for _, source in ipairs({
	"user.language-server-configs.lua",
	"user.language-server-configs.tsserver",
	"user.language-server-configs.gopls",
}) do
	local status_ok, fault = pcall(require, source)
	if not status_ok then
		vim.notify("Failed to load " .. source .. "\n\n" .. fault, "error")
	end
end
