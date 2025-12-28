return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      bufdelete = { enabled = true },
      dashboard = { enabled = true },
      debug = { enabled = true },
      dim = { enabled = true },
      explorer = { enabled = true },
      git = { enabled = true },
      gitbrowse = { enabled = true },
      image = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      keymap = { enabled = true },
      lazygit = { enabled = true },
      notifier = { timeout = 5000 },
      picker = { enabled = true },
      profiler = { enabled = true },
      quickfile = { enabled = true },
      rename = { enabled = true },
      scope = { enabled = true },
      scratch = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      terminal = { enabled = true },
      toggle = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true },
    },
    -- General keys that don't fit specific categories
    keys = {
      {
        "<leader>N",
        desc = "Neovim News",
        function()
          Snacks.win({ file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1], width = 0.6, height = 0.6 })
        end,
      },
      {
        "<leader>n",
        function()
          Snacks.notifier.show_history()
        end,
        desc = "Notification History",
      },
      {
        "<leader>un",
        function()
          Snacks.notifier.hide()
        end,
        desc = "Dismiss All Notifications",
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd
        end,
      })
    end,
  },
  { import = "plugins.snacks" },
}
