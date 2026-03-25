return {
  { "folke/noice.nvim", enabled = false },

  {
    "akinsho/bufferline.nvim",
    opts = {
      options = {
        mode = "tabs",
        separator_style = "thick",
      },
    },
  },

  {
    "snacks.nvim",
    opts = {
      indent = {
        animate = {
          enabled = false,
        },
      },
      notifier = {
        top_down = false,
      },
      scroll = { enabled = false },
      explorer = {
        trash = false,
      },
      picker = {
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
        sources = {
          explorer = {
            ignored = true,
            hidden = true,
          },
          gh_diff = {
            win = {
              input = {
                keys = {
                  ["<Esc>"] = "cancel",
                },
              },
            },
          },
        },
      },
    },
  },
}
