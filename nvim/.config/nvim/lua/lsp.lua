-- Global LSP configuration
local capabilities = require("blink.cmp").get_lsp_capabilities()
vim.lsp.config("*", {
  on_attach = on_attach,
  capabilities = capabilities,
})

-- config from: https://github.com/vuejs/language-tools/wiki/Neovim

local vue_language_server_path = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")
local vue_plugin = {
  name = "@vue/typescript-plugin",
  location = vue_language_server_path,
  languages = { "vue" },
  configNamespace = "typescript",
}
vim.lsp.config("vtsls", {
  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
  },
})

vim.lsp.config("eslint", {
  filetypes = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
    "vue",
    "html",
    "markdown",
    "json",
    "jsonc",
    "yaml",
    "toml",
    "xml",
    "gql",
    "graphql",
    "astro",
    "svelte",
    "css",
    "less",
    "scss",
    "pcss",
    "postcss",
  },
  settings = {
    -- Silent the stylistic rules in you IDE, but still auto fix them
    rulesCustomizations = {
      { rule = "style/*", severity = "off", fixable = true },
      { rule = "format/*", severity = "off", fixable = true },
      { rule = "*-indent", severity = "off", fixable = true },
      { rule = "*-spacing", severity = "off", fixable = true },
      { rule = "*-spaces", severity = "off", fixable = true },
      { rule = "*-order", severity = "off", fixable = true },
      { rule = "*-dangle", severity = "off", fixable = true },
      { rule = "*-newline", severity = "off", fixable = true },
      { rule = "*quotes", severity = "off", fixable = true },
      { rule = "*semi", severity = "off", fixable = true },
    },
  },
})

vim.lsp.enable({
  "bashls",
  "copilot",
  "eslint",
  "lua_ls",
  "marksman",
  "ruff",
  "vtsls",
  "vue_ls",
  "yamlls",
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
    end

    -- Execute a code action, usually your cursor needs to be on top of an error
    -- or a suggestion from your LSP for this to activate.
    map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
    map("<leader>cs", function()
      vim.lsp.buf.code_action({ context = { only = { "source" } } })
    end, "[C]ode [S]ource action", { "n", "x" })

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
      local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your
    -- code, if the language server you are using supports them
    --
    -- This may be unwanted, since they displace some of your code
    if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "[T]oggle Inlay [H]ints")
    end
  end,
})

-- Configure diagnostics
vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  -- virtual_text = {
  -- 	source = "if_many",
  -- 	spacing = 2,
  -- 	format = function(diagnostic)
  -- 		local diagnostic_message = {
  -- 			[vim.diagnostic.severity.ERROR] = diagnostic.message,
  -- 			[vim.diagnostic.severity.WARN] = diagnostic.message,
  -- 			[vim.diagnostic.severity.INFO] = diagnostic.message,
  -- 			[vim.diagnostic.severity.HINT] = diagnostic.message,
  -- 		}
  -- 		return diagnostic_message[diagnostic.severity]
  -- 	end,
  -- },
})
