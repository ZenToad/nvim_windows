# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Neovim configuration optimized for development on Windows. The configuration uses Lazy.nvim as the plugin manager and follows a modular structure with comprehensive editing tools.

## Development Commands


### Configuration Management
- `<leader>af` or `:source ./init.lua` - Reload the Neovim configuration
- `<leader>ev` - Open vimrc directory in a new tab with nvim-tree

### Plugin Management
Plugin installation and updates are handled automatically by Lazy.nvim. The lock file is `lazy-lock.json`.

## nvim-tree File Explorer

### Basic Navigation
- `<C-k><C-b>` - Toggle nvim-tree open/closed
- `<leader>ev` - Open nvim-tree in config directory (new tab)

### File Operations (within nvim-tree)
- `<CR>`, `o`, or `l` - Open file/folder
- `<C-v>` - Open file in vertical split
- `<C-x>` - Open file in horizontal split
- `<C-t>` - Open file in new tab
- `<C-e>` - Open file in place (replace tree buffer)
- `s` - Open file with system default application
- `P` - Go to parent directory
- `<BS>` - Close directory node
- `<C-]>` - **Change working directory** to directory under cursor
- `-` - Navigate up to parent directory (can go beyond workspace root)

### File Management
- `a` - Create new file/directory (add `/` for directory)
- `d` - Delete file/directory
- `r` - Rename file/directory (keep original name as starting point)
- `<C-r>` - Rename file/directory (clear original name)
- `c` - Copy file/directory
- `x` - Cut file/directory
- `p` - Paste file/directory
- `y` - Copy filename to clipboard
- `Y` - Copy relative path to clipboard
- `gy` - Copy absolute path to clipboard

### Tree Navigation & Management
- `H` - Toggle hidden files (dotfiles)
- `R` - Refresh tree (reread filesystem)
- `W` - Collapse all open folders
- `E` - Expand entire tree from root
- `>` and `<` - Navigate up/down tree to next sibling
- `<C-k>` - Show file info
- `g?` - Show help/keybindings

### Window Management
- `<C-w>` followed by direction - Move between nvim-tree and editor windows
- Focus automatically shifts when opening files

### Git Integration
- Files show git status with icons:
  - `✓` - Clean/unmodified
  - `M` - Modified
  - `A` - Added/staged
  - `D` - Deleted
  - `R` - Renamed
  - `?` - Untracked

### Configuration
- Shows hidden files by default (dotfiles = false)
- Ignores: `.git`, `node_modules`, `.DS_Store`
- Git integration enabled
- Icons provided by nvim-web-devicons
- 30 character width sidebar

## Flash.nvim Motion Navigation

### Basic Navigation
- `s` - **Flash jump** - Main motion command for jumping anywhere
- `<leader>s` (`,s`) - **Flash Treesitter** - Jump to code structures (functions, classes, etc.)

### How Flash Works
Flash.nvim revolutionizes motion by providing intelligent, adaptive labeling:

1. **Start typing**: Press `s` and begin typing the target text
2. **Dynamic labels**: Labels appear and adapt as you type more characters
3. **Smart targeting**: The more you type, the fewer labels needed
4. **Instant jump**: When target is unique enough, jump happens automatically

### Advanced Features
- `r` (operator-pending) - **Remote Flash** - Use flash motions with operators (like `dr` to delete to flash target)
- `R` (visual/operator-pending) - **Treesitter Search** - Search within code structures
- `<C-s>` (command mode) - **Toggle Flash Search** - Enhance `/` search with flash labels

### Flash vs Traditional EasyMotion
**Traditional EasyMotion workflow:**
1. Press `<leader><leader>w` 
2. See all possible targets labeled
3. Press the label character

**Flash.nvim workflow:**
1. Press `s`
2. Start typing target text naturally
3. Labels appear only when needed
4. Jump when target becomes clear

### Configuration Features
- **Multi-window support**: Jump across different windows seamlessly
- **Treesitter integration**: `<leader>s` understands code structure
- **Search enhancement**: Works with Neovim's native search (`/`)
- **Smart labeling**: Uses `asdfghjklqwertyuiopzxcvbnm` for easy typing
- **Backdrop highlighting**: Dims non-target text for better focus

### Tips for Maximum Speed
- **Type more characters**: Don't stop at 1-2 chars, keep typing until labels are minimal
- **Use Treesitter mode**: `<leader>s` for jumping to functions, classes, variables
- **Combine with operators**: `ds` (delete to flash target), `cs` (change to flash target)
- **Cross-window navigation**: Flash works across multiple windows automatically

## Architecture

### Entry Points
- `init.lua` - Main entry point that loads the zentoad module and Windows-specific mswin.vim
- `lua/zentoad/init.lua` - Loads core config and plugin system
- `lua/zentoad/config.lua` - Core Neovim settings, keybindings, and UI configuration
- `lua/zentoad/lazy.lua` - Lazy.nvim plugin manager setup

### Plugin Organization
Plugins are organized in `lua/zentoad/plugins/` with each file handling specific functionality:
- `telescope.lua` - Fuzzy finder and search tools using ripgrep
- `file_explorer.lua` - nvim-tree file browser with devicons
- `terminal.lua` - ToggleTerm for integrated terminal functionality
- `colorscheme.lua` - Kanagawa color scheme
- `treesitter.lua` - Syntax highlighting and parsing
- `session.lua` - Session management
- `acme.lua` - Acme editor-inspired functionality

### Key Configurations


#### Leader Key and Navigation
- Leader key is comma (`,`)
- Custom keybindings for window navigation (`<C-H>`, `<C-J>`, `<C-K>`, `<C-L>`)
- Terminal mode escape with `ESC` key
- Line movement with `<A-j>` and `<A-k>`

#### File Management
- Uses nvim-tree (`<C-k><C-b>`) for file exploration
- Telescope fuzzy finding:
  - `<leader>ff` or `<C-p>` - Find git files
  - `<leader>fa` or `<leader>pf` - Find all files
  - `<leader>fg` or `<leader>ps` - Live grep search
  - `<leader>fb` - Find buffers
  - `<leader>fh` - Help tags

#### Diagnostics
- Enhanced diagnostic display with auto-popup on cursor hold (500ms)
- Custom diagnostic navigation (`]d`, `[d`)
- Diagnostic management keybindings (`<leader>dl`, `<leader>dq`, `<leader>do`)

### Font Configuration
The configuration expects Mononoki Nerd Font. After font changes, the nvim-data folder may need to be deleted due to plugin font caching.

## Windows-Specific Features
- Loads mswin.vim for Windows-style shortcuts
- Undo directory set to `~/.vim/undodir`