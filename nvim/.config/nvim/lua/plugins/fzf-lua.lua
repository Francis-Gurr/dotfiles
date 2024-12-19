return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("fzf-lua").setup({})

		vim.keymap.set("n", "<leader>s?", require("fzf-lua").helptags, { desc = "Search [h]elp" })
		vim.keymap.set("n", "<leader>sb", require("fzf-lua").buffers, { desc = "Search open [b]uffers" })
		vim.keymap.set("n", "<leader>sc", require("fzf-lua").lgrep_curbuf, { desc = "Search [c]urrent buffer" })
		vim.keymap.set("n", "<leader>sf", require("fzf-lua").files, { desc = "Search [f]iles" })
		vim.keymap.set("n", "<leader>sg", require("fzf-lua").live_grep, { desc = "Search by [g]rep" })
		vim.keymap.set("n", "<leader>sG", require("fzf-lua").live_grep_glob, { desc = "Search by grep with glob" })
		vim.keymap.set("n", "<leader>sh", require("fzf-lua").search_history, { desc = "Search [h]istory" })
		vim.keymap.set("n", "<leader>sr", require("fzf-lua").resume, { desc = "Search [r]esume" })
		vim.keymap.set("n", "<leader>st", require("fzf-lua").treesitter, { desc = "Search [t]reesitter symbols" })
		vim.keymap.set("n", "<leader>sw", require("fzf-lua").grep_cword, { desc = "Search [w]ord under cursor" })
		vim.keymap.set("n", "<leader>sW", require("fzf-lua").grep_cWORD, { desc = "Search [W]ORD under cursor" })
		vim.keymap.set("v", "<leader>ss", require("fzf-lua").grep_visual, { desc = "Search [s]election" })

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("fzf-lua-lsp-attach", { clear = true }),
			callback = function(event)
				local map = function(keys, func, desc, mode)
					mode = mode or "n"
					vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Jump to the definition of the word under your cursor.
				--  This is where a variable was first declared, or where a function is defined, etc.
				--  To jump back, press <C-t>.
				map("gd", require("fzf-lua").lsp_definitions, "[G]oto [D]efinition")

				-- Find references for the word under your cursor.
				map("gr", require("fzf-lua").lsp_references, "[G]oto [R]eferences")

				-- Jump to the implementation of the word under your cursor.
				--  Useful when your language has ways of declaring types without an actual implementation.
				map("gI", require("fzf-lua").lsp_implementations, "[G]oto [I]mplementation")

				-- Jump to the type of the word under your cursor.
				--  Useful when you're not sure what type a variable is and you want to see
				--  the definition of its *type*, not where it was *defined*.
				map("<leader>D", require("fzf-lua").lsp_typedefs, "Type [D]efinition")

				-- Fuzzy find all the symbols in your current document.
				--  Symbols are things like variables, functions, types, etc.
				map("<leader>ds", require("fzf-lua").lsp_document_symbols, "[D]ocument [S]ymbols")

				-- Fuzzy find all the symbols in your current workspace.
				--  Similar to document symbols, except searches over your entire project.
				map("<leader>ws", require("fzf-lua").lsp_workspace_symbols, "[W]orkspace [S]ymbols")
			end,
		})
	end,
}
