return {
  "esmuellert/codediff.nvim",
  cmd = "CodeDiff",
  keys = {
    { "<leader>gcd", "<cmd>CodeDiff<cr>", desc = "Show git diff" },
    { "<leader>gch", "<cmd>CodeDiff history<cr>", desc = "Show git history" },
    { "<leader>gcf", "<cmd>CodeDiff history %<cr>", desc = "Show git file history" },
    { "<leader>gcl", "<cmd>'<,'>CodeDiff history<cr>", desc = "Show git line history", mode = { "n", "x" } },
  },
}
