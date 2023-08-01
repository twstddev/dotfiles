local utils = require("utils")
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

local plugins = {
	-- nvim speicfic plugins
	{
		"marko-cerovac/material.nvim",
		lazy = false,
		priority  = 1000,
		config = function()
			vim.cmd.colorscheme "material-oceanic"
		end,
		cond = not utils.is_vscode()
	}
}

require("lazy").setup(plugins, require("plugins.lazy"))
