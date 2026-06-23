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

  -- Improved :man & :help / docs viewer
  { "powerman/vim-plugin-viewdoc", event = "VeryLazy" },

  -- Yank history
  {
    "vim-scripts/YankRing.vim",
    event = "VeryLazy",
    init = function()
      vim.g.yankring_clipboard_monitor = 0
      vim.g.yankring_replace_n_pkey = "<A-p>"
      vim.g.yankring_replace_n_nkey = "<A-n>"
      vim.g.yankring_max_display = 50
      vim.g.yankring_history_dir = vim.env.MYVIM
    end,
    keys = {
      { "<Leader>y", "<cmd>YRShow<CR>", silent = true, desc = "YankRing" },
    },
  },

  -- Nice mappings for :lnext etc.
  { "tpope/vim-unimpaired", event = "VeryLazy" },

  -- AutoSave
  -- { "907th/vim-auto-save", init = function() vim.g.auto_save = 1 end },

  -- Undo tree
  {
    "mbbill/undotree",
    keys = {
      { "U", "<cmd>UndotreeToggle<CR>", silent = true, desc = "Undotree" },
    },
  },
}
