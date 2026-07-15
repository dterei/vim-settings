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
    opts = {
      on_attach = function(buf)
        local gs = require("gitsigns")
        local function map(mode, lhs, rhs, desc, extra)
          local o = { buffer = buf, silent = true, desc = desc }
          if extra then for k, v in pairs(extra) do o[k] = v end end
          vim.keymap.set(mode, lhs, rhs, o)
        end

        -- Hunk navigation (respects diff mode)
        map("n", "]c", function()
          if vim.wo.diff then return "]c" end
          vim.schedule(function() gs.nav_hunk("next") end)
          return "<Ignore>"
        end, "Next hunk", { expr = true })
        map("n", "[c", function()
          if vim.wo.diff then return "[c" end
          vim.schedule(function() gs.nav_hunk("prev") end)
          return "<Ignore>"
        end, "Prev hunk", { expr = true })

        -- Stage / reset / preview
        map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
        map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
        map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
        map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
        map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
        map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
        map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")
        map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
        map("n", "<leader>hd", gs.diffthis, "Diff against index")

        -- Text object for a hunk
        map({ "o", "x" }, "ih", gs.select_hunk, "Select hunk")
      end,
    },
  },

  -- Code review from Vim
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      picker = "snacks",
      enable_builtin = true,
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "folke/snacks.nvim",
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
