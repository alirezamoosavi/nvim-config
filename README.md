# Alireza's Neovim Configuration

<div align="center">

[![Neovim](https://img.shields.io/badge/NeoVim-%2357A143.svg?&style=for-the-badge&logo=neovim&logoColor=white)](https://neovim.io/)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&logoColor=white)](https://www.lua.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

</div>

A highly customized Neovim configuration based on [AstroNvim](https://github.com/AstroNvim/AstroNvim), tailored for efficient development with a focus on modern tooling and an intuitive user experience.

## ✨ Features

- **Modern Plugin Management**: Using `lazy.nvim` for fast and efficient plugin management
- **LSP Integration**: Full Language Server Protocol support with pre-configured servers
- **Tree-sitter**: Enhanced syntax highlighting and parsing
- **Telescope**: Powerful fuzzy finder for files, buffers, and more
- **Git Integration**: Seamless Git workflow with `gitsigns.nvim`
- **Debugging Support**: Built-in DAP (Debug Adapter Protocol) configuration
- **AI Integration**: Includes plugins like Avante for AI-assisted coding
- **Beautiful UI**: Custom status line, buffer line, and file explorer with icons
- **Smart Completion**: Advanced autocompletion and snippets

## 📦 Plugins Included

This configuration includes a carefully curated set of plugins for an optimal development experience:

### Core Plugins
- `telescope.nvim` - Fuzzy finder
- `nvim-treesitter` - Syntax highlighting
- `lsp-zero` - LSP configuration
- `mason.nvim` - LSP/DAP/Linter/Formatter manager
- `nvim-web-devicons` - File type icons
- `which-key.nvim` - Key binding hints
- `nvim-autopairs` - Auto-closing pairs
- `comment.nvim` - Smart comment toggling

### UI Enhancement
- `alpha-nvim` - Dashboard
- `lualine.nvim` - Status line
- `bufferline.nvim` - Tab/buffer line
- `neo-tree.nvim` - File explorer
- `toggleterm.nvim` - Toggle terminal
- `trouble.nvim` - LSP diagnostics list
- `snacks.nvim` - Additional UI enhancements

### Development Tools
- `nvim-dap` - Debug Adapter Protocol
- `nvim-dap-go` - Go language debugging
- `telescope` extensions for various tools
- `goto-preview` - Preview definitions in floating windows
- `actions-preview` - Preview actions
- `luasnip` - Snippet engine

### AI & Coding Assistance
- `avante.nvim` - AI assistant
- `codecompanion.nvim` - AI coding assistant
- `blink.cmp` - Modern completion engine

## ⚡ Requirements

- [Nerd Fonts](https://www.nerdfonts.com/font-downloads) (_Required for icons_)
- [Neovim 0.9.5+ (_Not_ including nightly)](https://github.com/neovim/neovim/releases/tag/stable)
- [Tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) (_Note:_ This is only necessary if you want to use `auto_install` feature with Treesitter)
- A clipboard tool is necessary for the integration with the system clipboard (see [`:help clipboard-tool`](https://neovim.io/doc/user/provider.html#clipboard-tool) for supported solutions)
- Terminal with true color support (for the default theme, otherwise it is dependent on the theme you are using)

### Optional Requirements
- [ripgrep](https://github.com/BurntSushi/ripgrep) - live grep telescope search (`<leader>fw`)
- [lazygit](https://github.com/jesseduffield/lazygit) - git ui toggle terminal (`<leader>tl` or `<leader>gg`)
- [gdu](https://github.com/dundee/gdu) - disk usage toggle terminal (`<leader>tu`)
- [bottom](https://github.com/ClementTsang/bottom) - process viewer toggle terminal (`<leader>tt`)
- [Python](https://www.python.org/) - python repl toggle terminal (`<leader>tp`)
- [Node](https://nodejs.org/en/) - node repl toggle terminal (`<leader>tn`)

> [!NOTE]
> <sup id="1">[1]</sup> All downloadable Nerd Fonts contain icons which are used by this configuration. Install the Nerd Font of your choice to your system and in your terminal emulator settings, set its font face to that Nerd Font. If you are using this configuration on a remote system via SSH, you do not need to install the font on the remote system.

> [!NOTE]
> <sup id="2">[2]</sup> Note when using default theme: For MacOS, the default terminal does not have true color support. You will need to use [iTerm2](https://iterm2.com/), [Kitty](https://sw.kovidgoyal.net/kitty/), [WezTerm](https://wezfurlong.org/wezterm/), or another [terminal emulator](https://github.com/termstandard/colors?tab=readme-ov-file#truecolor-support-in-output-devices) that has true color support.

## 🛠️ Installation

### Linux/Mac OS (Unix)

#### Make a backup of your current nvim and shared folder

```shell
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```

#### Clone the repository

```shell
git clone --depth 1 https://github.com/alirezamoosavi/nvim-config ~/.config/nvim
rm -rf ~/.config/nvim/.git
nvim
```

## 🚀 Usage

After installation, launch Neovim with `nvim`. The configuration will automatically install all plugins on the first run. This may take a few minutes depending on your internet connection and system performance.

### Key Mappings

This configuration uses a leader-based key mapping system with `<leader>` (space) as the primary key:

- `<leader>ff` - Find files with telescope
- `<leader>fg` - Live grep with telescope
- `<leader>fb` - Find buffers with telescope
- `<leader>fh` - Find help with telescope
- `<leader>gg` - Open lazygit
- `<leader>ll` - Open LSP log
- `<leader>li` - Show LSP info
- `<leader>rn` - Rename symbol under cursor
- `<leader>ca` - Code action
- `<leader>gd` - Go to definition
- `<leader>gr` - Go to references
- `<leader>q` - Quit
- `<leader>w` - Write
- `<leader>nt` - Toggle file tree
- `<leader>tt` - Toggle terminal
- `<leader>tf` - Toggle file tree and terminal vertically

For a complete list of key mappings, use `<leader>kh` to open the which-key menu.

## 🎨 Customization

To customize this configuration:

1. Fork this repository
2. Modify the Lua files in the `lua/alireza/` directory:
   - `core/` contains general configuration (options, keymaps, autocmds)
   - `plugins/` contains plugin-specific configurations
   - `lazy.lua` manages plugin loading
3. Commit and push your changes

## 🤝 Contributing

Feel free to fork this repository and submit pull requests. You can also open issues for bugs or feature requests.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👤 Author

**Alireza Moosavi**

- GitHub: [@alirezamoosavi](https://github.com/alirezamoosavi)
- Repository: [nvim-config](https://github.com/alirezamoosavi/nvim-config)

## 🙏 Acknowledgments

- [AstroNvim](https://github.com/AstroNvim/AstroNvim) for the excellent foundation
- All the plugin authors whose work makes this configuration possible
- The Neovim community for continuous improvements and support
