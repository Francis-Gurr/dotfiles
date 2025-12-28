local function pick(name, opts)
  return function()
    Snacks.picker[name](opts)
  end
end

local function snack(method, opts)
  return function()
    Snacks[method](opts)
  end
end

return {
  "folke/snacks.nvim",
  keys = {
    -- Git Pickers
    { "<leader>gb", pick("git_branches"), desc = "Git Branches" },
    { "<leader>gl", pick("git_log"), desc = "Git Log" },
    { "<leader>gs", pick("git_status"), desc = "Git Status" },
    { "<leader>gd", pick("git_diff"), desc = "Git Diff (Hunks)" },
    { "<leader>gf", pick("git_log_file"), desc = "Git Log File" },

    -- LazyGit / GitBrowse (Using the 'run' helper for top-level functions)
    { "<leader>gg", snack("lazygit"), desc = "Lazygit" },
    { "<leader>gB", snack("gitbrowse"), desc = "Git Browse", mode = { "n", "v" } },

    -- Terminal
    { "<c-/>", snack("terminal"), desc = "Toggle Terminal" },
    { "<c-_>", snack("terminal"), desc = "which_key_ignore" },
  },
}
