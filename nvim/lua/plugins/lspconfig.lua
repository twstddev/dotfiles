return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      typos_lsp = {},
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
