# Neovim Configuration

Modern Neovim configuration with Lua, optimized for TypeScript/JavaScript development.

## Features

### Core
- **Manager**: [lazy.nvim](https://github.com/folke/lazy.nvim) - Modern plugin manager
- **Theme**: [catppuccin](https://github.com/catppuccin/nvim) - Soothing pastel theme
- **Statusline**: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim) - Customizable statusline
- **Icons**: [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons) - File type icons

### Navigation & Search
- **Fuzzy Finder**: [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim)
  - `<space>ff` - Find files
  - `<space>fg` - Live grep
  - `<space>fb` - Find buffers
  - `<space>fh` - Help tags
  - `<C-p>` - Git files
- **File Explorer**: [nvim-tree.lua](https://github.com/nvim-tree/nvim-tree.lua)
  - `<space>e` - Toggle file explorer

### Language Support
- **Treesitter**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)
  - Syntax highlighting
  - Better indentation
  - Incremental selection
- **LSP**: Built-in LSP with mason
  - TypeScript/JavaScript (tsserver)
  - Lua (lua_ls)
  - JSON (jsonls)
  - YAML (yamlls)
- **Autocompletion**: [nvim-cmp](https://github.com/hrsh7th/nvim-cmp)
  - Snippet support (LuaSnip)
  - Buffer, path, LSP sources

### Git Integration
- **Gitsigns**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)
  - See changes in sign column
  - Stage/revert hunks
  - Blame preview

### Editing Essentials
- **Commenting**: [Comment.nvim](https://github.com/numToStr/Comment.nvim)
  - `gcc` - Toggle line comment
  - `gc` - Toggle comment in visual mode
- **Auto-pairs**: [nvim-autopairs](https://github.com/windwp/nvim-autopairs)
  - Automatic bracket pairing
- **Indent guides**: [indent-blankline.nvim](https://github.com/lukas-reineke/indent-blankline.nvim)

## Installation

### Prerequisites
- [Neovim 0.8+](https://neovim.io/)
- Git
- A Nerd Font (optional, for icons)

### Setup

1. Backup your existing config:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
mv ~/.local/share/nvim ~/.local/share/nvim.backup
```

2. Clone this repository:
```bash
git clone https://github.com/germanolira/nvim-config.git ~/.config/nvim
```

3. Start Neovim and plugins will install automatically:
```bash
nvim
```

4. Install LSP servers:
- Open Neovim
- Run `:Mason`
- Press `i` on each LSP you want to install

## Key Mappings

### Leader key: `<space>`

### Navigation
| Key | Action |
|-----|--------|
| `<space>ff` | Find files (Telescope) |
| `<space>fg` | Live grep |
| `<space>fb` | Find buffers |
| `<space>fh` | Help tags |
| `<space>e` | Toggle file explorer |
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |

### Editing
| Key | Action |
|-----|--------|
| `jk` or `JK` | Exit insert mode |
| `<space>w` | Save file |
| `<space>q` | Quit |
| `<space>x` | Save and quit |
| `<space>y` | Yank to clipboard |
| `<space>+` / `<space>-` | Increment/decrement number |

### Git
| Key | Action |
|-----|--------|
| `]c` / `[c` | Next/previous hunk |
| `<space>hs` | Stage hunk |
| `<space>hr` | Reset hunk |
| `<space>hp` | Preview hunk |
| `<space>hb` | Blame line |

### Window Management
| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate splits |
| `<space>v` | Vertical split |
| `<space>s` | Horizontal split |
| `<space>=` | Equalize splits |

## Language Support

### Pre-installed Treesitter Parsers
- TypeScript / TSX
- JavaScript
- Lua
- JSON / JSONC
- YAML
- Bash
- Markdown

### Pre-configured LSPs
- tsserver (TypeScript/JavaScript)
- lua_ls (Lua)
- jsonls (JSON)
- yamlls (YAML)

## Customization

### Adding New Plugins

Edit `lua/plugins/init.lua` and add to the plugins table:

```lua
{
  "author/plugin-name",
  config = function()
    -- Plugin setup
  end
}
```

### Changing Options

Edit `lua/config/options.lua` for general settings.
Edit `lua/config/keymaps.lua` for key mappings.

### Changing Theme

In `lua/plugins/init.lua`, find:
```lua
vim.cmd.colorscheme("catppuccin")
```

And change to your preferred theme.

## Troubleshooting

### Plugin installation fails
1. Delete `~/.local/share/nvim/lazy`
2. Restart Neovim

### LSP not working
1. Run `:Mason`
2. Ensure LSP is installed
3. Check `:LspInfo` for status

### Colors look wrong
1. Ensure your terminal supports true colors
2. Check `$TERM` environment variable

## Inspiration

This config is optimized for:
- TypeScript/JavaScript development
- React Native projects
- Fast navigation with fuzzy finding
- Modern LSP features

Perfect for developers coming from VS Code who want to try Neovim with a familiar, fully-featured setup.

## License

MIT
