-- ==============================================================================
-- Git integration
-- ==============================================================================

return {
  -- Fugitive + GitHub (:GBrowse) support
  {
    "tpope/vim-fugitive",
    dependencies = { "tpope/vim-rhubarb" },
    cmd = { "G", "Git", "Gread", "Gwrite", "Gedit", "Gdiffsplit",
            "Gblame", "Gclog", "GBrowse" },
  },

  -- Sign-column git changes.
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {},
  },
}
