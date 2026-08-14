local codediff = require("util.codediff")

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
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_z = {},
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
        actions = {
          codediff = {
            desc = "Open CodeDiff",
            action = codediff.open_commit,
          },
          browse_commit = {
            desc = "Open Commit in Browser",
            action = codediff.open_commit_browser,
          },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["/"] = false,
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
          git_log = {
            win = codediff.picker_keys(),
          },
          git_log_file = {
            win = codediff.picker_keys(),
          },
          git_log_line = {
            win = codediff.picker_keys(),
          },
        },
      },
    },
  },
}
