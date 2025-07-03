-- Set leader key (before loading plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.g.have_nerd_font = true

-- Load options (settings)
require("options")

-- Load key mappings
require("keymaps")

-- Load autocomands
require("autocmds")

-- Bootstrap and configure lazy.nvim plugin manager
require("bootstrap-lazy") -- This will handle plugin loading

-- LSP config
require("lsp")
