return {
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
