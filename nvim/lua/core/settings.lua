local utils = require("utils")

local options = vim.opt
local globals = vim.g

globals.leader = ","

options.laststatus = 2
options.showmode = true
options.cursorline = true
options.number = true
options.splitright = true
options.splitbelow = true
options.equalalways = true
options.expandtab = true
options.shiftwidth = 2
options.tabstop = 2
options.softtabstop = 2
options.autoindent = true
options.smartindent = true
options.ignorecase = true
options.smartcase = true
options.ruler = true
options.shortmess:append "sI"
options.signcolumn = "yes"
options.termguicolors = true
options.undofile = true
options.hlsearch = true
options.incsearch = true
options.linebreak = true
options.gdefault = true
options.scrolloff = 3
options.report = 0
options.list = true
options.listchars = {
  tab = "› ",
  trail = "•",
  extends = "#",
  nbsp = "."
}

if not utils.is_vscode() then
  vim.api.nvim_create_autocmd({"VimEnter", "WinEnter", "BufWinEnter"}, {
    command = "setlocal cursorline"
  })

  vim.api.nvim_create_autocmd("WinLeave", {
    command = "setlocal nocursorline"
  })
end
