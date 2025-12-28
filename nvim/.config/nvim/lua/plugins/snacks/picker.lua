local function pick(name, opts)
  return function()
    Snacks.picker[name](opts)
  end
end

return {
  "folke/snacks.nvim",
  opts = {
    picker = {},
  },
  keys = {
    -- ═══════════════════════════════════════════════════════════
    -- CORE NAVIGATION (Top-level, most frequently used)
    -- ═══════════════════════════════════════════════════════════
    { "<leader><space>", pick("smart"), desc = "Smart Find Files" },
    { "<leader>,", pick("buffers"), desc = "Buffers" },
    { "<leader>/", pick("grep"), desc = "Grep" },
    { "<leader>:", pick("command_history"), desc = "Command History" },
    { "<leader>e", pick("explorer"), desc = "File Explorer" },

    -- ═══════════════════════════════════════════════════════════
    -- FILE FINDING (<leader>f)
    -- ═══════════════════════════════════════════════════════════
    { "<leader>ff", pick("files"), desc = "Find Files" },
    { "<leader>fr", pick("recent"), desc = "Recent Files" },
    { "<leader>fb", pick("buffers"), desc = "Buffers" },
    { "<leader>fp", pick("projects"), desc = "Projects" },
    { "<leader>fg", pick("git_files"), desc = "Git Files" },
    { "<leader>fc", pick("files", { cwd = vim.fn.stdpath("config") }), desc = "Config Files" },
    -- { "<leader>fz", pick("zoxide), desc = "Zoxide" },

    -- ═══════════════════════════════════════════════════════════
    -- SEARCH/GREP (<leader>s)
    -- ═══════════════════════════════════════════════════════════
    { "<leader>sg", pick("grep"), desc = "Grep" },
    { "<leader>sw", pick("grep_word"), desc = "Grep Word", mode = { "n", "x" } },
    { "<leader>sb", pick("lines"), desc = "Buffer Lines" },
    { "<leader>sB", pick("grep_buffers"), desc = "Grep Buffers" },
    { "<leader>s/", pick("search_history"), desc = "Search History" },
    { "<leader>sR", pick("resume"), desc = "Resume Last Picker" },

    -- ═══════════════════════════════════════════════════════════
    -- VIM/NEOVIM INTROSPECTION (<leader>s)
    -- ═══════════════════════════════════════════════════════════
    { "<leader>sc", pick("command_history"), desc = "Command History" },
    { "<leader>sC", pick("commands"), desc = "Commands" },
    { "<leader>sk", pick("keymaps"), desc = "Keymaps" },
    { "<leader>sa", pick("autocmds"), desc = "Autocmds" },
    { "<leader>sh", pick("help"), desc = "Help Pages" },
    { "<leader>sM", pick("man"), desc = "Man Pages" },
    { "<leader>sH", pick("highlights"), desc = "Highlights" },
    { "<leader>si", pick("icons"), desc = "Icons" },
    { "<leader>sn", pick("notifications"), desc = "Notifications" },
    { "<leader>sz", pick("spelling"), desc = "Spelling Suggestions" },
    { "<leader>uC", pick("colorschemes"), desc = "Colorschemes" },

    -- ═══════════════════════════════════════════════════════════
    -- REGISTERS & MARKS (<leader>s)
    -- ═══════════════════════════════════════════════════════════
    { '<leader>s"', pick("registers"), desc = "Registers" },
    { "<leader>sm", pick("marks"), desc = "Marks" },
    { "<leader>sj", pick("jumps"), desc = "Jump List" },
    { "<leader>su", pick("undo"), desc = "Undo History" },
    { "<leader>sy", pick("cliphist"), desc = "Clipboard History" },

    -- ═══════════════════════════════════════════════════════════
    -- DIAGNOSTICS & ERRORS (<leader>x or <leader>s)
    -- ═══════════════════════════════════════════════════════════
    { "<leader>sd", pick("diagnostics"), desc = "Diagnostics (Workspace)" },
    { "<leader>sD", pick("diagnostics_buffer"), desc = "Diagnostics (Buffer)" },
    { "<leader>sq", pick("qflist"), desc = "Quickfix List" },
    { "<leader>sl", pick("loclist"), desc = "Location List" },

    -- ═══════════════════════════════════════════════════════════
    -- LSP (<leader>l or goto keys)
    -- ═══════════════════════════════════════════════════════════
    { "gd", pick("lsp_definitions"), desc = "LSP: Definitions" },
    { "gD", pick("lsp_declarations"), desc = "LSP: Declarations" },
    { "gr", pick("lsp_references"), desc = "LSP: References" },
    { "gI", pick("lsp_implementations"), desc = "LSP: Implementations" },
    { "gy", pick("lsp_type_definitions"), desc = "LSP: Type Definitions" },
    { "<leader>ls", pick("lsp_symbols"), desc = "LSP: Document Symbols" },
    { "<leader>lS", pick("lsp_workspace_symbols"), desc = "LSP: Workspace Symbols" },
    { "<leader>lc", pick("lsp_config"), desc = "LSP: Servers" },
    { "<leader>li", pick("lsp_incoming_calls"), desc = "LSP: Incoming Calls" },
    { "<leader>lo", pick("lsp_outgoing_calls"), desc = "LSP: Outgoing Calls" },

    -- ═══════════════════════════════════════════════════════════
    -- GIT (<leader>g)
    -- ═══════════════════════════════════════════════════════════
    { "<leader>gs", pick("git_status"), desc = "Git: Status" },
    { "<leader>gd", pick("git_diff"), desc = "Git: Diff (Hunks)" },
    { "<leader>gb", pick("git_branches"), desc = "Git: Branches" },
    { "<leader>gl", pick("git_log"), desc = "Git: Log" },
    { "<leader>gL", pick("git_log_line"), desc = "Git: Log (Line)" },
    { "<leader>gf", pick("git_log_file"), desc = "Git: Log (File)" },
    { "<leader>gS", pick("git_stash"), desc = "Git: Stash" },
    { "<leader>gg", pick("git_grep"), desc = "Git: Grep" },

    -- ═══════════════════════════════════════════════════════════
    -- GITHUB (<leader>gh)
    -- ═══════════════════════════════════════════════════════════
    { "<leader>ghi", pick("gh_issue"), desc = "GitHub: Issues (Open)" },
    { "<leader>ghI", pick("gh_issue", { state = "all" }), desc = "GitHub: Issues (All)" },
    { "<leader>ghp", pick("gh_pr"), desc = "GitHub: PRs (Open)" },
    { "<leader>ghP", pick("gh_pr", { state = "all" }), desc = "GitHub: PRs (All)" },
    { "<leader>ghd", pick("gh_diff"), desc = "GitHub: PR Diff" },
    { "<leader>ghl", pick("gh_labels"), desc = "GitHub: Labels" },
    { "<leader>ghr", pick("gh_reactions"), desc = "GitHub: Reactions" },
    { "<leader>gha", pick("gh_actions"), desc = "GitHub: Actions" },

    -- ═══════════════════════════════════════════════════════════
    -- TREESITTER & TAGS (<leader>t or <leader>s)
    -- ═══════════════════════════════════════════════════════════
    { "<leader>st", pick("treesitter"), desc = "Treesitter Symbols" },
    { "<leader>sT", pick("tags"), desc = "Tags" },

    -- ═══════════════════════════════════════════════════════════
    -- PLUGINS & META (<leader>p or <leader>s)
    -- ═══════════════════════════════════════════════════════════
    { "<leader>sp", pick("lazy"), desc = "Lazy Plugin Spec" },
    { "<leader>sP", pick("pickers"), desc = "Pickers" },
    { "<leader>nx", pick("scratch"), desc = "Scratch Buffers" },

    -- ═══════════════════════════════════════════════════════════
    -- TODO COMMENTS (if installed)
    -- ═══════════════════════════════════════════════════════════
    { "<leader>xT", pick("todo_comments"), desc = "Todo Comments" },
    {
      "<leader>xt",
      pick("todo_comments", { keywords = { "TODO", "FIX", "FIXME" } }),
      desc = "Todo/Fix/Fixme",
    },
  },
}
