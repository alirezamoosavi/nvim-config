return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
'saghen/blink.cmp' ,
		"williamboman/mason-lspconfig.nvim",
		"Hoffs/omnisharp-extended-lsp.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
	},
	config = function()
		-- import cmp-nvim-lsp plugin

		local keymap = vim.keymap -- for conciseness

		local opts = { noremap = true, silent = true }
		local on_attach = function(client, bufnr)
			opts.buffer = bufnr

			-- set keybinds
			opts.desc = "Show LSP references"
			keymap.set("n", "gr", "<cmd>Trouble lsp_references toggle focus=true<CR>", opts) -- show definition, references

			opts.desc = "Go to declaration"
			keymap.set("n", "gD", vim.lsp.buf.declaration, opts) -- go to declaration

			opts.desc = "Show LSP definitions"
			if client.name == "omnisharp" then
				keymap.set("n", "gd", "<cmd>lua require('omnisharp_extended').telescope_lsp_definitions()<cr>", opts) -- show lsp definitions
			else
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions
			end

			opts.desc = "Show LSP implementations"
			keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

			opts.desc = "Show LSP type definitions"
			keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

			opts.desc = "See available code actions"
			keymap.set({ "n", "v" }, "<leader><leader>", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

			opts.desc = "Smart rename"
			keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

			opts.desc = "Show buffer diagnostics"
			keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

			opts.desc = "Show line diagnostics"
			keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

			opts.desc = "Go to previous diagnostic"
			keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

			opts.desc = "Go to next diagnostic"
			keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

			opts.desc = "Show documentation for what is under cursor"
			keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

			opts.desc = "Restart LSP"
			keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary

			opts.desc = "Format Document"
			keymap.set("n", "<space>f", vim.lsp.buf.format, opts)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
		end

		-- used to enable autocompletion (assign to every lsp server config)
		local capabilities = require('blink.cmp').get_lsp_capabilities()
		-- Change the Diagnostic symbols in the sign column (gutter)
		-- (not in youtube nvim video)
		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		local lsp_flags = {
			-- This is the default in Nvim 0.7+
			debounce_text_changes = 150,
		}

		-- -- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
		-- local omnisharp_bin = "/home/alireza/.local/share/nvim/mason/packages/omnisharp/OmniSharp"
		-- -- configure C# server
		-- vim.lsp.config("omnisharp",{
		-- 	handlers = {
		-- 		["textDocument/definition"] = require("omnisharp_extended").handler,
		-- 	},
		-- 	cmd = { omnisharp_bin },
		-- 	on_attach = on_attach,
		-- 	flags = lsp_flags,
		-- 	capabilities = capabilities,
		-- 	enable_roslyn_analysers = true,
		-- 	enable_import_completion = true,
		-- 	organize_imports_on_format = true,
		-- 	enable_decompilation_support = true,
		-- 	filetypes = { "cs", "vb", "csproj", "sln", "slnx", "props", "csx", "props", "targets" },
		-- })

    vim.lsp.config('html',{
			capabilities = capabilities,
			on_attach = on_attach,
		})
		-- configure html server

		vim.lsp.config("emmet_ls",{
			capabilities = capabilities,
			on_attach = on_attach,
		})
		-- configure typescript server with plugin
		vim.lsp.config("ts_ls",{
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure svelte server
		vim.lsp.config("svelte",{
			capabilities = capabilities,
			on_attach = on_attach,
			require("lsp_signature").on_attach(),
		})

		-- configure css server
		vim.lsp.config("cssls",{
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure tailwindcss server
		vim.lsp.config("tailwindcss",{
			capabilities = capabilities,
			on_attach = on_attach,
			filetypes = { "svelte", "html", "cshtml" },
		})

		-- configure python server
		vim.lsp.config("pyright",{
			capabilities = capabilities,
			on_attach = on_attach,
		})

		-- configure golang server
		vim.lsp.config("gopls",{
			on_attach = on_attach,
			-- capabilities = cap,
			message_level = vim.lsp.protocol.MessageType.Error,
			cmd = {
				"gopls", -- share the gopls instance if there is one already
				"-remote=auto", --[[ debug options ]] --
				-- "-logfile=auto",
				-- "-debug=:0",
				"-remote.debug=:0",
				-- "-rpc.trace",
			},
			flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
			settings = {
				gopls = {
					-- more settings: https://github.com/golang/tools/blob/master/gopls/doc/settings.md
					-- flags = {allow_incremental_sync = true, debounce_text_changes = 500},
					-- not supported
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
						generate = true, -- show the `go generate` lens.
						gc_details = true, --  // Show a code lens toggling the display of gc's choices.
						test = true,
						tidy = true,
					},
					completeUnimported = true,
					staticcheck = true,
					matcher = "fuzzy",
					diagnosticsDelay = "500ms",
					symbolMatcher = "fuzzy",
					gofumpt = false, -- true, -- turn on for new repos, gofmpt is good but also create code turmoils
					buildFlags = { "-tags", "integration" },
					-- buildFlags = {"-tags", "functional"}
				},
			},
			require("lsp_signature").on_attach(),
			capabilities = capabilities,
		})

		-- configure lua server (with special settings)
		vim.lsp.config("lua_ls",{
			capabilities = capabilities,
			on_attach = on_attach,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})

		-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
		local servers = {
			"sqlls",
			"jsonls",
		}
		for _, lsp in ipairs(servers) do
			vim.lsp.config(lsp,{
				on_attach = on_attach,
				require("lsp_signature").on_attach(),
				flags = lsp_flags,
				capabilities = capabilities,
			})
		end
	end,
}
