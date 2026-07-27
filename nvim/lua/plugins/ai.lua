return {
  {
    "zbirenbaum/copilot.lua",
    enabled = false,
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
    opts = {
      nes = {
        debounce = 0,
        enabled = true,
      },
      cli = {
        win = {
          layout = "float",
          keys = {
            ctrl_c_normal = {
              "<C-c>",
              "stopinsert",
              mode = "t",
              desc = "Enter terminal normal mode",
            },
          },
          float = {
            border = "rounded",
            width = 0.8,
            height = 0.8,
          },
        },
      },
      copilot = {
        status = {
          -- enabled = false,
        },
      },
    },

    keys = {
      { "<tab>", mode = { "n" }, false },
      {
        "<M-i>",
        function()
          require("sidekick.cli").toggle()
        end,
        mode = { "n", "t", "i", "x" },
        desc = "Toggle Sidekick CLI",
      },
    },
  },
}
