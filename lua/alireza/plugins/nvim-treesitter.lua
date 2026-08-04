return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		branch = "main",
		build = ":TSUpdate",
		config = function()
			local ts = require("nvim-treesitter")

			-- لیست زبان‌هایی که در صورت موجود بودن نصب می‌شوند
			local parsers = {
        "xml",
				"query",
				"vim",
				"vimdoc",
				"json",
				"javascript",
				"typescript",
				"dockerfile",
				"yaml",
				"prisma",
				"markdown",
				"markdown_inline",
				"svelte",
				"html",
				"css",
				"c_sharp",
				"go",
				"bash",
				"lua",
				"gitignore",
			}

			-- نصب پارسرها در صورت نیاز (فقط زبان‌های پشتیبانی‌شده نصب می‌شوند)
			-- اگر زبانی پشتیبانی نشود یا نصب آن با خطا مواجه شود، نادیده گرفته می‌شود
			pcall(ts.ensure_installed, parsers, { sync = false })

			-- فعال‌سازی هایلایت سینتکس برای فایل‌های باز شده
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("custom.treesitter", { clear = true }),
				pattern = { "*" },
				callback = function(event)
					-- اگر پارسر زبان موجود باشد، هایلایت فعال می‌شود، در غیر این صورت هیچ اتفاقی نمی‌افتد
					pcall(vim.treesitter.start, event.buf)
				end,
			})

			-- در صورت استفاده از پلاگین‌های جداگانه مانند nvim-ts-autotag یا rainbow، آن‌ها را اینجا تنظیم کنید
			-- require("nvim-ts-autotag").setup()
			-- require('rainbow-delimiters.setup').setup()
		end,
	},
}
