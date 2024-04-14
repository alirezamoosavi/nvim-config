return {
	"rcarriga/nvim-dap-ui",
	dependencies = { -- optional packages
		"mfussenegger/nvim-dap",
		"folke/neodev.nvim",
		"nvim-neotest/nvim-nio",
		"theHamsta/nvim-dap-virtual-text",
	},
	config = function()
		require("dapui").setup()

		local keymap = vim.keymap -- for conciseness
		keymap.set("n", "<leader><F5>", "<cmd>DapUiToggle<CR>") -- show definition, references
		keymap.set("n", "<F5>", "<cmd>DapContinue<CR>") -- show definition, references
		keymap.set("n", "<F9>", "<cmd>DapToggleBreakpoint<CR>") -- show definition, references
		keymap.set("n", "<F10>", "<cmd>DapStepOver<CR>") -- show definition, references
		keymap.set("n", "<F11>", "<cmd>DapStepInto<CR>") -- show definition, references
		keymap.set("n", "<leader><F11>", "<cmd>DapStepOut<CR>") -- show definition, references
	end,
}
