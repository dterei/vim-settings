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

  -- Snacks picker
  {
    "folke/snacks.nvim",
    priority = 900, -- below the colorscheme (1000) so it applies first; still loads early
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
        -- Close on the first <Esc> instead of dropping into the picker's
        -- normal mode (non-modal).
        win = {
          input = {
            keys = {
              ["<Esc>"] = { "close", mode = { "n", "i" } },
            },
          },
        },
      },
      input        = { enabled = true },
      notifier     = { enabled = true },  -- toast UI for vim.notify (history via the picker below)
      statuscolumn = { enabled = true },  -- separate git vs diagnostic signs; clickable folds
      bigfile      = { enabled = true },  -- disables heavy features on huge files (nice for monorepo)
      quickfile    = { enabled = true },  -- faster file opening
      scratch      = { enabled = true },  -- scratch buffer
    },
    keys = {
      { "<Leader>t",  function() Snacks.picker.files() end,         desc = "Find files" },
      { "<Leader>bb", function() Snacks.picker.buffers() end,       desc = "Buffers" },
      { "<Leader>/",  function() Snacks.picker.grep() end,          desc = "Grep" },
      { "<Leader>G",  function() Snacks.picker.grep_word() end,     desc = "Grep word under cursor", mode = { "n", "x" } },
      { "<Leader>cs", function() Snacks.picker.lsp_symbols() end,   desc = "Document symbols" },
      { "<Leader>fr", function() Snacks.picker.recent() end,        desc = "Recent files" },
      { "<Leader>fh", function() Snacks.picker.help() end,          desc = "Help pages" },
      { "<Leader>fk", function() Snacks.picker.keymaps() end,       desc = "Keymaps" },
      { "<Leader>fd", function() Snacks.picker.diagnostics() end,   desc = "Diagnostics" },
      { "<Leader>fn", function() Snacks.picker.notifications() end, desc = "Notification history" },
      { "U",          function() Snacks.picker.undo() end,          desc = "Undo history" },
      { "<Leader>q",  function() Snacks.bufdelete() end,            desc = "Delete buffer (keep layout)" },
      { "<Leader>.",  function() Snacks.scratch() end,             desc = "Scratch buffer" },
    },
  },

  -- which-key: popup of possible next keys when you pause mid-sequence
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
      -- Label the leader-key groups so the popup reads cleanly
      spec = {
        { "<leader>b", group = "buffers" },
        { "<leader>c", group = "code" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "go / git" },
        { "<leader>h", group = "hunks" },
        { "<leader>s", group = "swap" },
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

  -- Hover, improved K behavior
  {
    "lewis6991/hover.nvim",
    keys = {
      { "K",  function() require("hover").open() end,   desc = "Hover" },
      { "gK", function() require("hover").select() end, desc = "Hover (pick source)" },
    },
    config = function()
      require("hover").config({
        -- Omit the default `dap` provider (no debugger configured)
        providers = {
          "hover.providers.diagnostic",
          "hover.providers.lsp",
          "hover.providers.man",
          "hover.providers.dictionary",
        },
        preview_opts = { border = "rounded" },
        title = true,
      })
    end,
  },
}
