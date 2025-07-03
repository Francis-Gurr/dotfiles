return {
	{
		"mason-org/mason.nvim",
		opts = {},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				-- ts
				"vue-language-server",
				"typescript-language-server",
				"prettierd",

				-- python
				"ruff",

				-- lua
				"lua-language-server",
				-- luacheck,
				"stylua",

				-- some spell checker
				-- json linter and formatter
			},
		},
	},
}
