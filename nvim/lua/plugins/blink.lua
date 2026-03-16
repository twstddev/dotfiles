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
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "snippet_forward",
        LazyVim.cmp.map({ "ai_nes", "ai_accept" }),
        "fallback",
      },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    sources = {
      providers = {
        snippets = {
          score_offset = 200,

          should_show_items = function(ctx)
            return ctx.trigger.initial_kind ~= "trigger_character"
          end,
        },
      },
    },
  },
}
