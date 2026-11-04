# Neovim Keybindings Reference

Leader key: **Space** (`<Space>`)

## General Editing (remap.lua)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>nh` | Normal | Clear search highlights | Custom |
| `J` | Normal | Join next line, keep cursor position | Custom |
| `J` | Visual | Move selected line(s) down | Custom |
| `K` | Visual | Move selected line(s) up | Custom |
| `<C-d>` | Normal | Half page down, cursor centered | Custom |
| `<C-u>` | Normal | Half page up, cursor centered | Custom |
| `n` | Normal | Next search result, centered | Custom |
| `N` | Normal | Previous search result, centered | Custom |
| `<leader>zig` | Normal | Restart LSP (`:LspRestart`) | Custom |
| `<leader>p` | Visual | Paste without overwriting register | Custom |
| `<leader>y` | Normal, Visual | Yank to system clipboard | Custom |
| `<leader>Y` | Normal | Yank line to system clipboard | Custom |
| `<leader>d` | Normal, Visual | Delete to void register | Custom |
| `jk` | Insert | Escape to normal mode | Custom |
| `Q` | Normal | Disabled (no-op) | Custom |
| `<C-b>f` | Normal | LSP format buffer | Custom |
| `<leader>s` | Normal | Substitute word under cursor (prompt) | Custom |
| `<leader>+` | Normal | Increment number under cursor | Custom |
| `<leader>-` | Normal | Decrement number under cursor | Custom |

## Quickfix & Location List

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<C-k>` | Normal | Next quickfix item, centered | Custom |
| `<C-j>` | Normal | Previous quickfix item, centered | Custom |
| `<leader>k` | Normal | Next diagnostic (loclist + popup via `lsp_util`) | Custom |
| `<leader>j` | Normal | Prev diagnostic (loclist + popup via `lsp_util`) | Custom |

## File Explorer (Snacks Explorer)

Netrw is disabled; Snacks explorer also opens when editing a directory.

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>ee` | Normal | Toggle file explorer | Custom |
| `<leader>ef` | Normal | Reveal current file in explorer | Custom |

## Fuzzy Finder (Snacks Picker)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>ff` | Normal | Find files | Custom |
| `<C-f>` | Normal | Find git files | Custom |
| `<leader>fh` | Normal | Recently opened files | Custom |
| `<leader>fw` | Normal, Visual | Grep word under cursor (or selection) | Custom |
| `<leader>ffw` | Normal | Grep WORD under cursor | Custom |
| `<leader>fg` | Normal | Live grep | Custom |
| `<leader>ft` | Normal | Find TODO comments | Custom |

## Harpoon

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader><leader>` | Normal | Toggle Harpoon quick menu | Custom |
| `<leader>a` | Normal | Add current file to Harpoon | Custom |
| `<leader>1` | Normal | Jump to Harpoon file 1 | Custom |
| `<leader>2` | Normal | Jump to Harpoon file 2 | Custom |
| `<leader>3` | Normal | Jump to Harpoon file 3 | Custom |
| `<leader>4` | Normal | Jump to Harpoon file 4 | Custom |
| `<leader>5` | Normal | Jump to Harpoon file 5 | Custom |

## Buffers (Bufferline)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<Tab>` | Normal | Next buffer | Custom |
| `<S-Tab>` | Normal | Previous buffer | Custom |
| `<leader>bc` | Normal | Close current buffer | Custom |
| `<leader>bx` | Normal | Close all other buffers | Custom |

## Formatting (Conform)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>gj` | Normal, Visual | Format buffer via conform (LSP fallback) | Custom |

Format-on-save is enabled with a 500ms timeout.

## Snippets (LuaSnip)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<C-s>e` | Insert | Expand snippet | Custom |
| `<C-s>;` | Insert, Select | Jump to next snippet position | Custom |
| `<C-s>,` | Insert, Select | Jump to previous snippet position | Custom |
| `<C-E>` | Insert, Select | Change snippet choice | Custom |

## Git — Fugitive

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>gs` | Normal | Open git status (fugitive) | Custom |
| `<leader>p` | Normal | Git push (in fugitive buffer) | Custom |
| `<leader>P` | Normal | Git pull with rebase (in fugitive buffer) | Custom |
| `<leader>t` | Normal | Git push with upstream prompt (in fugitive buffer) | Custom |
| `gu` | Normal | Git diffget from left (ours) | Custom |
| `gh` | Normal | Git diffget from right (theirs) | Custom |

## Git — LazyGit (Snacks)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>lg` | Normal | Open LazyGit | Custom |

## Git — Gitsigns

| Keybinding | Mode | Action | Type |
|---|---|---|---|
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
| `ih` | Operator, Visual | Select hunk (text object) | Custom |

## LSP (buffer-local, on `LspAttach`)

These keymaps are set only in buffers where an LSP client is attached (registered
by the `LspAttach` autocmd in `lua/gajit/lazy/lsp.lua`).

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `gd` | Normal | Go to definition | Custom |
| `gD` | Normal | Go to declaration | Custom |
| `gi` | Normal | Go to implementation | Custom |
| `gy` | Normal | Go to type definition | Custom |
| `gr` | Normal | References (opens in Trouble) | Custom |
| `K` | Normal | Hover documentation | Custom |
| `<C-k>` | Insert | Signature help | Custom |
| `<leader>ca` | Normal, Visual | Code action | Custom |
| `<leader>rn` | Normal | Rename symbol | Custom |
| `<leader>lwa` | Normal | Add workspace folder | Custom |
| `<leader>lwr` | Normal | Remove workspace folder | Custom |
| `<leader>lwl` | Normal | List workspace folders | Custom |

## Diagnostics (buffer-local, on `LspAttach`)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `]d` | Normal | Next diagnostic (via `lsp_util` popup) | Custom |
| `[d` | Normal | Previous diagnostic (via `lsp_util` popup) | Custom |
| `<leader>de` | Normal | Open diagnostic float under cursor | Custom |
| `<leader>dq` | Normal | Send diagnostics to location list | Custom |

## Trouble (Diagnostics)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>tt` | Normal | Toggle Trouble diagnostics | Custom |
| `]t` | Normal | Next Trouble item | Custom |
| `[t` | Normal | Previous Trouble item | Custom |

## TODO Comments

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>ft` | Normal | Find TODOs (Snacks picker) | Custom |
| `]td` | Normal | Next TODO comment | Custom |
| `[td` | Normal | Previous TODO comment | Custom |

## Motion (Hop)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `s` | Normal, Visual | Hop hint words | Custom |
| `<S-s>` | Normal, Visual | Hop hint lines | Custom |

## UndoTree

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>u` | Normal | Toggle UndoTree | Custom |

## Sessions (auto-session)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>wr` | Normal | Restore session for cwd | Custom |
| `<leader>ws` | Normal | Save session for cwd | Custom |

## Zen Mode

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>zz` | Normal | Toggle zen mode (90 width, line numbers on) | Custom |
| `<leader>zZ` | Normal | Toggle zen mode (80 width, no line numbers) | Custom |

## OpenCode

All OpenCode keymaps live under the `<leader>o` group.

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>oa` | Normal, Visual | Ask OpenCode about `@this` | Custom |
| `<leader>ob` | Normal | Ask OpenCode about `@buffer` | Custom |
| `<leader>os` | Normal, Visual | Select OpenCode action | Custom |
| `<leader>og` | Normal, Visual | Operator: send range to OpenCode | Custom |
| `<leader>ol` | Normal | Send current line to OpenCode | Custom |
| `<leader>oe` | Normal, Visual | Explain `@this` | Custom |
| `<leader>of` | Normal, Visual | Fix `@diagnostics` | Custom |
| `<leader>or` | Normal, Visual | Review `@this` | Custom |
| `<leader>oT` | Normal, Visual | Add tests for `@this` | Custom |
| `<leader>on` | Normal | New session | Custom |
| `<leader>oi` | Normal | Interrupt session | Custom |
| `<S-C-u>` | Normal | Scroll OpenCode panel up | Custom |
| `<S-C-d>` | Normal | Scroll OpenCode panel down | Custom |

## Surround (mini.surround)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `gsa` | Normal, Visual | Add surrounding | Custom |
| `gsd` | Normal | Delete surrounding | Custom |
| `gsr` | Normal | Replace surrounding | Custom |
| `gsf` / `gsF` | Normal | Find surrounding (right / left) | Custom |
| `gsh` | Normal | Highlight surrounding | Custom |
| `gsn` | Normal | Update number of lines searched | Custom |

The `gs` prefix avoids clashing with Hop's `s`.

## Treesitter Textobjects

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `af` / `if` | Operator, Visual | Around / inside function | Custom |
| `ac` / `ic` | Operator, Visual | Around / inside class | Custom |
| `aa` / `ia` | Operator, Visual | Around / inside argument | Custom |
| `]f` / `[f` | Normal | Next / previous function start | Custom |
| `]a` / `[a` | Normal | Next / previous argument | Custom |

## Linting (nvim-lint)

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>cl` | Normal | Lint current file | Custom |

Linting also runs automatically on read, save, and leaving insert mode
(`eslint_d` for JS/TS, `golangcilint` for Go).

## Debugging (nvim-dap)

The `<leader>D` prefix is used because `<leader>d` is the delete-to-void mapping.

| Keybinding | Mode | Action | Type |
|---|---|---|---|
| `<leader>Db` | Normal | Toggle breakpoint | Custom |
| `<leader>DB` | Normal | Conditional breakpoint | Custom |
| `<leader>Dc` | Normal | Continue / start | Custom |
| `<leader>Di` | Normal | Step into | Custom |
| `<leader>Do` | Normal | Step over | Custom |
| `<leader>DO` | Normal | Step out | Custom |
| `<leader>Dr` | Normal | Run last | Custom |
| `<leader>Dt` | Normal | Terminate | Custom |
| `<leader>Du` | Normal | Toggle DAP UI | Custom |
| `<leader>De` | Normal, Visual | Evaluate expression | Custom |

## Snacks Picker In-Window Keys (defaults)

The following are default Snacks picker keybindings available within picker windows:

| Keybinding | Action |
|---|---|
| `<Esc>` | Close picker |
| `<CR>` | Confirm selection |
| `<Tab>` / `<S-Tab>` | Select and move down / up |
| `<C-j>` / `<C-k>` | Move selection down / up (`<C-n>` / `<C-p>` also work) |
| `<C-d>` / `<C-u>` | Scroll list down / up |
| `<C-f>` / `<C-b>` | Scroll preview down / up |
| `<C-s>` / `<C-v>` / `<C-t>` | Open in split / vertical split / tab |
| `<C-q>` | Send results to quickfix |
| `<A-p>` | Toggle preview |
| `<A-h>` / `<A-i>` | Toggle hidden / ignored files |

## Notes

- **Type column** indicates whether the keybinding is **Custom** (user-defined) or **Default** (from plugins/Neovim).
- **Mode** column indicates which Vim modes the keybinding applies to:
  - Normal: `n`
  - Insert: `i`
  - Visual: `v`
  - Operator: `o`
  - Select: `s`
- Git keybindings require a git repository; fugitive-specific ones only take effect inside a fugitive buffer.
- LSP go-to and hover keymaps (`gd`, `gD`, `gi`, `gy`, `gr`, `K`, `<leader>ca`, `<leader>rn`, `]d`, `[d`, etc.) are set buffer-local via an `LspAttach` autocmd in `lua/gajit/lazy/lsp.lua` and only take effect in buffers with an active LSP client. Global LSP-related keys: `<C-b>f` (format), `<leader>zig` (`LspRestart`), `<leader>k`/`<leader>j` (diagnostic navigation via `lsp_util`).
- Some `<leader>` prefixes overlap in different modes/contexts (e.g., `<leader>p`, `<leader>t`) — the fugitive bindings only apply inside a fugitive buffer.
