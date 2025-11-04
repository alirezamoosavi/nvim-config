return {
	"olimorris/codecompanion.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		local helpers = require("codecompanion.adapters.acp.helpers")
		require("codecompanion").setup({
			-- display = {
			-- 	chat = {
			-- 		-- Change the default icons
			-- 		icons = {
			-- 			buffer_pin = " ",
			-- 			buffer_watch = "👀 ",
			-- 		},
			-- 		-- Options to customize the UI of the chat buffer
			-- 		window = {
			-- 			layout = "float",
			-- 			height = 0.9,
			-- 			width = 0.7,
			-- 		},
			-- 	},
			-- },
			strategies = {
				chat = {
					adapter = "llamacpp",
					opts = {
						completion_provider = "blink", -- blink
					},
					keymaps = {
						close = {
							modes = { n = "<C-l>", i = "<C-l>" },
						},
					},
				},
				inline = {
					adapter = "llamacpp",
				},
				cmd = {
					adapter = "llamacpp",
				},
			},
			adapters = {
				http = {
					ollama = function()
						return require("codecompanion.adapters").extend("ollama", {
							env = {
								url = "http://10.0.0.12:11434",
							},
							schema = {
								model = {
									default = "qwen3:30b",
								},
							},
							parameters = {
								sync = true,
							},
						})
					end,
          llamacpp = function()
						return require("codecompanion.adapters").extend("openai_compatible", {
							env = {
								url = "http://10.0.0.12:11343",
							},
							schema = {
								model = {
									default = "qwen3-vl-30b-a3b-instruct",
								},
							},
							parameters = {
								sync = true,
							},
						})
					end,

				},
				acp = {
					goose = function()
						return {
							name = "goose",
							formatted_name = "Goose",
							type = "acp",
							roles = {
								llm = "assistant",
								user = "user",
							},
							opts = {
								vision = true,
							},
							commands = {
								default = { "goose", "acp" },
							},
							defaults = {
								timeout = 20000, -- 20 seconds
							},
							env = {},
							parameters = {
								protocolVersion = 1,
								clientCapabilities = {
									fs = { readTextFile = true, writeTextFile = true },
								},
								clientInfo = {
									name = "CodeCompanion.nvim",
									version = "1.0.0",
								},
							},
							handlers = {
								setup = function(self)
									return true
								end,
								form_messages = function(self, messages, capabilities)
									return helpers.form_messages(self, messages, capabilities)
								end,
								on_exit = function(self, code) end,
							},
						}
					end,
				},
			},
			extensions = {
				vectorcode = {
					---@type VectorCode.CodeCompanion.ExtensionOpts
					opts = {
						tool_group = {
							-- this will register a tool group called `@vectorcode_toolbox` that contains all 3 tools
							enabled = true,
							-- a list of extra tools that you want to include in `@vectorcode_toolbox`.
							-- if you use @vectorcode_vectorise, it'll be very handy to include
							-- `file_search` here.
							extras = {},
							collapse = false, -- whether the individual tools should be shown in the chat
						},
						tool_opts = {
							---@type VectorCode.CodeCompanion.ToolOpts
							["*"] = {},
							---@type VectorCode.CodeCompanion.LsToolOpts
							ls = {},
							---@type VectorCode.CodeCompanion.VectoriseToolOpts
							vectorise = {},
							---@type VectorCode.CodeCompanion.QueryToolOpts
							query = {
								max_num = { chunk = -1, document = -1 },
								default_num = { chunk = 50, document = 10 },
								include_stderr = false,
								use_lsp = false,
								no_duplicate = true,
								chunk_mode = false,
								---@type VectorCode.CodeCompanion.SummariseOpts
								summarise = {
									---@type boolean|(fun(chat: CodeCompanion.Chat, results: VectorCode.QueryResult[]):boolean)|nil
									enabled = false,
									adapter = nil,
									query_augmented = true,
								},
							},
							files_ls = {},
							files_rm = {},
						},
					},
				},
			},
		})

		vim.keymap.set("n", "<c-l>", "<cmd>CodeCompanionChat Toggle<CR>", { noremap = true, silent = true })
		vim.keymap.set("v", "<c-l>", "<cmd>CodeCompanionChat<CR>", { noremap = true, silent = true })
		--
		vim.keymap.set("v", "<c-i>", "<cmd>CodeCompanion<CR>", { noremap = true, silent = true })
		--
		vim.keymap.set("n", "<c-a>", "<cmd>CodeCompanionActions<CR>", { noremap = true, silent = true })
		vim.keymap.set("v", "<c-a>", "<cmd>CodeCompanionActions<CR>", { noremap = true, silent = true })
	end,
}
