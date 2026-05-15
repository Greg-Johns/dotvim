# Neovim Keybindings Reference

Leader key: **Space** (`<Space>`)

## File Management & Navigation

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>fh` | Normal | Recently opened files (telescope) | Custom |
| `<leader>ff` | Normal | Find files in project | Custom |
| `<leader>fg` | Normal | Live grep search | Custom |
| `<leader>fd` | Normal | Find buffer diagnostics | Custom |
| `<leader>fs` | Normal | Find symbols | Custom |
| `<leader>fr` | Normal | Find recent files | Custom |
| `<leader>e` | Normal | Toggle NvimTree file explorer | Custom |
| `<leader><leader>` | Normal | Harpoon quick menu | Custom |
| `<leader>a` | Normal | Harpoon add file | Custom |
| `<leader>1` | Normal | Harpoon jump to file 1 | Custom |
| `<leader>2` | Normal | Harpoon jump to file 2 | Custom |
| `<leader>3` | Normal | Harpoon jump to file 3 | Custom |
| `<leader>4` | Normal | Harpoon jump to file 4 | Custom |
| `<leader>5` | Normal | Harpoon jump to file 5 | Custom |

## Editing & Formatting

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>gj` | Normal | Format document | Custom |
| `<C-s>e` | Insert | Expand snippet | Custom |
| `<C-s>;` | Insert, Select | Jump to next snippet position | Custom |
| `<C-s>,` | Insert, Select | Jump to previous snippet position | Custom |
| `<C-E>` | Insert, Select | Change snippet choice | Custom |

## Git Integration

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>gs` | Normal | Open git status (fugitive) | Custom |
| `<leader>lg` | Normal | Open LazyGit | Custom |
| `]h` | Normal | Next git hunk | Custom |
| `[h` | Normal | Previous git hunk | Custom |
| `<leader>hs` | Normal, Visual | Stage hunk | Custom |
| `<leader>hr` | Normal, Visual | Reset hunk | Custom |
| `<leader>hS` | Normal | Stage buffer | Custom |
| `<leader>hR` | Normal | Reset buffer | Custom |
| `<leader>hu` | Normal | Undo stage hunk | Custom |
| `<leader>hp` | Normal | Preview hunk | Custom |
| `<leader>hb` | Normal | Blame line (full) | Custom |
| `<leader>hB` | Normal | Toggle line blame | Custom |
| `<leader>hd` | Normal | Diff this file | Custom |
| `<leader>hD` | Normal | Diff this file (~) | Custom |
| `ih` | Operator, Visual | Gitsigns select hunk | Custom |
| `<leader>p` | Normal | Git push (in fugitive buffer) | Custom |
| `<leader>P` | Normal | Git pull with rebase (in fugitive buffer) | Custom |
| `<leader>t` | Normal | Git push with upstream (in fugitive buffer) | Custom |
| `gu` | Normal | Git diffget from left (ours) | Custom |
| `gh` | Normal | Git diffget from right (theirs) | Custom |

## Code Navigation & Diagnostics

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `gd` | Normal | LSP go to definition | Default |
| `gi` | Normal | LSP go to implementation | Default |
| `gr` | Normal | LSP find references | Default |
| `K` | Normal | LSP hover information | Default |
| `<leader>vws` | Normal | LSP workspace symbol | Custom |
| `<leader>vd` | Normal | LSP open diagnostic float | Custom |
| `<leader>vca` | Normal | LSP code action | Custom |
| `<leader>vrr` | Normal | LSP references | Custom |
| `<leader>vrn` | Normal | LSP rename symbol | Custom |
| `<leader>j` | Normal | Go to next diagnostic | Custom |
| `<leader>k` | Normal | Go to prev diagnostic | Custom |

## Undo/Redo

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>u` | Normal | Toggle undo tree | Custom |

## Buffer & Session Management

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>wr` | Normal | Restore session for cwd | Custom |
| `<leader>ws` | Normal | Save session for cwd | Custom |

## Trouble (Diagnostics Window)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>xq` | Normal | Toggle quickfix list | Custom |
| `<leader>xl` | Normal | Toggle location list | Custom |
| `<leader>xt` | Normal | Toggle trouble document diagnostics | Custom |
| `<leader>xw` | Normal | Toggle trouble workspace diagnostics | Custom |

## Motion & Navigation

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `s` | Normal | Hop hint words | Custom |
| `<S-s>` | Normal | Hop hint lines | Custom |
| `s` | Visual | Hop hint words (extend selection) | Custom |
| `<S-s>` | Visual | Hop hint lines (extend selection) | Custom |

## UI & Display

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>zz` | Normal | Toggle zen mode (90 width with line numbers) | Custom |
| `<leader>zZ` | Normal | Toggle zen mode (80 width, no line numbers) | Custom |

## Special Keys & Operators

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<C-h>` | Normal | Move to left split | Custom |
| `<C-j>` | Normal | Move to below split | Custom |
| `<C-k>` | Normal | Move to above split | Custom |
| `<C-l>` | Normal | Move to right split | Custom |
| `<leader>+` | Normal | Increase split size | Custom |
| `<leader>-` | Normal | Decrease split size | Custom |
| `<leader>sm` | Normal | Make splits equal size | Custom |
| `<leader>sv` | Normal | Split window vertically | Custom |
| `<leader>sh` | Normal | Split window horizontally | Custom |

## Telescope Keymap Helpers

The following are default Telescope keybindings available within Telescope windows:

| Keybinding | Action |
|---|---|
| `<C-c>` | Close telescope |
| `<ESC>` | Close telescope |
| `<Tab>` | Toggle selection / down |
| `<S-Tab>` | Toggle selection / up |
| `<C-j>` | Move selection down |
| `<C-k>` | Move selection up |
| `<CR>` | Confirm selection |

## Notes

- **Type column** indicates whether the keybinding is **Custom** (user-defined) or **Default** (from plugins/Neovim)
- **Mode** column indicates which Vim modes the keybinding applies to:
  - Normal: `n`
  - Insert: `i`
  - Visual: `v`
  - Operator: `o` (used with motions)
  - Select: `s`
- LSP keybindings (go to definition, hover, etc.) require an active language server
- Git keybindings require a git repository
- Some keybindings are only available in specific buffer types (e.g., git push/pull in fugitive buffer)
