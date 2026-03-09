return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      trigger = {
        show_in_snippet = false,
      },
    },
    keymap = {
      preset = "super-tab",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    sources = {
      providers = {
        snippets = {
          score_offset = 200,
        },
      },
    },
  },
}
