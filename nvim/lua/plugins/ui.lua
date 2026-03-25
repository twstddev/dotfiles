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
          list = {
            keys = {
              ["<a-w>"] = "focus_preview",
            },
          },
          preview = {
            keys = {
              ["<a-w>"] = "focus_list",
            },
          },
        },
        sources = {
          explorer = {
            ignored = true,
            hidden = true,
          },
        },
      },
    },
  },
}
