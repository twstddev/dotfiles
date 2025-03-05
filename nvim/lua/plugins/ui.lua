return {
  {
    "catppuccin/nvim",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        integrations = {
          leap = true,
          gitsigns = true,
          telescope = {
            enalbed = true,
          },
          mini = {
            enabled = true,
          },
          treesitter = true,
        },
      })

      vim.cmd.colorscheme "catppuccin"
    end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = "catppuccin"
      }
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {},
  },
}
