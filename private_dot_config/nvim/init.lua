vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.mouse = ""
vim.opt.number = true
vim.opt.list = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.o.termguicolors = true

vim.o.updatetime = 300

-- remap terminal exit to ESC
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]])

-- my stuff
require("my_stuff.daily")
vim.keymap.set("n", "<leader>dn", "<cmd>Daily<cr>")

vim.api.nvim_create_autocmd("CursorHold", {
	callback = function()
		if vim.bo.buftype == "" then
			vim.diagnostic.open_float(nil, { focus = false })
		end
	end,
})

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

vim.cmd('colorscheme tokyonight-day')
