return {
  "windwp/nvim-ts-autotag",
  dependencies = { "nvim-treesitter/nvim-treesitter" }, 
  config = function()
    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true,          -- فعال‌سازی بستن خودکار تگ (پیش‌فرض: true)
        enable_rename = true,         -- فعال‌سازی تغییر نام خودکار تگ (پیش‌فرض: true)
        enable_close_on_slash = false -- بستن خودکار تگ با تایپ </ (پیش‌فرض: false)
      },
      -- در صورت نیاز، تنظیمات خاص برای یک نوع فایل خاص را اینجا اضافه کنید
      -- per_filetype = {
      --   ["html"] = { enable_close = false }
      -- }
    })
  end,
}
