return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        typos_lsp = {},
        cssls = {},
        emmet_language_server = {},
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
        -- this is a temporary workaround to get eslint to fix issues on save with the current version of lazyvim
        eslint = function()
          local formatter = LazyVim.lsp.formatter({
            name = "eslint: EslintFixAll",
            primary = false,
            priority = 200,
            filter = "eslint",
            format = function(buf)
              local client = vim.lsp.get_clients({ name = "eslint", bufnr = buf })[1]

              if client then
                local push_diagnostics =
                  vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id) })
                -- Older versions of the ESLint language server send push diagnostics rather than using pull.
                -- We support both for backwards compatibility.
                local pull_diagnostics =
                  vim.diagnostic.get(buf, { namespace = vim.lsp.diagnostic.get_namespace(client.id, true) })
                if (#pull_diagnostics + #push_diagnostics) > 0 then
                  vim.cmd("LspEslintFixAll")
                end
              end
            end,
          })

          -- register the formatter with LazyVim
          LazyVim.format.register(formatter)
        end,
      },
    },
  },
}
