-- ==============================================================================
-- Editing & text-manipulation plugins
-- ==============================================================================

return {
  -- Buffer switching
  { "jlanzarotta/bufexplorer", event = "VeryLazy" },

  -- Tag listing / class explorer (needs universal-ctags installed)
  { "majutsushi/tagbar", cmd = "TagbarToggle",
    keys = {
      { "<F9>", "<cmd>TagbarToggle<CR>", silent = true, desc = "Tagbar" },
    },
  },

  -- Easy motion / jumping
  { "easymotion/vim-easymotion", event = "VeryLazy" },

  -- Bookmarking lines of interest
  { "dterei/VimBookmarking", event = "VeryLazy" },

  -- Auto-close quotes/brackets/etc
  {
    "Raimondi/delimitMate",
    event = "InsertEnter",
    init = function()
      vim.g.delimitMate_expand_cr = 1
      vim.g.delimitMate_expand_space = 1
    end,
  },

  -- Align text to columns
  { "godlygeek/tabular", cmd = "Tabularize" },

  -- Surround text with brackets / tags
  { "tpope/vim-surround", event = "VeryLazy", dependencies = { "tpope/vim-repeat" } },

  -- Toggle commenting
  { "tomtom/tcomment_vim", event = "VeryLazy" },

  -- Reformat function args single <-> multi line
  {
    "FooSoft/vim-argwrap",
    init = function()
      vim.g.argwrap_tail_comma = 1
    end,
    keys = {
      { "<leader>a", "<cmd>ArgWrap<CR>", silent = true, desc = "ArgWrap" },
    },
  },

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
      -- cycle through history after a paste (the killer feature)
      { "]p", "<Plug>(YankyNextEntry)", desc = "Cycle to next yank" },
      { "[p", "<Plug>(YankyPreviousEntry)", desc = "Cycle to previous yank" },
      -- open the history picker (your old <Leader>y)
      { "<Leader>y", "<cmd>YankyRingHistory<CR>", mode = { "n", "x" }, desc = "Yank history" },
    },
  },

  -- Nice mappings for :lnext etc.
  { "tpope/vim-unimpaired", event = "VeryLazy" },

  -- Undo tree
  {
    "mbbill/undotree",
    keys = {
      { "U", "<cmd>UndotreeToggle<CR>", silent = true, desc = "Undotree" },
    },
  },
}
