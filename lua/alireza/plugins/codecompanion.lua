return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},

	config = function()
		require("codecompanion").setup({
			strategies = {
				chat = {
					adapter = "ollama",
					keymaps = {
						close = {
							modes = { n = "<C-l>", i = "<C-l>" },
						},
					},
				},
				inline = {
					adapter = "ollama",
				},
			},
			adapters = {
				my_openai = function()
					return require("codecompanion.adapters").extend("openai_compatible", {
						env = {
							url = "http://10.0.0.12:11435", -- optional: default value is ollama url http://127.0.0.1:11434
							api_key = "OpenAI_API_KEY", -- optional: if your endpoint is authenticated
							chat_url = "/v1/chat/completions", -- optional: default value, override if different
							models_endpoint = "/v1/models", -- optional: attaches to the end of the URL to form the endpoint to retrieve models
						},
					})
				end,

				ollama = function()
					return require("codecompanion.adapters").extend("ollama", {
						env = {
							url = "http://10.0.0.12:11434",
						},
						schema = {
							model = {
								-- default = "gemma3:12b",
								default = "qwen2.5-coder:32b",
							},
						},
						parameters = {
							sync = true,
						},
					})
				end,
			},

			-- adapters = {
			-- },
		})

		vim.keymap.set("n", "<c-l>", "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true })
		vim.keymap.set("v", "<c-l>", "<cmd>CodeCompanionChat<CR>", { noremap = true, silent = true })
		--
		-- vim.keymap.set("i", "<c-i>", "<cmd>CodeCompanion<CR>", { noremap = true, silent = true })
		vim.keymap.set("v", "<c-i>", "<cmd>CodeCompanion<CR>", { noremap = true, silent = true })
		--
		-- vim.keymap.set("i", "<c-i>", "<cmd>CodeCompanion<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<c-a>", "<cmd>CodeCompanionActions<CR>", { noremap = true, silent = true })
		vim.keymap.set("v", "<c-a>", "<cmd>CodeCompanionActions<CR>", { noremap = true, silent = true })
	end,
}
