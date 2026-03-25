return {
  {
    "folke/flash.nvim",
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
