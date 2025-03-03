local utils = require("utils")

return {
  {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    cond = not utils.is_vscode(),

    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
      })

      vim.cmd.colorscheme "catppuccin"
    end,
  },
}
