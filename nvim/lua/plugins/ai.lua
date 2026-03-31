return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completions = false,
        debounce = 0,
      },
    },
  },

  {
    "folke/sidekick.nvim",
    commit = "c2bdf8cfcd87a6be5f8b84322c1b5052e78e302e",
    opts = {
      nes = {
        debounce = 0,
      },
      copilot = {
        status = {
          -- enabled = false,
        },
      },
    },

    keys = {
      { "<tab>", mode = { "n" }, false },
    },
  },
}
