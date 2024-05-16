return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
    -- vim.cmd([[colorscheme tokyonight-moon]])
		config = function()
			require("tokyonight").setup({
				on_colors = function(colors)
					colors.hint = colors.orange
					colors.error = "#ff0000"
				end,
				on_highlights = function(hl, c)
					local prompt = "#2d3149"
					hl.TelescopeNormal = {
						bg = c.bg_dark,
						fg = c.fg_dark,
					}
					hl.TelescopeBorder = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopePromptNormal = {
						bg = prompt,
					}
					hl.TelescopePromptBorder = {
						bg = prompt,
						fg = prompt,
					}
					hl.TelescopePromptTitle = {
						bg = prompt,
						fg = prompt,
					}
					hl.TelescopePreviewTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
					hl.TelescopeResultsTitle = {
						bg = c.bg_dark,
						fg = c.bg_dark,
					}
				end,
			})
			-- load the colorscheme here
			-- vim.cmd([[colorscheme moonfly]])
		end,
	},

	{
		"catppuccin/nvim",
		event = "VeryLazy",
		name = "catppuccin",
		-- priority = 1000,
		-- config = function()
		-- 	vim.cmd.colorscheme "catppuccin"
		-- end
	},
	{
		"rose-pine/neovim",
		event = "VeryLazy",
		-- config = function()
		-- 	vim.cmd.colorscheme "rose-pine-moon"
		-- end
	},
	{
		"LunarVim/lunar.nvim",
		-- event = "VeryLazy",
		config = function()
			vim.cmd.colorscheme("lunar")
		end,
	},
	{
		"lunarvim/Onedarker.nvim",
		event = "VeryLazy",
	},
	{
		"sainnhe/edge",
		event = "VeryLazy",
	},
	{
		"JoosepAlviste/palenightfall.nvim",
		event = "VeryLazy",
	},
	{
		"maxmx03/fluoromachine.nvim",
		event = "VeryLazy",
	},
	{
		"artanikin/vim-synthwave84",
		event = "VeryLazy",
	},
}
