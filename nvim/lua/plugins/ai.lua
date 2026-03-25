return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completions = true,
        debounce = 0,
      },
    },
  },

  {
    "folke/sidekick.nvim",
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
  },
}
