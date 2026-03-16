return {
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
  },
}
