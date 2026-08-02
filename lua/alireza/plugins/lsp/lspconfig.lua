return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "saghen/blink.cmp",
    "seblyng/roslyn.nvim",
    "williamboman/mason-lspconfig.nvim",
    { "antosha417/nvim-lsp-file-operations", config = true },
    -- نکته: مطمئن شوید که telescope.nvim نصب باشد، وگرنه دستورات Telescope کار نمی‌کنند
    -- "nvim-telescope/telescope.nvim", 
  },
  config = function()
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local keymap = vim.keymap
    local opts = { noremap = true, silent = true }

    -- 1. تعریف تابع on_attach گلوبال برای ثبت کی‌مپ‌ها
    local global_on_attach = function(client, bufnr)
      opts.buffer = bufnr

      -- ✅ اصلاح شده: تمام کی‌مپ‌ها به صورت یکدست درون جدول قرار گرفتند
      local mappings = {
        { "n", "gr", "<cmd>Trouble lsp_references toggle focus=true<CR>", "Show LSP references" },
        { "n", "gD", vim.lsp.buf.declaration,                             "Go to declaration" },
        { "n", "gi", "<cmd>Telescope lsp_implementations<CR>",            "Show LSP implementations" },
        { "n", "gt", "<cmd>Telescope lsp_type_definitions<CR>",           "Show LSP type definitions" },
        { "n", "<leader><leader>", vim.lsp.buf.code_action,               "Code actions" },
        { "n", "<leader>rn",       vim.lsp.buf.rename,                    "Smart rename" },
        { "n", "<leader>D",        "<cmd>Telescope diagnostics bufnr=0<CR>", "Buffer diagnostics" },
        { "n", "<leader>d",        vim.diagnostic.open_float,             "Line diagnostics" },

        -- ✅ کی‌مپ‌های دیاگنوستیک جدید به فرمت جدول تبدیل شدند
        { "n", "[d", function() vim.diagnostic.jump({ count = -1, float=true }) end,      "Go to previous diagnostic" },
        { "n", "]d", function() vim.diagnostic.jump({ count = 1, float=true }) end,       "Go to next diagnostic" },

        { "n", "K",            vim.lsp.buf.hover,                     "Hover documentation" },
        { "n", "<leader>rs",   "<cmd>LspRestart<CR>",                 "Restart LSP" },
        { "n", "<space>f",     vim.lsp.buf.format,                    "Format Document" },
        { "n", "gd",           "<cmd>Telescope lsp_definitions<CR>",  "Show definitions" },
      }

      for _, map in ipairs(mappings) do
        opts.desc = map[4]
        keymap.set(map[1], map[2], map[3], opts)
      end

      -- ✅ خط deprecated حذف شد (blink.cmp خودش این کار را مدیریت می‌کند)
    end

    -- تنظیمات دیاگنوستیک
    vim.diagnostic.config({
      float = {
        border = "rounded",
        focusable = true,
        scope = "cursor",
        source = "if_many", -- نمایش منبع خطا (مثلاً eslint) در صورت وجود چندین خطا
      },
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = " ",
          [vim.diagnostic.severity.WARN] = " ",
          [vim.diagnostic.severity.INFO] = "󰋼 ",
          [vim.diagnostic.severity.HINT] = "󰌵 ",
        },
        texthl = {
          [vim.diagnostic.severity.ERROR] = "DiagnosticError",
          [vim.diagnostic.severity.WARN] = "DiagnosticWarn",
          [vim.diagnostic.severity.HINT] = "DiagnosticHint",
          [vim.diagnostic.severity.INFO] = "DiagnosticInfo",
        },
      },
    })

    local servers = {
      html = {},
      emmet_ls = {},
      ts_ls = {},
      svelte = {
        -- on_attach خاص svelte
        on_attach = function(client, bufnr)
          pcall(function() require("lsp_signature").on_attach() end)
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
            analyses = { unusedparams = true, unreachable = false, fieldalignment = true, nilness = true },
            hints = {
              assignVariableTypes = true, compositeLiteralFields = true, compositeLiteralTypes = true,
              constantValues = true, functionTypeParameters = true, parameterNames = true, rangeVariableTypes = true,
            },
            codelenses = { generate = true, gc_details = true, test = true, tidy = true },
            completeUnimported = true, staticcheck = true, matcher = "fuzzy", diagnosticsDelay = "500ms",
            symbolMatcher = "fuzzy", gofumpt = false, buildFlags = { "-tags", "integration" },
          },
        },
        -- on_attach خاص gopls
        on_attach = function(client, bufnr)
          pcall(function() require("lsp_signature").on_attach() end)
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
          ["csharp|background_analysis"] = { dotnet_analyzer_diagnostics_scope = "fullSolution", dotnet_compiler_diagnostics_scope = "fullSolution" },
          ["csharp|completion"] = { dotnet_provide_regex_completions = true, dotnet_show_completion_items_from_unimported_namespaces = true, dotnet_show_name_completion_suggestions = true },
          ["csharp|formatting"] = { dotnet_organize_imports_on_format = true },
          ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
          },
          ["csharp|code_lens"] = { dotnet_enable_references_code_lens = true },
        },
      },
      sqlls = {},
      jsonls = {},
    }

    for name, cfg in pairs(servers) do
      -- ✅ اصلاح مهم: ذخیره on_attach خاص سرور (اگر وجود داشته باشد)
      local server_specific_on_attach = cfg.on_attach

      -- ✅ ادغام هوشمند: ابتدا کی‌مپ‌های گلوبال ثبت می‌شوند، سپس تنظیمات خاص سرور اجرا می‌شود
      cfg.on_attach = function(client, bufnr)
        global_on_attach(client, bufnr)
        if server_specific_on_attach then
          server_specific_on_attach(client, bufnr)
        end
      end

      -- تنظیم و فعال‌سازی سرور با API جدید Neovim 0.11+
      vim.lsp.config(name, vim.tbl_extend("keep", cfg, {
        capabilities = capabilities,
      }))
      vim.lsp.enable(name)
    end
  end,
}
