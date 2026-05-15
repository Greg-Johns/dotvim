# AGENTS.md - Agentic Coding Guidelines

This is a Neovim configuration repository written in Lua. Use this guide for contributing code changes.

## Project Overview

Personal Neovim configuration using lazy.nvim for plugin management. Organized into:
- `init.lua` - Entry point
- `lua/gajit/` - Main configuration module
  - `set.lua` - Neovim settings/options
  - `remap.lua` - Keybindings and leader key mappings
  - `lazy_init.lua` - lazy.nvim bootstrap
  - `lazy/` - Individual plugin configurations

## Build/Test/Lint Commands

### Running/Validating the Config
```bash
# Test the configuration loads without errors
nvim --headless -c "qa" 2>&1 | grep -i error

# Syntax check (find lua syntax errors)
cd ~/.config/nvim && find lua -name "*.lua" -exec luac -p {} \;

# Check for Lua syntax in specific file
luac -p lua/gajit/path/to/file.lua
```

### For Single File Testing
```bash
# Validate a single plugin file
nvim --headless -c "source ~/.config/nvim/lua/gajit/lazy/PLUGINNAME.lua | qa"

# Check specific lua file syntax
luac -p lua/gajit/lazy/copilot.lua
```

### Git Operations
```bash
# Check git status
git status

# View recent commits
git log --oneline -10

# Create a commit (only on explicit request)
git add <files>
git commit -m "message"
```

## Code Style Guidelines

### File Organization
- **Plugin specs**: One file per plugin in `lua/gajit/lazy/PLUGINNAME.lua`
- **Settings**: Grouped logically in `set.lua` by concern (folding, tabs, display, etc.)
- **Keybindings**: Organized in `remap.lua` with comment sections grouping related bindings
- **Module structure**: Use nested requires only when necessary (prefer flat structure)

### Lua Code Style

#### Imports and Requires
```lua
-- At top of file, group by type
require("gajit.set")
require("gajit.remap")
require("gajit.lazy_init")

-- For plugin specs, assign to return value
return {
    "plugin/name",
    config = function()
        -- setup code
    end
}

-- Require plugin modules within config function
local builtin = require('telescope.builtin')
```

#### Formatting & Indentation
- Use 2 spaces for indentation (consistent with `set.lua` tabstop=2)
- No trailing whitespace
- Single line statements preferred for simple options
- Multi-line for complex configurations

#### Naming Conventions
- Variable names: `snake_case` for local variables
- Functions: `snake_case`
- Plugin names: Use lowercase with hyphens as provided by upstream
- Constants: `UPPER_SNAKE_CASE` (rarely used in this config)
- Neovim options: Use lowercase with underscores (`vim.opt.tabstop`)

#### Plugin Specification Format
```lua
return {
    "owner/plugin-name",
    branch = "x.x.x",              -- optional version
    dependencies = { ... },         -- optional deps
    config = function()             -- setup function
        require('plugin').setup({
            option1 = value1,
            option2 = value2,
        })
        -- keymaps, additional setup
    end
}
```

#### Keybindings Pattern
```lua
vim.keymap.set("n", "<leader>key", "<cmd>Command<CR>", { desc = "Description" })
--              mode    key          action                   desc for which-key

-- Multi-mode keybindings
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
```

#### Vim Settings Pattern
```lua
vim.opt.setting = value           -- Boolean options
vim.opt.setting:append("value")   -- Append to list options
vim.opt.tabstop = 2               -- Number options
vim.cmd("command")                -- Raw vim commands
vim.g.variable = value            -- Global variables
```

### Error Handling
- Use `if vim.fn.has("nvim-0.8") == 1 then` for version checks
- Shell error checking: `if vim.v.shell_error ~= 0 then` for git/system operations
- Wrap bootstrap code (like lazy.nvim setup) with error messages
- Use `vim.api.nvim_echo()` for user-facing error messages

### Comments
- Use `--` for single-line comments
- Comment above the code block it describes
- Group related keybindings with section headers:
  ```lua
  -- File Explorer (NvimTree)
  vim.keymap.set(...)

  -- General Editing
  vim.keymap.set(...)
  ```

### Configuration Best Practices
- Keep plugin files focused (one plugin per file)
- Use `config = function()` for setup, not `init`
- Pass configuration options to plugin setup, not `vim.cmd()`
- Disable filetypes in plugin config when needed (e.g., copilot.lua)
- Use descriptive keybinding descriptions for which-key integration

## File Structure Rules

When adding new plugins:
1. Create `lua/gajit/lazy/PLUGINNAME.lua`
2. Return plugin spec table with name, dependencies, config
3. Keep plugin-specific logic isolated to that file
4. Add keybindings within the plugin's config function (near usage)
5. Do NOT add to `init.lua` or root `lazy/init.lua` - lazy.nvim auto-discovers specs in `lua/gajit/lazy/`

## Version Requirements
- Neovim >= 0.8.0
- Lua 5.1+ (Neovim built-in)

## Key Architectural Patterns
- **Lazy loading**: All plugins use lazy.nvim for on-demand loading
- **Leader key**: Space (`<Space>`) is the leader key
- **Modular plugins**: Each plugin configuration is independent
- **Keybinding consistency**: All custom bindings use leader key prefix
- **No external tooling**: Configuration is purely Lua/Vimscript, no LSP linting required

## Common Patterns in Codebase

### Conditional Vim version support
```lua
if vim.fn.has("nvim-0.8") == 1 then
    -- nvim 0.8+ code
else
    -- fallback for older versions
end
```

### Getting current state
```lua
local word = vim.fn.expand("<cword>")    -- word under cursor
local cWORD = vim.fn.expand("<cWORD>")   -- WORD under cursor
```

### Executing Vim commands
```lua
vim.keymap.set("n", "<leader>cmd", "<cmd>VimCommand<CR>")  -- for commands
vim.cmd("set option=value")                                  -- for settings
```
