# Neovim config

Port of my .vimrc to Neovim.

## Install

```sh
# back up anything existing
mv ~/.config/nvim ~/.config/nvim.bak

# drop this folder in
cp -r nvim ~/.config/nvim

# first launch: lazy.nvim bootstraps itself and installs everything
nvim
```

On first run lazy installs all plugins and treesitter parsers install
automatically (`:TSUpdate` via the `build` step). Restart once after it
finishes.

Requirements: Neovim 0.11+ (uses `vim.lsp.config`/`vim.lsp.enable` and the
treesitter `main` branch), `git`, `rg` (ripgrep), and a Nerd Font for
statusline / file-explorer icons. `gopls` on `$PATH` for Go LSP.

## Layout

```sh
init.lua                 # globals + lazy bootstrap, loads everything
lua/config/options.lua   # your `set` options
lua/config/keymaps.lua   # your mappings
lua/config/autocmds.lua  # your augroups
lua/config/commands.lua  # user commands + ToggleLongLines
lua/plugins/             # one file per concern, auto-imported by lazy
```

## Things to verify after first launch

- `:checkhealth` — confirms providers, rg, and treesitter parsers.
- Open a Go file and confirm `gopls` attaches (`:LspInfo` / `:checkhealth
  lsp`); `gd`, `grr`, `<leader>gf` (format) should work.
- Undo history and sessions live under Neovim's own data dir
  (`stdpath("data")`, i.e. `~/.local/share/nvim`), so they're isolated from
  the old Vim `~/.vim`. Repoint `$MYVIM` in `init.lua` to share them.

## Next steps

- add a completion engine (blink.cmp) — gopls completion is currently manual `<C-x><C-o>`
- delimitMate to nvim-autopairs
- drop undotree for builtin functionality
- https://github.com/lewis6991/hover.nvim
  - https://github.com/powerman/vim-plugin-viewdoc
- learn from others:
  - https://github.com/nvim-lua/kickstart.nvim/tree/master
  - https://www.lazyvim.org/
  - https://rootknecht.net/blog/debloating-neovim-config/

