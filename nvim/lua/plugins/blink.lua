return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      trigger = {
        show_in_snippet = false,
      },
    },
    keymap = {
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        "fallback",
      },
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
