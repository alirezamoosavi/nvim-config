return {
	"leoluz/nvim-dap-go",
	dependencies = { -- optional packages
		"mfussenegger/nvim-dap",
	},
	config = function()
		require("dap-go").setup()
	end,
}
