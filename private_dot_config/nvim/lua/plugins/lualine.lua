return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"pnx/lualine-lsp-status",
		"arkav/lualine-lsp-progress",
	},
	config = function()
		local c = require("lualine").get_config()
		c.sections.lualine_c = {
			"filename",
			"lsp-status",
			"lsp_progress",
		}
		require("lualine").setup(c)
	end,
}
