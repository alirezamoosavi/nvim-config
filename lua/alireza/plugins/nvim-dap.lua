return {
	{
		"rcarriga/nvim-dap-ui",
		version = "*",
		dependencies = {
			"mfussenegger/nvim-dap",
			"folke/neodev.nvim",
			"nvim-neotest/nvim-nio",
			"theHamsta/nvim-dap-virtual-text",
		},
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")

			-- Adapter برای .NET Core
			dap.adapters.coreclr = {
				type = "executable",
				command = "/home/alireza/.local/share/nvim/mason/bin/netcoredbg",
				args = { "--interpreter=vscode" },
				options = {
					justMyCode = true,
				},
			}

			-- dap-virtual-text برای نمایش مقدار متغیرها
			require("nvim-dap-virtual-text").setup({
				commented = true,
				highlight_changed_variables = true,
			})

			-- dap-ui setup
			dapui.setup({
				icons = { expanded = "▾", collapsed = "▸", circular = "↺" },
				controls = {
					enabled = true,
					element = "repl",
					icons = {
						pause = "⏸",
						play = "▶",
						step_into = "⤵",
						step_over = "⤼",
						step_out = "⤴",
						step_back = "↶",
						run_last = "⏯",
						terminate = "■",
						disconnect = "⏏",
					},
				},
				layouts = {
					{
						elements = {
							{ id = "scopes", size = 0.4 },
							{ id = "breakpoints", size = 0.2 },
							{ id = "stacks", size = 0.2 },
							{ id = "watches", size = 0.2 },
						},
						size = 50,
						position = "left",
					},
					{
						elements = { "repl", "console" },
						size = 10,
						position = "bottom",
					},
				},
				floating = {
					border = "rounded",
					mappings = {
						close = { "q", "<Esc>" },
					},
				},
				windows = { indent = 1 },
			})

			-- Auto open/close DAP UI
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end

			-- Keymaps
			local keymap = vim.keymap
			keymap.set("n", "<F5><F5>", "<cmd>lua require('dapui').toggle()<CR>", { desc = "Toggle DAP UI" })
			keymap.set("n", "<F5>", "<cmd>lua require('dap').continue()<CR>", { desc = "Continue" })
			keymap.set("n", "<F9>", "<cmd>lua require('dap').toggle_breakpoint()<CR>", { desc = "Toggle Breakpoint" })
			keymap.set("n", "<F10>", "<cmd>lua require('dap').step_over()<CR>", { desc = "Step Over" })
			keymap.set("n", "<F11>", "<cmd>lua require('dap').step_into()<CR>", { desc = "Step Into" })
			keymap.set("n", "<leader><F11>", "<cmd>lua require('dap').step_out()<CR>", { desc = "Step Out" })
			-- فعال‌سازی break روی همه exceptionها
			vim.keymap.set("n", "<leader>de", function()
				require("dap").set_exception_breakpoints({ "all" })
				print("Break on all exceptions: ENABLED")
			end, { desc = "DAP: Break on exceptions" })

			-- غیرفعال‌سازی break روی exceptionها
			vim.keymap.set("n", "<leader>dn", function()
				require("dap").set_exception_breakpoints({})
				print("Break on all exceptions: DISABLED")
			end, { desc = "DAP: Don't break on exceptions" })

			-- فقط break روی uncaught exceptionها
			vim.keymap.set("n", "<leader>du", function()
				require("dap").set_exception_breakpoints({ "uncaught" })
				print("Break on uncaught exceptions: ENABLED")
			end, { desc = "DAP: Break on uncaught exceptions" })

			-- آیکون‌های زیبا برای breakpoint‌ها
			vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "DapBreakpoint", linehl = "", numhl = "" })
			vim.fn.sign_define("DapStopped", { text = "👉", texthl = "DapStopped", linehl = "", numhl = "" })
			vim.fn.sign_define(
				"DapBreakpointRejected",
				{ text = "⚠️", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
			)

			-- رنگ‌های سفارشی برای اجزای dap-ui
			vim.api.nvim_set_hl(0, "DapUIBreakpointsCurrentLine", { fg = "#e0af68", bold = true })
			vim.api.nvim_set_hl(0, "DapUIBreakpointsLine", { fg = "#7aa2f7" })
			vim.api.nvim_set_hl(0, "DapUIVariable", { fg = "#c0caf5" })
			vim.api.nvim_set_hl(0, "DapUIScope", { fg = "#9ece6a", bold = true })
			vim.api.nvim_set_hl(0, "DapUIType", { fg = "#7dcfff" })
			vim.api.nvim_set_hl(0, "DapUIValue", { fg = "#bb9af7" })
			vim.api.nvim_set_hl(0, "DapUIModifiedValue", { fg = "#f7768e", bold = true })
		end,
	},
}
