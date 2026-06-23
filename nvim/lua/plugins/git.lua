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

  -- Code review from Vim
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      picker = "telescope",
      enable_builtin = true,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("octo").setup({
        ui = {
          use_signcolumn = true,
          use_statuscolumn = true,
          use_foldtext = false,
        },
      })
    end,
  },
}
