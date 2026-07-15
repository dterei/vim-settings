-- ==============================================================================
-- Editing & text-manipulation plugins
-- ==============================================================================

return {
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

  -- Commenting: native `gc`/`gcc` (built into Neovim 0.10+)

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
}
