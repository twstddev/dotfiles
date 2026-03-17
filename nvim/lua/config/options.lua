-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.opt.wrap = true
vim.opt.breakindent = true
-- vim.o.equalalways = false
-- vim.g.ai_cmp = false
--
if vim.g.vscode then
  vim.g.mapleader = ""
end
