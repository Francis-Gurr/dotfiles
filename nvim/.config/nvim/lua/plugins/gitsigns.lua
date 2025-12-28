return {
	"lewis6991/gitsigns.nvim",
	opts = {
		-- signs = {
		--   add = { text = '+' },
		--   change = { text = '~' },
		--   delete = { text = '_' },
		--   topdelete = { text = '‾' },
		--   changedelete = { text = '~' },
	},
	config = function()
		vim.keymap.set(
			"n",
			"<leader>tb",
			"<cmd>:Gitsigns toggle_current_line_blame<CR>",
			{ desc = "Toggle git [b]lame" }
		)
	end,
}
