return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"saghen/blink.cmp",
    "seblyng/roslyn.nvim",
		"williamboman/mason-lspconfig.nvim",
		-- "Hoffs/omnisharp-extended-lsp.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		local capabilities = require("blink.cmp").get_lsp_capabilities()
		local keymap = vim.keymap
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

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.INFO] = "󰋼 ",
					[vim.diagnostic.severity.HINT] = "󰌵 ",
				},
				texthl = {
					[vim.diagnostic.severity.ERROR] = "Error",
					[vim.diagnostic.severity.WARN] = "Error",
					[vim.diagnostic.severity.HINT] = "Hint",
					[vim.diagnostic.severity.INFO] = "Info",
				},
				numhl = {
					[vim.diagnostic.severity.ERROR] = "",
					[vim.diagnostic.severity.WARN] = "",
					[vim.diagnostic.severity.HINT] = "",
					[vim.diagnostic.severity.INFO] = "",
				},
			},
		})

		local servers = {
			html = {},
			emmet_ls = {},
			ts_ls = {},
			svelte = {
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					require("lsp_signature").on_attach()
				end,
			},
			cssls = {},
			tailwindcss = { filetypes = { "svelte", "html", "cshtml" } },
			pyright = {},
			gopls = {
				cmd = { "gopls", "-remote=auto", "-remote.debug=:0" },
				flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							unreachable = false,
							fieldalignment = true,
							nilness = true,
						},
						hints = {
							assignVariableTypes = true,
							compositeLiteralFields = true,
							compositeLiteralTypes = true,
							constantValues = true,
							functionTypeParameters = true,
							parameterNames = true,
							rangeVariableTypes = true,
						},
						codelenses = {
							generate = true,
							gc_details = true,
							test = true,
							tidy = true,
						},
						completeUnimported = true,
						staticcheck = true,
						matcher = "fuzzy",
						diagnosticsDelay = "500ms",
						symbolMatcher = "fuzzy",
						gofumpt = false,
						buildFlags = { "-tags", "integration" },
					},
				},
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)
					require("lsp_signature").on_attach()
				end,
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = {
								[vim.fn.expand("$VIMRUNTIME/lua")] = true,
								[vim.fn.stdpath("config") .. "/lua"] = true,
							},
						},
					},
				},
			},
			roslyn = {
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
			sqlls = {},
			jsonls = {},
		}

		for name, cfg in pairs(servers) do
			vim.lsp.config(
				name,
				vim.tbl_extend("keep", cfg, {
					on_attach = on_attach,
					capabilities = capabilities,
				})
			) -- تعریف پیکربندی :contentReference[oaicite:6]{index=6}
			vim.lsp.enable(name) -- فعال‌سازی سرور :contentReference[oaicite:7]{index=7}
		end
	end,
}
