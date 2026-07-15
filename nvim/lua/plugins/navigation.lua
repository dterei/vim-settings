-- ==============================================================================
-- Navigation plugins
-- ==============================================================================

return {
  -- Symbol (tagbar) navigation pane
  {
    "stevearc/aerial.nvim",
    cmd = { "AerialToggle", "AerialNav" },
    opts = {},
    keys = { { "<leader>o", "<cmd>AerialToggle!<cr>", desc = "Outline" } },
  },

  -- Oil file browser
  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, _)
          local patterns = {
            "%.o$", "%.hi$", "%.pyc$", "%.class$", "%.swp$",
            "^__pycache__$",
          }
          for _, pat in ipairs(patterns) do
            if name:match(pat) then return true end
          end
          return vim.startswith(name, ".")
        end,
      },
      keymaps = {
        ["<C-p>"] = false, -- disable, conflicts with my buffer movement
      },
    },
  },

  -- Bookmarking lines of interest
  {
    "dterei/VimBookmarking",
    event = "VeryLazy"
  },

  -- Nice mappings for :lnext etc.
  { "tpope/vim-unimpaired", event = "VeryLazy" },
}
