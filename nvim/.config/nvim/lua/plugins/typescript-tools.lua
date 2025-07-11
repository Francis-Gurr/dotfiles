return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	opts = {
		settings = {
			tsserver_plugins = {
				name = "@vue/typescript-plugin",
				location = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server"),
				languages = { "javascript", "typescript", "vue" },
			},
		},
	},
}
