# Neovim Cheatsheet - Cogi Config

## VS Code vs Neovim Mapping

| VS Code Action | Neovim Command | Key |
|----------------|----------------|-----|
| Open File | Telescope find_files | `<spc>ff` |
| Search in Files | Telescope live_grep | `<spc>fg` |
| Toggle Sidebar | NvimTreeToggle | `<spc>e` |
| Command Palette | Telescope commands | (use `:`) |
| Go to Definition | LSP goto definition | `gd` |
| Peek Definition | LSP hover | `K` |
| Find References | LSP references | `gr` |
| Rename | LSP rename | `<spc>rn` |
| Format Document | LSP format | `<spc>f` |
| Quick Fix | Code actions | `<spc>ca` |
| Close Editor | Close buffer | `:q` |
| Save | Save file | `<spc>w` |
| Split Editor | Split window | `<spc>v` (vertical) / `<spc>s` (horizontal) |
| Navigate Tabs | Navigate buffers | Use `<spc>fb` or buffer switching |

## Essential Neovim Motions (Vim Basics)

### Movement
- `h/j/k/l` - Left/Down/Up/Right
- `w` - Next word
- `b` - Previous word
- `0` - Beginning of line
- `$` - End of line
- `gg` - Top of file
- `G` - Bottom of file
- `Ctrl+u` - Half page up
- `Ctrl+d` - Half page down
- `f<char>` - Find character forward
- `F<char>` - Find character backward

### Editing
- `i` - Insert mode
- `a` - Insert after cursor
- `I` - Insert at beginning of line
- `A` - Insert at end of line
- `o` - New line below
- `O` - New line above
- `d` - Delete (use with motion: `dw`, `dd`, `d$`)
- `c` - Change (delete + insert)
- `y` - Yank (copy)
- `p` - Paste below
- `P` - Paste above
- `u` - Undo
- `Ctrl+r` - Redo

### Visual Mode
- `v` - Visual character mode
- `V` - Visual line mode
- `Ctrl+v` - Visual block mode

### Commands (in Normal mode, type `:`
- `:w` - Save
- `:q` - Quit
- `:wq` or `:x` - Save and quit
- `:qa!` - Force quit all
- `:e <file>` - Edit file
- `:vs <file>` - Vertical split with file
- `:sp <file>` - Horizontal split with file

## Cogi Custom Keymaps

### Leader Key: `<space>`

### Navigation
- `<spc>ff` - Find files (Telescope)
- `<spc>fg` - Live grep in files
- `<spc>fb` - Find buffers
- `<spc>fh` - Find help tags
- `<spc>fw` - Find git files
- `<spc>e` - Toggle file explorer (NvimTree)

### LSP (Language Server Protocol)
- `gd` - Go to definition
- `gD` - Go to declaration
- `gi` - Go to implementation
- `gr` - Find references
- `K` - Hover documentation
- `<C-k>` - Signature help
- `<spc>D` - Type definition
- `<spc>rn` - Rename symbol
- `<spc>ca` - Code actions
- `<spc>f` - Format document

### Git (Gitsigns)
- `]c` - Next hunk
- `[c` - Previous hunk
- `<spc>hs` - Stage hunk
- `<spc>hr` - Reset hunk
- `<spc>hS` - Stage buffer
- `<spc>hu` - Undo stage hunk
- `<spc>hR` - Reset buffer
- `<spc>hp` - Preview hunk
- `<spc>hb` - Blame line

### Window Management
- `<C-h/j/k/l>` - Navigate between splits
- `<spc>v` - Vertical split
- `<spc>s` - Horizontal split
- `<spc>=` - Equalize splits

### Editing
- `jk` or `JK` - Exit insert mode
- `<spc>y` - Yank to system clipboard
- `<spc>d` - Delete to void register
- `<spc>p` in visual mode - Paste without losing register
- `<spc>+` - Increment number
- `<spc>-` - Decrement number
- `<spc>h` - Clear search highlight

### Files
- `<spc>w` - Save file
- `<spc>q` - Quit
- `<spc>x` - Save and quit
- `<spc>Q` - Force quit all

## Tips for VS Code Users

1. **Start Slow**: Use Neovim for simple edits first
2. **Use Telescope**: It's like VS Code's command palette + file search
3. **LSP Features**: gd, gr, K are your friends (goto definition, references, hover)
4. **Split Navigation**: Use Ctrl+h/j/k/l to move between splits
5. **Search**: `<spc>fg` is like VS Code's search in files
6. **Don't Panic**: Press `i` to insert, `jk` to exit, `:w` to save
7. **Use NvimTree**: `<spc>e` toggles the file explorer
8. **Git**: `<spc>hp` previews changes, `<spc>hs` stages them

## First Steps

1. Open a file: `nvim file.ts`
2. Enter insert mode: `i`
3. Type something
4. Exit insert mode: `jk`
5. Save: `<spc>w`
6. Use Telescope: `<spc>ff` to find files
7. Explore file tree: `<spc>e`
8. Try LSP: Move cursor over a function and press `gd`

## Treesitter Languages Installed

- TypeScript/TSX (your React Native project!)
- JavaScript
- Lua (for Neovim config)
- JSON/JSONC
- YAML
- Bash
- Markdown
- Git files

## Your Config Location

`~/.config/nvim/`

- `init.lua` - Main entry point
- `lua/config/` - Configuration files
- `lua/plugins/` - Plugin setup

## Installing Additional LSPs

Run `:Mason` to install more language servers
