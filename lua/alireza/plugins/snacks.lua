return {
  "folke/snacks.nvim",
  lazy = false,
  priority = 1000,
  opts = function(_, opts)

    opts.dashboard = {
      preset = {
        keys = {
          { key = "n", action = "<Leader>n",  desc = "New File  " },
          { key = "f", action = "<Leader>ff", desc = "Find File  " },
          { key = "o", action = "<Leader>fo",  desc = "Recents  " },
          { key = "w", action = "<Leader>fw",  desc = "Find Word  " },
          { key = "'", action = "<Leader>f'",  desc = "Bookmarks  " },
          { key = "s", action = "<Leader>Sl",  desc = "Last Session  " },
        },
        header = table.concat({
          " █████  ███████ ████████ ██████   ██████ ",
          "██   ██ ██         ██    ██   ██ ██    ██",
          "███████ ███████    ██    ██████  ██    ██",
          "██   ██      ██    ██    ██   ██ ██    ██",
          "██   ██ ███████    ██    ██   ██  ██████ ",
          "",
          "███    ██ ██    ██ ██ ███    ███",
          "████   ██ ██    ██ ██ ████  ████",
          "██ ██  ██ ██    ██ ██ ██ ████ ██",
          "██  ██ ██  ██  ██  ██ ██  ██  ██",
          "██   ████   ████   ██ ██      ██",
        }, "\n"),
      },
      sections = {
        { section = "header", padding = 5 },
        { section = "keys", gap = 1, padding = 3 },
        { section = "startup" },
      },
    }

    -- configure image support
    opts.image = { doc = { enabled = false } }

    -- configure `vim.ui.input`
    opts.input = {}

    -- configure notifier
    opts.notifier = {}

    -- configure picker and `vim.ui.select`
    opts.picker = { ui_select = true }

    opts.indent = {
      indent = { char = "▏" },
      scope = { char = "▏" },
      animate = { enabled = false },
    }


    opts.zen = {
      toggles = { dim = false, diagnostics = false, inlay_hints = false },
      on_open = function(win)
        -- disable snacks indent
        vim.b[win.buf].snacks_indent_old = vim.b[win.buf].snacks_indent
        vim.b[win.buf].snacks_indent = false
      end,
      on_close = function(win)
        -- restore snacks indent setting
        vim.b[win.buf].snacks_indent = vim.b[win.buf].snacks_indent_old
      end,
      win = {
        width = function() return math.min(120, math.floor(vim.o.columns * 0.75)) end,
        height = 0.9,
        backdrop = {
          transparent = false,
          win = { wo = { winhighlight = "Normal:Normal" } },
        },
        wo = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          foldcolumn = "0",
          winbar = "",
          list = false,
          showbreak = "NONE",
        },
      },
    }
  end,
  specs = {
    {
      "nvim-neo-tree/neo-tree.nvim",
      optional = true,
      opts = {
        commands = {
          find_files_in_dir = function(state)
            local node = state.tree:get_node()
            local path = node.type == "file" and node:get_parent_id() or node:get_id()
            require("snacks").picker.files { cwd = path }
          end,
          find_all_files_in_dir = function(state)
            local node = state.tree:get_node()
            local path = node.type == "file" and node:get_parent_id() or node:get_id()
            require("snacks").picker.files { cwd = path, hidden = true, ignored = true }
          end,
          find_words_in_dir = function(state)
            local node = state.tree:get_node()
            local path = node.type == "file" and node:get_parent_id() or node:get_id()
            require("snacks").picker.grep { cwd = path }
          end,
          find_all_words_in_dir = function(state)
            local node = state.tree:get_node()
            local path = node.type == "file" and node:get_parent_id() or node:get_id()
            require("snacks").picker.grep { cwd = path, hidden = true, ignored = true }
          end,
        },
        filesystem = {
          window = {
            mappings = {
              f = { "show_help", nowait = false, config = { title = "Find Files", prefix_key = "f" } },
              ["f/"] = "filter_on_submit",
              ff = "find_files_in_dir",
              fF = "find_all_files_in_dir",
              fw = vim.fn.executable "rg" == 1 and "find_words_in_dir" or nil,
              fW = vim.fn.executable "rg" == 1 and "find_all_words_in_dir" or nil,
            },
          },
        },
      },
    },
  },
}
