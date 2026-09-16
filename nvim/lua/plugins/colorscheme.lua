return {
  { "catppuccin/nvim" },
  {
    "ellisonleao/gruvbox.nvim",
    opts = function()
      -- Gruvbox's stock diff backgrounds are too light for code to sit on:
      -- DiffAdd (#62693e) only reaches 4.2:1 against the default foreground,
      -- and it shares DiffChange's olive hue so add and change look alike.
      -- DiffText is worse -- a full-saturation yellow slab that has to force
      -- the foreground to the background color, wiping out syntax highlighting
      -- on exactly the words you're trying to read.
      --
      -- These land every line-level group above 6.7:1 while staying ~1.4x off
      -- the normal background so the fill is still visible, and move change to
      -- blue so it separates from add by hue rather than by shade of olive.
      -- DiffText drops the forced foreground (fg = NONE) to keep syntax colors.
      --
      -- Set via `overrides` rather than `palette_overrides`: the palette route
      -- goes through dark_red/dark_green/dark_aqua, which get reassigned from
      -- the _hard/_soft entries whenever `contrast` is set (gruvbox.lua:207).
      -- Overrides are applied last and are immune to that.
      local diff = vim.o.background == "light"
          and {
            DiffAdd = { bg = "#c9dd95" },
            DiffChange = { bg = "#b6d2e8" },
            DiffDelete = { bg = "#f2b8aa" },
            DiffText = { bg = "#92bcd9", fg = "NONE", bold = true },
          }
        or {
          DiffAdd = { bg = "#3c4620" },
          DiffChange = { bg = "#2a4553" },
          DiffDelete = { bg = "#6b3634" },
          DiffText = { bg = "#2c5f7a", fg = "NONE", bold = true },
        }

      return {
        overrides = vim.tbl_extend("error", diff, {
          -- Gruvbox never defines ComplHint, so the inline-completion ghost text
          -- keeps the stock default and reads as real code. `gray` is the same
          -- entry Comment uses (gruvbox.lua:333), for either background.
          ComplHint = { fg = require("gruvbox").palette.gray },
        }),
      }
    end,
  },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_transparent_background = 1

      -- Vimscript colorscheme, so there is no on_highlights hook: patch after it loads.
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "everforest",
        callback = function()
          local config = vim.fn["everforest#get_configuration"]()
          local palette = vim.fn["everforest#get_palette"](config.background, config.colors_override)
          -- Palette entries are { gui, cterm }; grey1 is what Comment uses.
          vim.api.nvim_set_hl(0, "ComplHint", { fg = palette.grey1[1] })
        end,
      })
    end,
  },
  { "rebelot/kanagawa.nvim" },
  { "maxmx03/solarized.nvim" },
  { "gbprod/nord.nvim" },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, colors)
        hl.ComplHint = { fg = colors.comment }
      end,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("util.theme").apply()
      end,
    },
  },
}
