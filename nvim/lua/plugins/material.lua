local M = {}

M.setup = function()
	vim.g.material_style = "deep ocean"

	require("material").setup({
		contrast = {
			terminal = true,
			sidebars = true,
			floating_windows = true
		}
	})

	vim.cmd.colorscheme "material"
end

return M
