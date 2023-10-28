return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		action_keys = { -- key mappings for actions in the trouble list
			jump = { "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
			jump_close = { "<cr>" }, -- jump to the diagnostic and close the list
		},
	},
}
