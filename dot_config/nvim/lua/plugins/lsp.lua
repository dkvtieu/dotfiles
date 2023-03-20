return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    dependencies = {
      -- LSP Support
      { "neovim/nvim-lspconfig" }, -- Required
      { "williamboman/mason.nvim" }, -- Optional
      { "williamboman/mason-lspconfig.nvim" }, -- Optional
      { "jay-babu/mason-null-ls.nvim" },
      { "jose-elias-alvarez/null-ls.nvim" },
      { "folke/neodev.nvim" },

      -- Autocompletion
      { "hrsh7th/nvim-cmp" }, -- Required
      { "hrsh7th/cmp-nvim-lsp" }, -- Required
      { "L3MON4D3/LuaSnip" }, -- Required
    },
    config = function()
      require("neodev").setup({})

      local lsp = require("lsp-zero").preset("recommended")

      lsp.on_attach(function(_, bufnr)
        lsp.default_keymaps({ buffer = bufnr })

        local opts = { buffer = bufnr }
        local bind = vim.keymap.set
        bind("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
      end)

      local cmp = require("cmp")

      require("cmp").setup({
        window = {
          documentation = cmp.config.window.bordered(),
        },
        mapping = {
          ["<CR>"] = cmp.mapping.confirm(),
        },
      })

      lsp.setup()

      vim.diagnostic.config({
        -- disable virtual text
        virtual_text = false,
        -- show signs
        signs = {
          active = {
            { name = "DiagnosticSignError", text = "" },
            { name = "DiagnosticSignWarn", text = "" },
            { name = "DiagnosticSignHint", text = "" },
            { name = "DiagnosticSignInfo", text = "" },
          },
        },
        update_in_insert = true,
        underline = true,
        severity_sort = true,
        float = {
          focusable = false,
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
          format = function(diagnostic)
            return string.format(
              "%s [%s]",
              diagnostic.message,
              -- Rule name / id, if any
              diagnostic.code
            )
          end,
        },
      })

      -- See mason-null-ls.nvim's documentation for more details:
      -- https://github.com/jay-babu/mason-null-ls.nvim#setup
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettier",
          "eslint_d",
          "stylua",
          "lua-language-server",
          "typescript-language-server",
        },
        automatic_installation = true, -- You can still set this to `true`
        automatic_setup = true,
      })

      -- Required when `automatic_setup` is true
      require("mason-null-ls").setup_handlers({})

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      require("null-ls").setup({
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ bufnr = bufnr })
              end,
            })
          end
        end,
        sources = {
          -- You can add tools not supported by mason.nvim
        },
      })
    end,
  },
}
