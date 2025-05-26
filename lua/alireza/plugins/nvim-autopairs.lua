return {
  "windwp/nvim-autopairs",
  event = { "InsertEnter" },
  config = function()
    -- import nvim-autopairs
    local autopairs = require("nvim-autopairs")

    -- configure autopairs
    autopairs.setup({
      disable_filetype = { "TelescopePrompt" , "vim" },
      map_cr = true,
      check_ts = true, -- enable treesitter
      fast_wrap = {
         map = '<M-e>',
         chars = { '{', '[', '(', '"', "'" },
         pattern = [=[[%'%"%>%]%)%}%,]]=],
         end_key = '$',
         before_key = 'h',
         after_key = 'l',
         cursor_pos_before = true,
         keys = 'qwertyuiopzxcvbnmasdfghjkl',
         manual_position = true,
         highlight = 'Search',
         highlight_grey='Comment'
      },
      ts_config = {
        lua = { "string" }, -- don't add pairs in lua string treesitter nodes
        javascript = { "template_string" }, -- don't add pairs in javscript template_string treesitter nodes
        java = false, -- don't check treesitter on java
      },
    })

  end,
}
