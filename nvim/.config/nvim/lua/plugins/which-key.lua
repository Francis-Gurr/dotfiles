return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {
    { "<leader>c", group = "[C]ode", mode = { "n", "x" } },
    { "<leader>r", group = "[R]ename" },
    { "<leader>f", group = "[F]ind" },
    { "<leader>g", group = "[G]it" },
    { "<leader>l", group = "[L]int" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>t", group = "[T]oggle" },
    { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
  },
}
