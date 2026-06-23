-- ==============================================================================
-- UI: colorscheme, statusline, file explorer
-- ==============================================================================

return {
  -- Solarized colorscheme
  {
    "https://codeberg.org/lifepillar/vim-solarized8",
    lazy = false,
    branch = "neovim",
    priority = 1000,  -- load before everything else so other plugins see colours
    config = function()
      vim.opt.termguicolors = true
      vim.opt.background = "dark"
      vim.cmd("colorscheme solarized8")
    end,
  },

  -- Airline statusline
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    lazy = false,
    init = function()
      local g = vim.g

      g["airline#extensions#default#layout"] = {
        { "a", "b", "x", "c" },
        { "warning", "z" },
      }
      g.airline_powerline_fonts = 1

      g["airline#extensions#tabline#enabled"] = 1
      g["airline#extensions#tabline#fnamemod"] = ":t"
      g["airline#extensions#tagbar#enabled"] = 0
      g["airline#extensions#whitespace#mixed_indent_algo"] = 2
      g["airline#extensions#hunks#enabled"] = 0

      g.airline_detect_modified = 1
      g.airline_detect_paste = 1
      g.airline_detect_crypt = 1
      g.airline_detect_spell = 1

      g.airline_theme = "solarized"
      g.airline_solarized_bg = "dark"

      g.airline_symbols = {
        linenr = "¶",
        branch = "⎇ ",
        readonly = "",
        crypt = "🔒",
        paste = "ρ",
        spell = "Ꞩ",
        notexists = "∄",
        whitespace = "Ξ",
      }
    end,
  },

  -- NERDTree file explorer
  {
    "scrooloose/nerdtree",
    lazy = false,
    init = function()
      local g = vim.g
      g.NERDTreeHijackNetrw = 1
      g.NERDTreeAutoDeleteBuffer = 1
      g.NERDTreeMinimalUI = 1
      g.NERDTreeQuitOnOpen = 0
      g.NERDTreeIgnore = {
        "\\~$[[file]]",
        "\\.o$[[file]]",
        "\\.hi$[[file]]",
        "\\.pyc$[[file]]",
        "__init__.py$[[file]]",
        "__pycache__$[[dir]]",
      }
      -- netrw settings (NERDTree hijacks it, but keep your prefs)
      g.netrw_liststyle = 3
      g.netrw_banner = 0
    end,
    config = function()
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("nerdtree_hidden", { clear = true }),
        pattern = "nerdtree",
        callback = function()
          vim.bo.bufhidden = "delete"
        end,
      })
    end,
    keys = {
      { "<F10>", "<cmd>NERDTreeToggle<CR>", silent = true, desc = "NERDTree" },
    },
  },
}
