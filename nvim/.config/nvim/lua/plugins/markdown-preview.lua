return {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	build = "cd app && yarn install",
	init = function()
		vim.g.mkdp_filetypes = { "markdown" }
		-- vim.g.mkdp_markdown_css = vim.fn.expand("~/.config/nvim/lua/plugins/markdown-preview.css")
		-- vim.g.mkdp_preview_options = {
		-- 	custom_css = [[
		--   #page-ctn {
		--     max-width: none !important;
		--   }
		-- ]],
		-- }
	end,
	ft = { "markdown" },
}
