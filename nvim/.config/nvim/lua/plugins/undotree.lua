return {
	"mbbill/undotree",
	config = function()
		vim.keymap.set("n", "<leader>tu", "<cmd>:UndotreeToggle<CR>", { desc = "Toggle [u]ndo tree" })
	end,
}
