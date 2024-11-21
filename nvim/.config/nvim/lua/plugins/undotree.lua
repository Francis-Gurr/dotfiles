return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>u", "<cmd>:UndotreeToggle<CR>", { desc = "Toggle [u]ndo tree" })
	end,
}
