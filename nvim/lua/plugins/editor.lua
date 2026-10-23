return {
  {
    "folke/flash.nvim",
    keys = {
      {
        "<M-s>",
        function()
          require("flash").jump({ search = { multi_window = vim.bo.buftype ~= "terminal" } })
        end,
        mode = { "n", "x", "o" },
        desc = "Flash",
      },
      {
        "<M-s>",
        -- Sidekick opens its scrollback on TermLeave before this scheduled jump.
        "<C-\\><C-n><Cmd>lua vim.schedule(function() require('flash').jump({ search = { multi_window = false } }) end)<CR>",
        mode = "t",
        desc = "Flash Terminal",
      },
    },
    opts = {
      jump = {
        autojump = true,
      },
      highlight = {
        matches = false,
      },
      label = {
        before = { 0, 0 },
        after = false,
      },
      modes = {
        char = {
          enabled = false,
        },
      },
    },
  },

  {
    "folke/which-key.nvim",
    opts = {
      win = {
        row = 0,
      },
    },
  },

  {
    "christoomey/vim-tmux-navigator",
    config = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
      "TmuxNavigatorProcessList",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
}
