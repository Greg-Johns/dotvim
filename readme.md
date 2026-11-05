# Neovim Configuration

My personal Neovim configuration honed through many hours of noodeling.

## Prerequisites

- Neovim >= 0.11
- Git
- A Nerd Font (for icons)

## Installation

```bash
# Backup your existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this repository
git clone <your-repo-url> ~/.config/nvim

# Open Neovim
nvim
```

## Key Mappings
#### Leader Key
The leader key is set to ```<Space>```.

#### File Explorer (Snacks)
  * ```<leader>ee``` - Toggle file explorer
  * ```<leader>ef``` - Reveal current file in explorer

#### Find (Snacks Picker)
  * ```<leader>ff``` - Find files
  * ```<C-f>``` - Find git files
  * ```<leader>fg``` - Live grep
  * ```<leader>fh``` - Recent files

#### OpenCode
  * ```<leader>oa``` - Ask OpenCode about the selection
  * ```<leader>os``` - Select an OpenCode action
  * See `docs/KEYBINDINGS.md` for the full `<leader>o` group

#### General Editing
  * ```jk``` (in insert mode) - Quick escape to normal mode
  * ```<leader>nh``` - Clear search highlights
  * ```J``` (visual mode) - Move selected line down
  * ```K``` (visual mode) - Move selected line up
  * ```J``` (normal mode) - Append next line to current line
Navigation
  * <C-d> - Half page down (cursor stays centered)
  * <C-u> - Half page up (cursor stays centered)
  * ```n``` - Next search result (cursor centered)
  * ```N``` - Previous search result (cursor centered)
Clipboard Operations
  * ```<leader>y``` - Yank to system clipboard
  * ```<leader>Y``` - Yank line to system clipboard
  * ```<leader>p``` (visual mode) - Paste without overwriting register
  * ```<leader>d``` - Delete without copying to register
LSP
  * ```<leader>f``` - Format current buffer
  * ```<leader>zig``` - Restart LSP server
Quick Fix List Navigation
  * ```<C-k>``` - Next quickfix item (centered)
  * ```<C-j>``` - Previous quickfix item (centered)
  * ```<leader>k``` - Next location list item (centered)
  * ```<leader>j``` - Previous location list item (centered)
Search and Replace
  * ```<leader>s``` - Search and replace word under cursor
Numbers
  * ```<leader>+``` - Increment number
  * ```<leader>-``` - Decrement number

## Plugins
Based on the keybindings, this config uses:
  * Snacks - Picker, explorer, dashboard, lazygit
  * LSP - Native `vim.lsp.config` with Mason
  * nvim-dap - Debugging (Go, Rust, JS/TS)
  * nvim-lint, conform - Linting and formatting
  * mini.surround, treesitter-textobjects - Editing
  * OpenCode - AI assistant integration

## Customization
Edit ```~/.config/nvim/lua/gajit/remap.lua``` to modify keybindings. See `docs/KEYBINDINGS.md` for the full reference.