# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview
This is a Neovim configuration optimized for Windows development, supporting Rust, Odin, and C/C++ development. The configuration uses Lazy.nvim as the plugin manager and follows a modular structure with comprehensive language support including LSP, debugging, formatting, and build tools.

## Development Commands

### Build Commands
- `<leader>m` or `:TermExec cmd="build.bat" go_back=0 direction="float"` - Run build.bat in a floating terminal
- `<F5>` or `:TermExec cmd="build_hot_reload.bat run" go_back=0 direction="float"` - Run hot reload build script

### Rust Development Commands
- `<leader>rcc` - Cargo check (validate code without building)
- `<leader>rcb` - Cargo build (compile the project)
- `<leader>rcr` - Cargo run (build and run the project)
- `<leader>rct` - Cargo test (run tests)
- `<leader>rcf` - Cargo fmt (format code)
- `<leader>rcl` - Cargo clippy (linting)
- `<leader>rcd` - Cargo doc --open (generate and open documentation)

### Rust-Specific Keybindings (in Rust files)
- `<leader>rr` - Show Rust runnables (via rustaceanvim)
- `<leader>rt` - Show Rust testables
- `<leader>rd` - Show Rust debuggables
- `<leader>re` - Expand macro under cursor
- `<leader>rc` - Open Cargo.toml
- `<leader>rp` - Go to parent module
- `<leader>ra` - Show code actions
- `K` - Enhanced hover with actions

### Cargo.toml Management (crates.nvim)
- `<leader>ct` - Toggle crates display
- `<leader>cv` - Show available versions
- `<leader>cf` - Show crate features
- `<leader>cu` - Update crate under cursor
- `<leader>ca` - Update all crates
- `<leader>cH` - Open crate homepage

### Configuration Management
- `<leader>af` or `:source ./init.lua` - Reload the Neovim configuration
- `<leader>ev` - Open vimrc directory in a new tab with NERDTree

### Plugin Management
Plugin installation and updates are handled automatically by Lazy.nvim. The lock file is `lazy-lock.json`.

## Architecture

### Entry Points
- `init.lua` - Main entry point that loads the zentoad module and Windows-specific mswin.vim
- `lua/zentoad/init.lua` - Loads core config and plugin system
- `lua/zentoad/config.lua` - Core Neovim settings, keybindings, and UI configuration
- `lua/zentoad/lazy.lua` - Lazy.nvim plugin manager setup

### Plugin Organization
Plugins are organized in `lua/zentoad/plugins/` with each file handling specific functionality:
- `lsp.lua` - LSP configuration with Mason, rust-analyzer, clangd, and Odin Language Server (OLS)
- `rust.lua` - Comprehensive Rust development tools (rustaceanvim, crates.nvim)
- `telescope.lua` - Fuzzy finder and search tools using ripgrep
- `file_explorer.lua` - NERDTree file browser with devicons
- `terminal.lua` - ToggleTerm for integrated terminal functionality
- `colorscheme.lua` - Kanagawa color scheme
- `treesitter.lua` - Syntax highlighting and parsing
- `debugging.lua` - Debug adapter protocol setup with support for C/C++, Rust, and Odin
- `session.lua` - Session management
- `acme.lua` - Acme editor-inspired functionality
- `vimwiki.lua` - Wiki and note-taking features

### Key Configurations

#### LSP Setup
- Uses Mason for rust-analyzer, clangd, and other language servers except OLS (Odin Language Server)
- **Rust**: rust-analyzer with comprehensive settings for cargo integration, inlay hints, and proc macros
- **C/C++**: clangd with compile_commands.json detection
- **Odin**: OLS manually configured with absolute path: `C:\dev\ols\ols.exe`
- Custom Odin filetype detection for `.odin` files

#### Leader Key and Navigation
- Leader key is comma (`,`)
- Custom keybindings for window navigation (`<C-H>`, `<C-J>`, `<C-K>`, `<C-L>`)
- Terminal mode escape with `ESC` key
- Line movement with `<A-j>` and `<A-k>`

#### File Management
- Uses NERDTree (`<C-k><C-b>`) for file exploration
- Telescope for fuzzy finding files (`<leader>pf`, `<C-p>` for git files)
- Live grep search with `<leader>ps`

#### Diagnostics and Debugging
- Enhanced diagnostic display with auto-popup on cursor hold (500ms)
- Custom diagnostic navigation (`]d`, `[d`)
- Diagnostic management keybindings (`<leader>dl`, `<leader>dq`, `<leader>do`)
- **Debugging**: Integrated DAP with support for:
  - **C/C++**: LLDB adapter
  - **Rust**: CodeLLDB adapter with cargo integration
  - Debug keybindings: `<F6>` (continue), `<F10>` (step over), `<F11>` (step into), `<F12>` (step out)
  - Breakpoint management: `<leader>b` (toggle), `<leader>B` (conditional)

### Font Configuration
The configuration expects Mononoki Nerd Font. After font changes, the nvim-data folder may need to be deleted due to plugin font caching.

## Windows-Specific Features
- Loads mswin.vim for Windows-style shortcuts
- Build commands expect `.bat` files (build.bat, build_hot_reload.bat)
- OLS path configured for Windows (`C:\dev\ols\ols.exe`)
- LLDB debugger path: `C:\Program Files\LLVM\bin\lldb-dap.exe`
- Undo directory set to `~/.vim/undodir`

## Rust Development Workflow
1. **Setup**: 
   - Ensure rust-analyzer is installed via Mason (`:Mason`)
   - CodeLLDB debugger will be automatically installed via mason-nvim-dap
   - If debugging doesn't work, manually install: `:MasonInstall codelldb`
2. **Project**: Navigate to Rust project root (Cargo.toml should be present)
3. **Development**: Use `<leader>rcc` for quick checks, `<leader>rcr` to run
4. **Testing**: Use `<leader>rct` for cargo test, `<leader>rt` for individual test selection
5. **Debugging**: 
   - Use `<leader>rd` to show debug targets, then `<F6>` to start debugging
   - CodeLLDB will be automatically located via Mason installation
   - Supports both direct executable and cargo-based debugging
6. **Dependencies**: In Cargo.toml, use crates.nvim commands (`<leader>cv`, `<leader>cu`) to manage dependencies
7. **Formatting**: `<leader>rcf` runs cargo fmt, or enable format-on-save via LSP

## Troubleshooting
- **"codelldb not found"**: Run `:MasonInstall codelldb` to manually install the debugger
- **Debug adapter issues**: Check `:Mason` to ensure codelldb is installed and up to date
- **Rust-analyzer not working**: Verify installation with `:Mason` and restart Neovim