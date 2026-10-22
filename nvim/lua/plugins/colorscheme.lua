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
  {
    "rebelot/kanagawa.nvim",
    opts = {
      overrides = function(colors)
        return {
          -- Keep explorer guides from inheriting LineNr's gutter background.
          SnacksPickerTree = { fg = colors.theme.ui.nontext },
        }
      end,
    },
  },
  { "maxmx03/solarized.nvim" },
  {
    "gbprod/nord.nvim",
    opts = {
      on_highlights = function(hl, c)
        -- Nord builds every diff group as `fg = <aurora color>, reverse = true`.
        -- The reverse sticks to each syntax token drawn on top, so tokens show
        -- up as boxes in their own fg color, on a bright slab with dark text.
        --
        -- These are bg-only tints in nord's own hues, set slightly *darker*
        -- than the background. Nord's syntax colors are already low-contrast
        -- (keywords ~4.6:1, numbers ~4.4:1 on nord0), so any tint lighter than
        -- the background pushes them toward unreadable; sunken tints keep
        -- every syntax color at or above its normal-buffer contrast, and the
        -- hue still marks add vs delete. Change uses frost rather than nord's
        -- yellow, which turns olive this dark and blurs into add. DiffText
        -- (also sidekick's NES insertion color) sits a step lighter so changed
        -- words stand out from a changed line without dropping much contrast.
        hl.DiffAdd = { bg = "#233018" }
        hl.DiffChange = { bg = "#1f3238" }
        hl.DiffDelete = { bg = "#3f2224" }
        hl.DiffText = { bg = "#144451", bold = true }

        -- snacks draws diff context lines with DiffChange, tinting all the
        -- unchanged code; put them on the plain background so only real
        -- changes are colored. Must be a real color: snacks links this group
        -- with `default = true`, and a freshly created `bg = NONE` group counts
        -- as undefined, so the link would still win on startup.
        hl.SnacksDiffContext = { bg = c.polar_night.origin }

        -- Nord links these to the Diff* groups, but they're foreground roles
        -- (snacks git status, gitsigns, diff filetype), so with bg-only Diff*
        -- groups they'd lose their color.
        hl.Added = { fg = c.aurora.green }
        hl.Changed = { fg = c.aurora.yellow }
        hl.Removed = { fg = c.aurora.red }
        hl.diffAdded = { link = "Added" }
        hl.diffChanged = { link = "Changed" }
        hl.diffRemoved = { link = "Removed" }
        hl["@diff.plus"] = { link = "Added" }
        hl["@diff.delta"] = { link = "Changed" }
        hl["@diff.minus"] = { link = "Removed" }

        -- Unset ComplHint falls back to NonText (polar_night.brighter), which
        -- nearly vanishes on the nord background; use the Comment color.
        hl.ComplHint = { fg = c.polar_night.light }
      end,
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      on_highlights = function(hl, colors)
        hl.ComplHint = { fg = colors.comment }
      end,
    },
  },
  {
    "EdenEast/nightfox.nvim",
    opts = {
      groups = {
        all = {
          -- Native inline completion falls back to the low-contrast NonText color.
          -- fg2 stays readable across dark and light variants; italics mark suggestions.
          ComplHint = { fg = "fg2", style = "italic" },
        },
      },
    },
  },
  {
    "loctvl842/monokai-pro.nvim",
    opts = {
      override = function(c)
        -- Backport Snacks picker highlights from monokai-pro.nvim PR #176.
        return {
          SnacksPicker = { bg = c.sideBar.background, fg = c.sideBar.foreground },
          SnacksPickerList = { bg = c.sideBar.background, fg = c.sideBar.foreground },
          SnacksPickerMatch = { fg = c.base.yellow, bold = true },
          -- Native inline completion otherwise inherits the invisible NonText color.
          ComplHint = { fg = c.base.dimmed2 },
        }
      end,
    },
  },
  {
    "marko-cerovac/material.nvim",
    opts = {
      custom_highlights = function(colors)
        -- Keep inline suggestions readable and distinct from accepted code.
        local opacity = vim.o.background == "light" and 0.95 or 0.85
        local hint = require("material.functions").blend(colors.editor.fg, colors.editor.bg, opacity)
        return {
          ComplHint = { fg = hint, italic = true },
        }
      end,
    },
  },
  { "navarasu/onedark.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("util.theme").apply()
      end,
    },
  },
}
