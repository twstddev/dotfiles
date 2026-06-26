return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {},
        cssls = {},
        emmet_language_server = {},
        copilot = {
          settings = {
            telemetry = {
              telemetryLevel = "off",
            },
          },
        },
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },

        ["*"] = {
          keys = {
            { "<c-k>", mode = "i", false },
          },
        },
      },
      diagnostics = {
        virtual_text = {
          current_line = true,
        },
      },
      inlay_hints = {
        enabled = false,
      },
      setup = {
        eslint = function(_, opts)
          local base_on_attach = vim.lsp.config.eslint and vim.lsp.config.eslint.on_attach

          opts.on_attach = function(client, bufnr)
            if base_on_attach then
              base_on_attach(client, bufnr)
            end

            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              command = "LspEslintFixAll",
            })
          end
        end,
      },
    },
  },
}
