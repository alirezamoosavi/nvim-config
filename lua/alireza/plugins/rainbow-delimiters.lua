return {
  "hiphish/rainbow-delimiters.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    -- تنظیمات ساده و پیش‌فرض
    require("rainbow-delimiters.setup").setup({
      strategy = {
        -- استراتژی پیش‌فرض برای همه زبان‌ها
        [""] = require("rainbow-delimiters.strategy.global"),
      },
      query = {
        -- کوئری پیش‌فرض برای همه زبان‌ها
        [""] = "rainbow-delimiters",
      },
      highlight = {
        -- لیست رنگ‌هایی که به ترتیب به سطوح مختلف اختصاص می‌یابند
        "RainbowDelimiterRed",
        "RainbowDelimiterYellow",
        "RainbowDelimiterBlue",
        "RainbowDelimiterOrange",
        "RainbowDelimiterGreen",
        "RainbowDelimiterViolet",
        "RainbowDelimiterCyan",
      },
    })
  end,
}
