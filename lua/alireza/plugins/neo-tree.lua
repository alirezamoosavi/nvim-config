return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	keys = {
		{ "<leader>ee", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
		{
			"<leader>gs",
			function()
				require("neo-tree.command").execute({
					source = "git_status",
					position = "float",
					toggle = true,
				})
			end,
			desc = "Toggle Git Status (float)",
		},
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			popup_border_style = "rounded",
			enable_git_status = true,
			enable_diagnostics = true,
			sort_case_insensitive = true,
			default_component_configs = {
				container = {
					enable_character_fade = true,
				},
				indent = {
					indent_size = 2,
					padding = 1,
					with_markers = true,
					indent_marker = "│",
					last_indent_marker = "└",
					highlight = "NeoTreeIndentMarker",
					with_expanders = nil,
					expander_collapsed = "",
					expander_expanded = "",
					expander_highlight = "NeoTreeExpander",
				},
				icon = {
					folder_closed = "",
					folder_open = "",
					folder_empty = "ﰊ",
					default = "",
					highlight = "NeoTreeFileIcon",
				},
				modified = {
					symbol = "[+]",
					highlight = "NeoTreeModified",
				},
				name = {
					trailing_slash = false,
					use_git_status_colors = true,
					highlight = "NeoTreeFileName",
				},
				git_status = {
					symbols = {
						added = "",
						modified = "",
						deleted = "",
						renamed = "➜",
						untracked = "★",
						ignored = "◌",
						unstaged = "✗",
						staged = "✓",
						conflict = "",
					},
				},
			},
			window = {
				position = "left",
				width = 30,
				mappings = {
					["<space>"] = "toggle_node",
					["<2-LeftMouse>"] = "open",
					["<cr>"] = "open",
					["S"] = "open_split",
					["s"] = "open_vsplit",
					["t"] = "open_tabnew",
					["C"] = "close_node",
					["a"] = "add",
					["d"] = "delete",
					["r"] = "rename",
					["y"] = "copy_to_clipboard",
					["x"] = "cut_to_clipboard",
					["p"] = "paste_from_clipboard",
					["c"] = "copy",
					["m"] = "move",
					["q"] = "close_window",
					["R"] = "refresh",
					["?"] = "show_help",
				},
			},
			nesting_rules = {},
			filesystem = {
				commands = {
					avante_add_files = function(state)
						local node = state.tree:get_node()
						local filepath = node:get_id()
						local relative_path = require("avante.utils").relative_path(filepath)

						local sidebar = require("avante").get()

						local open = sidebar:is_open()
						-- ensure avante sidebar is open
						if not open then
							require("avante.api").ask()
							sidebar = require("avante").get()
						end

						sidebar.file_selector:add_selected_file(relative_path)

						-- remove neo tree buffer
						if not open then
							sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
						end
					end,
				},
				window = {
					mappings = {
						["oa"] = "avante_add_files",
					},
				},
				filtered_items = {
					visible = false,
					hide_dotfiles = false,
					hide_gitignored = false,
					hide_by_name = {
						"node_modules",
					},
					never_show = {
						".DS_Store",
						"thumbs.db",
					},
				},
				follow_current_file = {
					enabled = true,
				},
				hijack_netrw_behavior = "open_default",
				use_libuv_file_watcher = true,
			},
			buffers = {
				show_unloaded = true,
				window = {
					mappings = {
						["bd"] = "buffer_delete",
					},
				},
			},
			git_status = {
				window = {
					position = "float",
					mappings = {
						-- عملیات پایه Git
						["ga"] = "git_add_file", -- افزودن فایل
						["gu"] = "git_unstage_file", -- حذف از stage
						["gr"] = "git_revert_file", -- بازگردانی تغییرات
						["gc"] = "git_commit", -- کامیت
						["gp"] = "git_push", -- پوش
						["gg"] = "git_commit_and_push", -- کامیت و پوش همزمان

						-- عملیات پیشرفته
						["A"] = "git_add_all", -- افزودن همه تغییرات
						["U"] = "git_unstage_all", -- حذف همه از stage
						["D"] = "git_discard", -- دور انداختن تغییرات
						["dv"] = "diffview_open", -- باز کردن diffview
						["ds"] = "git_show", -- نمایش تغییرات

						-- مدیریت branch
						["gb"] = "git_branch_create", -- ایجاد branch جدید
						["gs"] = "git_branch_switch", -- سوئیچ بین branchها

						-- عملیات stash
						["gt"] = "git_stash_push", -- ذخیره تغییرات در stash
						["gl"] = "git_stash_pop", -- بازیابی آخرین stash
					},
				},
			},
		})
	end,
}
