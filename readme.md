# Neovim Configuration

My personal Neovim configuration honed through many hours of noodeling.

## Prerequisites

- Neovim >= 0.8.0
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

#### File Explorer (NvimTree)
  * ```<leader>e``` - Toggle file explorer
  * ```<leader>ee``` - Toggle file explorer
  * ```<leader>ef``` - Toggle file explorer on current file
  * ```<leader>er``` - Refresh file explorer

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
Fun Extras
  * ```<leader>gol``` - Game of Life animation (CellularAutomaton)

## Plugins
Based on the keybindings, this config uses:
  * NvimTree - File explorer
  * LSP - Language Server Protocol support
  * CellularAutomaton - Fun animations

## Customization
Edit ```~/.config/nvim/lua/gajit/remap.lua``` to modify keybindings.