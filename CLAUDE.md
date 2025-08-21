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

## Comment.nvim Code Commenting

### Basic Commenting
- `gcc` - **Toggle line comment** for current line
- `gc` (Visual mode) - **Comment selected lines**
- `gbc` - **Toggle block comment** for current line (language dependent)
- `gb` (Visual mode) - **Block comment selection** (language dependent)

### Motion-Based Commenting
Comment.nvim follows Vim's operator-pending pattern, allowing you to comment with any motion:

- `gc{motion}` - **Line comment with motion**:
  - `gcip` - Comment inside paragraph
  - `gc4j` - Comment current line + 4 lines down
  - `gc}` - Comment to next paragraph
  - `gci{` - Comment inside braces `{}`
  - `gcap` - Comment around paragraph

- `gb{motion}` - **Block comment with motion** (when supported by language):
  - `gbip` - Block comment inside paragraph
  - `gb4j` - Block comment 4 lines down

### Extra Commenting Features (Optional)
**Note**: Extra features (`gcO`, `gco`, `gcA`) may not work in all configurations.
- `gcO` - Add comment above current line (and enter insert mode)
- `gco` - Add comment below current line (and enter insert mode)  
- `gcA` - Add comment at end of current line (and enter insert mode)

**Core reliable keybindings**: `gcc` and `gc` in visual mode work universally.

### Modern Community Standard: `gc` Prefix

Comment.nvim uses the `gc` prefix, which has become the **standard across the Neovim community**:

**Why `gc` is the modern standard:**
- **Mnemonic**: "Go Comment" - intuitive and memorable
- **Tim Pope's influence**: Popularized by vim-commentary (highly respected developer)
- **Vim grammar**: Follows Vim's operator pattern like `gd` (go to definition), `gf` (go to file)
- **Text object compatibility**: Works with Vim motions (`gcip`, `gci{`, `gcap`)
- **Community consensus**: Used by major plugins (Comment.nvim, vim-commentary, mini.comment)

**Modern Neovim prefix standards:**
- `gc` - Commenting operations
- `gs` - Surround operations (nvim-surround)
- `gh` - Git hunks (gitsigns.nvim)
- `gl` - LSP/diagnostics operations

### Advanced Features
- **Context-aware commenting**: Treesitter integration for mixed languages (JSX, Vue, etc.)
- **Language detection**: Automatically uses correct comment syntax for file type
- **Padding**: Adds space between comment delimiter and text
- **Sticky cursor**: Cursor stays in position after commenting
- **Lazy loading**: Only loads when opening files for better startup performance

### Comment.nvim vs NERDCommenter

**Traditional NERDCommenter:**
- `<leader>cc` - Comment line
- `<leader>cu` - Uncomment line
- `<leader>c<space>` - Toggle comment

**Modern Comment.nvim:**
- `gcc` - Toggle line comment
- `gc{motion}` - Comment with any motion
- Follows community standards and Vim grammar

### Tips for Efficient Commenting
- **Use with text objects**: `gcip` (comment paragraph), `gci{` (comment inside braces)
- **Count with motions**: `gc4j` comments 4 lines down from current
- **Visual selection**: Select text, then `gc` to comment the selection
- **Quick line additions**: `gcO` to add comment above, `gco` below

## nvim-surround Text Object Manipulation

### Why nvim-surround is Better Than vim-surround
nvim-surround is a complete rewrite that addresses the main complaint about vim-surround: **hard to remember commands**. Key improvements:
- **Visual feedback**: 2-second highlighting shows what's being surrounded
- **Better mnemonics**: "You Surround", "Delete Surround", "Change Surround"
- **Error handling**: Clear feedback when operations fail
- **Custom surrounds**: Easy to add new surround patterns
- **Modern Lua implementation**: Better Neovim integration

### Basic Operations (Easy to Remember!)

#### Adding Surrounds
**Mnemonic: "You Surround"**
- `ys{motion}{char}` - **Add surround** with motion + character
  - `ysiw"` - Surround **i**nside **w**ord with **"** quotes → `"word"`
  - `ysiw)` - Surround **i**nside **w**ord with **)** parens → `(word)`
  - `ysip}` - Surround **i**nside **p**aragraph with **}** braces → `{paragraph}`
  - `yss"` - Surround entire **s**entence/line with **"** quotes

#### Visual Mode Surround (Super Easy!)
- **Select text, then `S{char}`** - **S**urround selection
  - Select text → `S"` - Wrap with quotes
  - Select text → `S)` - Wrap with parentheses
  - Select text → `S}` - Wrap with braces
  - Select text → `S<p>` - Wrap with HTML tag

#### Deleting Surrounds
**Mnemonic: "Delete Surround"**
- `ds{char}` - **Delete surround** character
  - `ds"` - Delete quotes: `"hello"` → `hello`
  - `ds)` - Delete parentheses: `(word)` → `word`
  - `ds}` - Delete braces: `{text}` → `text`
  - `dst` - Delete HTML tag: `<p>text</p>` → `text`

#### Changing Surrounds
**Mnemonic: "Change Surround"**
- `cs{old}{new}` - **Change surround** from old to new
  - `cs"'` - Change quotes: `"hello"` → `'hello'`
  - `cs)]` - Change parens to brackets: `(word)` → `[word]`
  - `cs}]` - Change braces to brackets: `{text}` → `[text]`
  - `cs<p><div>` - Change HTML tags: `<p>text</p>` → `<div>text</div>`

### Advanced Features

#### Smart Bracket Handling
- `(` - Adds spaces: `ysiw(` → `( word )`
- `)` - No spaces: `ysiw)` → `(word)`
- `{` - Adds spaces: `ysiw{` → `{ word }`
- `}` - No spaces: `ysiw}` → `{word}`

#### Custom Function Surround
- `ysf` - **Function surround** (custom feature!)
  - Prompts: "Enter the function name: "
  - Input `console.log` → wraps with `console.log(text)`
  - `dsf` - Delete function call
  - `csf` - Change function name

#### Text Objects Integration
Works with all Vim text objects:
- `ysi"'` - Change inside quotes: `"hello"` → `'hello'`
- `ysa"'` - Change around quotes (same effect)
- `ysi{]` - Change inside braces to brackets
- `ysip"` - Surround paragraph with quotes

### Common Surround Characters
- `"` `'` `` ` `` - Quote marks
- `(` `)` - Parentheses (with/without spaces)
- `[` `]` - Square brackets
- `{` `}` - Curly braces
- `<` `>` - Angle brackets
- `t` - HTML/XML tags (prompts for tag name)
- `f` - Function calls (custom - prompts for function name)

### Learning Tips
1. **Start simple**: Practice `ysiw"` (surround word with quotes)
2. **Use visual mode**: Select text, then `S"` - very intuitive
3. **Watch the highlights**: 2-second visual feedback helps you learn
4. **Remember mnemonics**: "You Surround", "Delete Surround", "Change Surround"
5. **Practice common patterns**: `cs"'` (change quotes), `ds)` (delete parens)

### Practical Examples
```
Original: hello world
ysiw"    → "hello" world    (surround word with quotes)
yss)     → (hello world)     (surround line with parens)

Original: "hello world"
ds"      → hello world       (delete quotes)
cs"'     → 'hello world'     (change double to single quotes)

Original: (hello)
cs)]     → [hello]           (change parens to brackets)
```

The visual highlighting makes learning much easier - you'll see exactly what nvim-surround is doing!

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
- code is only for windows