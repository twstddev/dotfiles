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
        preview = function(ctx)
          local res = Snacks.picker.preview.file(ctx)

          if ctx.item.file then
            ctx.picker.preview:set_title(vim.fn.fnamemodify(ctx.item.file, ":."))
          end

          return res
        end,
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
