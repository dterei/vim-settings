# Neovim config

My personal Neovim setup: Lua, [lazy.nvim](https://github.com/folke/lazy.nvim)
for plugins, solarized-osaka colorscheme, Treesitter highlighting, and a Go LSP
(gopls) workflow. Leader is `,`, local-leader is `\`.

## Install

```sh
# back up anything existing
mv ~/.config/nvim ~/.config/nvim.bak

# drop this folder in
cp -r nvim ~/.config/nvim

# first launch: lazy.nvim bootstraps itself and installs everything
nvim
```

On first run lazy installs all plugins and Treesitter parsers install
automatically (`:TSUpdate` via the `build` step). Restart once after it
finishes.

## Requirements

- Neovim 0.11+ (uses `vim.lsp.config`/`vim.lsp.enable` and the Treesitter
  `main` branch; developed on 0.12)
- `git`, `rg` (ripgrep)
- A Nerd Font for statusline / file-explorer icons
- `gopls` on `$PATH` for Go LSP

Undo history and sessions live under Neovim's own data dir
(`stdpath("data")`, i.e. `~/.local/share/nvim`), created automatically on
startup. Repoint `$MYVIM` in `init.lua` to share them with another editor.

## Layout

```
init.lua                   # globals + lazy bootstrap, loads everything
lua/config/options.lua     # set options
lua/config/keymaps.lua     # global key mappings
lua/config/autocmds.lua    # autocommands
lua/config/commands.lua    # user commands + small functions
lua/plugins/               # one file per concern, auto-imported by lazy
```

## Plugins

| Area | Plugins |
| --- | --- |
| Colorscheme / UI | `solarized-osaka.nvim`, `lualine.nvim`, `which-key.nvim` |
| Pickers / files | `snacks.nvim` (picker), `oil.nvim` (file browser) |
| Editing | `nvim-autopairs`, `vim-surround` (+`vim-repeat`), `tabular`, `vim-argwrap` |
| Yank / undo | `yanky.nvim`, `undotree` |
| Navigation | `aerial.nvim` (symbol outline), `vim-unimpaired`, `VimBookmarking` |
| Docs | `hover.nvim` (unified `K`) |
| Git | `vim-fugitive` (+`vim-rhubarb`), `gitsigns.nvim`, `octo.nvim` |
| LSP | `nvim-lspconfig` (gopls) |
| Treesitter | `nvim-treesitter` (`main` branch) |
| Languages | `rust.vim`, `ansible-vim`, `render-markdown.nvim` |

Commenting uses Neovim's native `gc` / `gcc` (no plugin).

## Key mappings

Leader is `,`. Below are the notable custom maps; see `lua/config/keymaps.lua`
for the full set.

### Movement & editing

| Key | Action |
| --- | --- |
| `_` / `-` | start / end of line |
| `<C-a>` / `<C-e>` | start / end of line (normal); Home / End (insert) |
| `<C-f>` / `<C-b>` | cursor right / left (insert) |
| `<C-y>` / `<C-h>` | increment / decrement number (normal) |
| `<C-k>` / `<C-j>` | scroll up / down |
| `;` | enter command line (`:`) |
| `<` / `>` (visual) | indent and stay in visual mode |
| `Q` | clear search highlight |
| `<F2>` | save |
| `<F6>` | toggle spell (en_au) |
| `,a` | ArgWrap (toggle args single ↔ multi-line) |
| `,H` | toggle trailing-whitespace / over-length highlight |

### Buffers, windows, files

| Key | Action |
| --- | --- |
| `<C-n>` / `<C-p>` | next / previous buffer |
| `<C-@>` | alternate buffer (`b#`) |
| `,q` | delete buffer (keep window layout, via snacks) |
| `,w` | close window |
| `,Q` | quit all (force) |
| `,e` / `,E` | open oil at current file's dir / cwd |
| `<A-j>` / `<A-k>` / `<A-l>` | `:tag` / `:pop` / jump to tag |

### Pickers (snacks)

| Key | Action |
| --- | --- |
| `,t` | find files |
| `,/` | live grep |
| `,G` | grep word under cursor |
| `,bb` | buffers |
| `,c` | document symbols (LSP) |
| `,fr` / `,fh` / `,fk` / `,fd` | recent / help / keymaps / diagnostics |
| `,fn` | notification history |
| `U` | undo history (picker) |

### Undo / yank / outline

| Key | Action |
| --- | --- |
| `U` | undo history (snacks picker) |
| `,u` | Undotree panel |
| `,y` | yank-ring history |
| `]p` / `[p` | cycle through yank ring after a paste |
| `,o` | symbol outline (aerial) |

### Docs

| Key | Action |
| --- | --- |
| `K` | hover: diagnostic → LSP → man → dictionary (by context) |
| `gK` | hover, choosing the source explicitly |

`K` in non-LSP buffers falls through to man pages; `:Man foo` / `:help foo`
still open full navigable buffers.

### Git (gitsigns)

| Key | Action |
| --- | --- |
| `]c` / `[c` | next / previous hunk |
| `,hs` / `,hr` | stage / reset hunk (works on a visual selection too) |
| `,hS` / `,hR` | stage / reset buffer |
| `,hu` | undo stage hunk |
| `,hp` | preview hunk |
| `,hb` | blame line |
| `,hd` | diff against index |
| `ih` | hunk text object (e.g. `vih`, `dih`) |

Fugitive (`:G`, `:GBrowse`, …) and Octo (`:Octo`) are available on demand.

### LSP (Go buffers, on gopls attach)

| Key | Action |
| --- | --- |
| `gd` | go to definition |
| `grr` | references |
| `gi` | implementation |
| `,gr` | rename |
| `I` | open diagnostic float |
| `,gf` | format buffer |
| `,I` | organize imports |
| `,gF` | organize imports + format |

## Commands

| Command | Action |
| --- | --- |
| `:HighlightLongLines` | toggle trailing-whitespace / over-length highlight (`,H`) |
| `:DeleteTrailingWs` | strip trailing whitespace |
| `:SaveSession` / `:LastSession` | save / restore the session |
| `:DiffOrig` | diff the buffer against the file on disk |
| `:Wgrep` | grep for the word under the cursor into the quickfix list |
| `:Latest` | jump to the newest undo state |

## Things to verify after first launch

- `:checkhealth` — confirms providers, `rg`, and Treesitter parsers.
- Open a Go file and confirm `gopls` attaches (`:LspInfo` / `:checkhealth lsp`);
  `gd`, `grr`, `,gf` should work.

## Next steps

- add a completion engine (blink.cmp) — gopls completion is currently manual
  `<C-x><C-o>`

### References

- <https://github.com/nvim-lua/kickstart.nvim>
- <https://www.lazyvim.org/>
- <https://rootknecht.net/blog/debloating-neovim-config/>
