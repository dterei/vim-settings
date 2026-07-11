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

On first run lazy installs all plugins; `:GoUpdateBinaries` and `:TSUpdate`
run automatically via the `build` steps. Restart once after it finishes.

Requirements: a recent Neovim (0.10+), `git`, `rg` (ripgrep), and
`universal-ctags` (for Tagbar + `:BTag`). A Nerd Font for airline symbols.

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

- `:checkhealth` — confirms providers, ctags, rg, parsers.
- Open a Go file, run `<leader>gl` — confirms golangci-lint wiring.
- `$MYVIM` still points at `~/.vim`, so your existing undo history and saved
  sessions carry over. Repoint in `init.lua` if you want Neovim isolated.

## Next steps

- delimitMate to nvim-autopairs
- tcomment drop for vim.opt builtin `gc` in neovim
- drop undotree for builtin functionality
- https://github.com/lewis6991/hover.nvim
  - https://github.com/powerman/vim-plugin-viewdoc
- learn from others:
  - https://github.com/nvim-lua/kickstart.nvim/tree/master
  - https://www.lazyvim.org/
  - https://rootknecht.net/blog/debloating-neovim-config/

