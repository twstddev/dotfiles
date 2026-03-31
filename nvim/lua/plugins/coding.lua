return {
  {
    "saghen/blink.cmp",
    opts = {
      fuzzy = {
        max_typos = 0,
        sorts = {
          function(a, b)
            if (a.client_name == nil or b.client_name == nil) or (a.client_name == b.client_name) then
              return
            end
            return a.client_name ~= "emmet_language_server"
          end,
          "exact",
          "score",
          "sort_text",
        },
      },
      completion = {
        trigger = {
          show_in_snippet = false,
        },
      },
      keymap = {
        preset = "super-tab",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
        ["<CR>"] = { "accept", "fallback" },
      },
      sources = {
        providers = {
          snippets = {
            score_offset = 200,

            should_show_items = function(ctx)
              return ctx.trigger.initial_kind ~= "trigger_character"
            end,
          },

          copilot = {
            enabled = false,
          },
        },
      },
    },
  },

  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    dependencies = {
      {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load({
            exclude = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
          })
          require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })
        end,
      },
    },
  },

  {
    "nvim-mini/mini.operators",
    event = "VeryLazy",
    vscode = true,
    opts = {
      replace = {
        prefix = "go",
      },
    },
  },
}
