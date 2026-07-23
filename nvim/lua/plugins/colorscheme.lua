return {
  { "catppuccin/nvim" },
  { "ellisonleao/gruvbox.nvim" },
  { "rose-pine/neovim", name = "rose-pine" },
  {
    "sainnhe/everforest",
    config = function()
      vim.g.everforest_background = "hard"
      vim.g.everforest_transparent_background = 1
    end,
  },
  { "rebelot/kanagawa.nvim" },
  { "maxmx03/solarized.nvim" },
  { "gbprod/nord.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        require("util.theme").apply()
      end,
    },
  },
}
