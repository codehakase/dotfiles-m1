return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        -- We enable servers explicitly in the nvim-lspconfig config below,
        -- so disable mason-lspconfig's own auto-enable to avoid double setup.
        automatic_enable = false,
        -- NOTE: rust_analyzer (rustaceanvim) and hls (haskell-tools) are
        -- intentionally NOT listed here; those plugins manage their own servers.
        ensure_installed = {
          "ts_ls",
          "cssls",
          "html",
          "eslint",
          "emmet_ls",
          "tailwindcss",
          "clangd",
          "zls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "saghen/blink.cmp" },
    config = function()
      local capabilities = require("blink.cmp").get_lsp_capabilities()

      -- Shared on-attach: buffer-local LSP keymaps
      local on_attach = function(_, bufnr)
        vim.bo[bufnr].omnifunc = "v:lua.vim.lsp.omnifunc"

        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gd", function()
          vim.cmd("split")
          vim.lsp.buf.definition()
        end, bufopts)
        vim.keymap.set("n", "K", function()
          vim.lsp.buf.hover({ border = "rounded", max_width = 80, max_height = 20 })
        end, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "<C-k>", function()
          vim.lsp.buf.signature_help({ border = "rounded" })
        end, bufopts)
        vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
        vim.keymap.set("n", "<space>wl", function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, bufopts)
        vim.keymap.set("n", "<leader>gD", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "<space>f", vim.lsp.buf.format, bufopts)
      end

      -- Defaults applied to every server
      vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = on_attach,
      })

      local inlay_hints = {
        includeInlayParameterNameHints = "all",
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
      }

      -- Per-server overrides (merged on top of the "*" defaults)
      local servers = {
        gopls = {
          settings = {
            gopls = {
              analyses = { unusedparams = true },
              staticcheck = true,
              gofumpt = true,
            },
          },
        },
        ts_ls = {
          settings = {
            typescript = { inlayHints = inlay_hints },
            javascript = { inlayHints = inlay_hints },
          },
        },
        tailwindcss = {
          filetypes = {
            "html",
            "css",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        },
        eslint = {
          settings = { workingDirectories = { mode = "auto" } },
        },
        emmet_ls = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
          },
        },
        cssls = {},
        html = {},
        clangd = {},
        zls = {},
      }

      for name, cfg in pairs(servers) do
        vim.lsp.config(name, cfg)
        vim.lsp.enable(name)
      end
    end,
  },
}
