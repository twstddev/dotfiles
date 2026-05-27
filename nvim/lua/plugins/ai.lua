return {
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp",
    },
    init = function()
      vim.g.copilot_nes_debounce = 0
    end,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        hide_during_completions = false,
        debounce = 0,
      },
      nes = {
        enabled = true,
        keymap = {
          accept_and_goto = "<A-;>",
          accept = false,
          dismiss = "<Esc>",
        },
      },
    },
  },

  {
    "folke/sidekick.nvim",
    commit = "c2bdf8cfcd87a6be5f8b84322c1b5052e78e302e",
    opts = {
      nes = {
        debounce = 0,
        enabled = false,
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
