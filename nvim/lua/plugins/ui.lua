-- ==============================================================================
-- UI: colorscheme, statusline, file explorer
-- ==============================================================================

return {
  -- Solarized colorscheme
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(highlights, colors)
        -- Color of the window split line
        highlights.WinSeparator = {
          fg = "#606060",
        }
      end,
    },
    config = function(_, opts)
      require("solarized-osaka").setup(opts)
      vim.cmd([[colorscheme solarized-osaka]])

      -- Custom distinct colors for Markdown headings
      local heading_colors = {
        { fg = '#b58900', bold = true }, -- H1: Yellow
        { fg = '#cb4b16', bold = true }, -- H2: Orange
        { fg = '#dc322f', bold = true }, -- H3: Red
        { fg = '#d33682', bold = true }, -- H4: Magenta
        { fg = '#6c71c4', bold = true }, -- H5: Violet
        { fg = '#268bd2', bold = true }, -- H6: Blue
      }

      -- Apply the colors to Treesitter Markdown capture groups
      for i, hl_props in ipairs(heading_colors) do
        vim.api.nvim_set_hl(0, '@markup.heading.' .. i .. '.markdown', hl_props)
      end
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
