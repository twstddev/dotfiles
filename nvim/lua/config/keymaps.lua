-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local del = vim.keymap.del

map({ "n", "v", "x", "i" }, "<C-c>", "<Esc>")

del("n", "<S-h>")
del("n", "<S-l>")
del({ "i", "x", "n", "s" }, "<C-s>")
