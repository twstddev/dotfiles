return {
  "neovim/nvim-lspconfig",
  opts = {
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
