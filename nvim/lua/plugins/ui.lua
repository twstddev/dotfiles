local codediff = require("util.codediff")
local tests = require("util.tests")

-- Picker source config that hides test files by default. <a-x> toggles it, and the
-- title shows the badge while tests are hidden.
local function hide_tests()
  return {
    exclude_tests = true,
    toggles = {
      exclude_tests = "󰙨",
    },
    transform = function(item, ctx)
      if ctx.picker.opts.exclude_tests and tests.is_test_file(item.file) then
        -- if every result is a test, open the picker empty instead of closing it
        -- with "No results", so <a-x> can bring them back
        ctx.picker.opts.show_empty = true
        return false
      end
    end,
    win = {
      input = {
        keys = {
          ["<a-x>"] = { "toggle_exclude_tests", mode = { "n", "i" } },
        },
      },
      list = {
        keys = {
          ["<a-x>"] = "toggle_exclude_tests",
        },
      },
    },
  }
end

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
    keys = {
      {
        "<leader>usf",
        function()
          local explorer = Snacks.picker.get({ source = "explorer" })[1]

          if not explorer then
            Snacks.picker.explorer()
            return
          end

          if explorer and not explorer:is_focused() then
            explorer:focus()
          end
        end,
        desc = "Focus Explorer",
      },
    },
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
          open_commit_pr = {
            desc = "Open Pull Request in Browser",
            action = codediff.open_commit_pr,
          },
        },
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
              ["<a-h>"] = false,
              ["<a-.>"] = { "toggle_hidden", mode = { "n", "i" } },
              ["<a-f>"] = false,
              ["<a-F>"] = { "toggle_follow", mode = { "n", "i" } },
              ["<a-r>"] = false,
              ["<a-R>"] = { "toggle_regex", mode = { "n", "i" } },
              ["<a-t>"] = false,
              ["<a-X>"] = { "trouble_open", mode = { "n", "i" } },
            },
          },
          list = {
            keys = {
              ["/"] = false,
              ["<a-w>"] = "focus_preview",
              ["<a-s>"] = "flash",
              ["<a-h>"] = false,
              ["<a-.>"] = "toggle_hidden",
              ["<a-f>"] = false,
              ["<a-F>"] = "toggle_follow",
            },
          },
          preview = {
            keys = {
              ["<a-w>"] = "focus_list",
              ["<a-s>"] = "flash",
              ["<a-m>"] = "toggle_maximize",
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
          gh_issue = {
            win = {
              input = {
                keys = {
                  ["<a-b>"] = false,
                  ["<a-B>"] = { "gh_browse", mode = { "n", "i" } },
                },
              },
            },
          },
          gh_pr = {
            win = {
              input = {
                keys = {
                  ["<a-b>"] = false,
                  ["<a-B>"] = { "gh_browse", mode = { "n", "i" } },
                },
              },
            },
          },
          keymaps = {
            win = {
              input = {
                keys = {
                  ["<a-b>"] = false,
                  ["<a-B>"] = { "toggle_buffer", mode = { "n", "i" }, desc = "Toggle Buffer Keymaps" },
                },
              },
            },
          },
          lsp_references = hide_tests(),
          lsp_implementations = hide_tests(),
          lsp_workspace_symbols = hide_tests(),
          grep = hide_tests(),
          grep_word = hide_tests(),
          git_grep = hide_tests(),
        },
      },
    },
  },
}
