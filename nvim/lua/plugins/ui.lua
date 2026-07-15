-- ==============================================================================
-- UI: colorscheme, statusline, yankring, undo-tree
-- ==============================================================================

return {
  -- Solarized colorscheme
  {
    "craftzdog/solarized-osaka.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      on_highlights = function(hl, c)
        -- Color of the window split line
        hl.WinSeparator = { fg = "#606060" }
        -- Color of the visual hightlight
        hl.Visual = { bg = require("solarized-osaka.util").blend(c.base01, c.base02, 0.5) }
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

  -- Lualine statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          "mode",
          { function() return vim.o.paste and "ρ" or "" end },
          { function() return vim.wo.spell and "S" or "" end },
        },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 0 } },
        lualine_x = {},
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      tabline = {
        lualine_a = {"buffers"},
        lualine_z = {"tabs"},
      },
      extensions = { "quickfix", "fugitive", "oil" },
    },
  },

  -- Yankring UI
  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    opts = {
      ring = {
        history_length = 100,
        storage = "shada",
      },
      system_clipboard = {
        sync_with_ring = false,
      },
      highlight = {
        on_put = true,
        on_yank = true,
        timer = 200,
      },
      preserve_cursor_position = { enabled = true },
    },
    keys = {
      -- put y/p through yanky so they feed the ring
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put after" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put before" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "GPut after" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "GPut before" },
      -- cycle through history after a paste
      { "]p", "<Plug>(YankyNextEntry)", desc = "Cycle to next yank" },
      { "[p", "<Plug>(YankyPreviousEntry)", desc = "Cycle to previous yank" },
      -- open the history picker
      { "<Leader>y", "<cmd>YankyRingHistory<CR>", mode = { "n", "x" }, desc = "Yank history" },
    },
  },

  -- Undo tree UI
  {
    "mbbill/undotree",
    keys = {
      { "U", "<cmd>UndotreeToggle<CR>", silent = true, desc = "Undotree" },
    },
  },

  -- Snacks picker
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        enabled = true,
        ui_select = true,
        matcher = {
          fuzzy = true,
          smartcase = true,
        },
        sources = {
          files = {
            hidden = false,
            exclude = { ".git", "node_modules", "vendor", "bazel-*", "**/testdata" },
          },
          grep = {
            exclude = { ".git", "node_modules", "vendor", "bazel-*", "**/testdata" },
          },
        },
      },
      input = { enabled = true },
      bigfile = { enabled = true },   -- disables heavy features on huge files (nice for monorepo)
      quickfile = { enabled = true }, -- faster file opening
    },
    keys = {
      { "<Leader>t",  function() Snacks.picker.files() end,       desc = "Find files" },
      { "<Leader>bb", function() Snacks.picker.buffers() end,     desc = "Buffers" },
      { "<Leader>/",  function() Snacks.picker.grep() end,        desc = "Grep" },
      { "<Leader>G",  function() Snacks.picker.grep_word() end,   desc = "Grep word under cursor", mode = { "n", "x" } },
      { "<Leader>c",  function() Snacks.picker.lsp_symbols() end, desc = "Document symbols" },
      { "<Leader>fr", function() Snacks.picker.recent() end,      desc = "Recent files" },
      { "<Leader>fh", function() Snacks.picker.help() end,        desc = "Help pages" },
      { "<Leader>fk", function() Snacks.picker.keymaps() end,     desc = "Keymaps" },
      { "<Leader>fd", function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    },
  },

  -- which-key: popup of possible next keys when you pause mid-sequence
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- Label the leader-key groups so the popup reads cleanly
      spec = {
        { "<leader>b", group = "buffers" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "go / git" },
        { "<leader>h", group = "hunks" },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer-local keymaps",
      },
    },
  },
}
