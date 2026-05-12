vim.pack.add({ { src = "https://github.com/nvim-mini/mini.nvim" } })

-- Better Around/Inside textobjects: va) yinq ci' etc.
require("mini.ai").setup({ n_lines = 500 })

-- Add/delete/replace surroundings: saiw) sd' sr)' etc.
require("mini.surround").setup()

-- Auto-pair brackets/quotes (replaces nvim-autopairs).
require("mini.pairs").setup()

require("mini.sessions").setup()

local statusline = require("mini.statusline")
statusline.setup({ use_icons = vim.g.have_nerd_font })
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return "%2l:%-2v"
end
