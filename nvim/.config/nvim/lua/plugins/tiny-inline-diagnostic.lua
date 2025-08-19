return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event = "LspAttach",
	priority = 1000,
	config = function()
		require("tiny-inline-diagnostic").setup({
			preset = "simple",
			options = {
				show_source = {
					enabled = true,
					if_many = true,
				},
				use_icons_from_diagnostic = true,
				show_all_diags_on_cursorline = true,
				multilines = {
					enabled = true,
					always_show = true,
					trim_whitespaces = false,
					tabstop = 4,
				},
			},
		})
		vim.diagnostic.config({ virtual_text = false })
	end,
}
