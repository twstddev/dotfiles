return {
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
}
