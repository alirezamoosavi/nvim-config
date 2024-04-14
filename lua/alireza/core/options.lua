local opt = vim.opt -- for conciseness

-- line numbers
opt.relativenumber = true -- show relative line numbers
opt.number = true -- shows absolute line number on cursor line (when relative number is on)

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- disable line wrapping

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false

-- The terminal is in charge of Bi-directionality of text (as specified by Unicode)
opt.termbidi = true -- support arabic and persian language

opt.foldmethod = "indent"
opt.foldlevel = 99

opt.fileformat = "unix"

opt.nu = true
opt.softtabstop = 4

opt.smartindent = true

opt.undofile = true
opt.undolevels = 30000

opt.hlsearch = true
opt.incsearch = true

opt.scrolloff = 8
opt.isfname:append("@-@")

opt.updatetime = 50

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

opt.autowrite = true -- Enable auto write
opt.completeopt = "menu,menuone,noselect"
opt.clipboard = "unnamedplus" -- Sync with system clipboard

opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.spelllang = { "en" }
opt.showmode = false
opt.shortmess:append({ W = true, I = true, c = true })
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.inccommand = "nosplit" -- preview incremental substitute
opt.laststatus = 0
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = "a" -- Enable mouse mode
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"

--vim.g.markdown_recommended_style = 0

vim.opt.formatoptions:remove({ "c", "r", "o" })
