return {
	"seblyng/roslyn.nvim",
	---@module 'roslyn.config'
	---@type RoslynNvimConfig
	---
	dependencies = {
    'saghen/blink.cmp',
	},
	config = function()
		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			local mappings = {
				{ "n", "gr", "<cmd>Trouble lsp_references toggle focus=true<CR>", "Show LSP references" },
				{ "n", "gD", vim.lsp.buf.declaration, "Go to declaration" },
				{
					"n",
					"gi",
					"<cmd>Telescope lsp_implementations<CR>",
					"Show LSP implementations",
				},
				{
					"n",
					"gt",
					"<cmd>Telescope lsp_type_definitions<CR>",
					"Show LSP type definitions",
				},
				{ "n", "<leader><leader>", vim.lsp.buf.code_action, "Code actions" },
				{ "n", "<leader>rn", vim.lsp.buf.rename, "Smart rename" },
				{ "n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics" },
				{ "n", "<leader>d", vim.diagnostic.open_float, "Line diagnostics" },
				{ "n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic" },
				{ "n", "]d", vim.diagnostic.goto_next, "Next diagnostic" },
				{ "n", "K", vim.lsp.buf.hover, "Hover documentation" },
				{ "n", "<leader>rs", ":LspRestart<CR>", "Restart LSP" },
				{ "n", "<space>f", vim.lsp.buf.format, "Format Document" },
				{ "n", "gd", "<cmd>Telescope lsp_definitions<CR>", "Show definitions" },
			}

			for _, map in ipairs(mappings) do
				opts.desc = map[4]
				keymap.set(map[1], map[2], map[3], opts)
			end

			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = require('blink.cmp').get_lsp_capabilities()

		-- Change the Diagnostic symbols in the sign column (gutter)
		require("roslyn").setup({
			config = {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					["csharp|background_analysis"] = {
						dotnet_analyzer_diagnostics_scope = "fullSolution",
						dotnet_compiler_diagnostics_scope = "fullSolution",
					},
					["csharp|completion"] = {
						dotnet_provide_regex_completions = true,
						dotnet_show_completion_items_from_unimported_namespaces = true,
						dotnet_show_name_completion_suggestions = true,
					},
					["csharp|formatting"] = {
						dotnet_organize_imports_on_format = true,
					},
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						-- csharp_enable_inlay_hints_for_implicit_variable_types = true,

						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
						-- csharp_enable_inlay_hints_for_types = true,
						-- dotnet_enable_inlay_hints_for_indexer_parameters = true,
						-- dotnet_enable_inlay_hints_for_literal_parameters = true,
						dotnet_enable_inlay_hints_for_object_creation_parameters = true,
						-- dotnet_enable_inlay_hints_for_other_parameters = true,
						-- dotnet_enable_inlay_hints_for_parameters = true,
						-- dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
						-- dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
						-- dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			},
		})
	end,
}
