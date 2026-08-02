return {
	{
		"nvim-treesitter/nvim-treesitter",

		lazy = false,
		branch = "main",
		build = ":TSUpdate", -- این دستور در نسخه جدید همچنان کار می‌کند
		config = function()
			local ts = require("nvim-treesitter")

			-- لیست زبان‌هایی که می‌خواهیم پارسر آن‌ها نصب شود
			local parsers = {
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
				"javascript",
				"c_sharp",
				"go",
				"bash",
				"lua",
				"dockerfile",
				"gitignore",
			}

			-- نصب پارسرها در زمان راه‌اندازی (تا ۳۰ ثانیه صبر می‌کند)
			-- در صورت نصب بودن، کاری انجام نمی‌دهد
			ts.install(parsers, { summary = false }):wait(30000)

			local function get_parser_name(filetype)
				-- استفاده از API داخلی (Neovim >= 0.10)
				if vim.treesitter.language and vim.treesitter.language.get_lang then
					return vim.treesitter.language.get_lang(filetype)
				end
				-- در غیر این صورت، نگاشت دستی
				local map = {
					cs = "c_sharp",
					js = "javascript",
					ts = "typescript",
					-- در صورت نیاز، موارد دیگر را اضافه کنید
				}
				return map[filetype] or filetype
			end

			local function install_parser_and_enable_features(event)
				local filetype = event.match
				local lang = get_parser_name(filetype)

				-- اگر نام زبان نامعتبر بود، از ادامه کار صرف‌نظر کن
				if not lang or lang == "" then
					return
				end

				-- تلاش برای نصب پارسر (اگر نصب نباشد)
				local ok, task = pcall(ts.install, { lang }, { summary = false })
				if not ok then
					-- ممکن است زبان پشتیبانی نشود، بدون خطا خارج شو
					return
				end

				-- صبر تا نصب کامل شود (حداکثر ۱۰ ثانیه)
				task:wait(10000)

				-- فعال‌سازی هایلایت سینتکس
				pcall(vim.treesitter.start, event.buf, lang)
			end

			-- ایجاد autocommand با همان کد قبلی
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("custom.treesitter", { clear = true }),
				pattern = { "*" },
				callback = install_parser_and_enable_features,
			})
			-- در صورت استفاده از پلاگین‌های جداگانه مثل nvim-ts-autotag یا rainbow،
			-- آن‌ها را به‌صورت جداگانه تنظیم کنید، زیرا دیگر در treesitter تعبیه نشده‌اند.
			-- مثال برای autotag (با فرض نصب پلاگین windwp/nvim-ts-autotag):
			-- require("nvim-ts-autotag").setup()
			-- require('rainbow-delimiters.setup').setup();
		end,
	},
}
