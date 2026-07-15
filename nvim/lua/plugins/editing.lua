-- ==============================================================================
-- Editing & text-manipulation plugins
-- ==============================================================================

return {
  -- Auto-close quotes/brackets/etc (Treesitter-aware)
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local npairs = require("nvim-autopairs")
      local Rule = require("nvim-autopairs.rule")
      local cond = require("nvim-autopairs.conds")

      npairs.setup({
        check_ts = true, -- don't pair inside strings/comments per Treesitter
        map_cr = true,   -- <CR> between a pair opens an indented line (was delimitMate_expand_cr)
      })

      -- Symmetric spaces inside brackets (was delimitMate_expand_space):
      -- `( )` -> `(  )` with the cursor centred, and delete both on <BS>.
      npairs.add_rules({
        Rule(" ", " ")
          :with_pair(function(opts)
            local pair = opts.line:sub(opts.col - 1, opts.col)
            return vim.tbl_contains({ "()", "[]", "{}" }, pair)
          end)
          :with_move(cond.none())
          :with_cr(cond.none())
          :with_del(function(opts)
            local col = vim.api.nvim_win_get_cursor(0)[2]
            local context = opts.line:sub(col - 1, col + 2)
            return vim.tbl_contains({ "(  )", "[  ]", "{  }" }, context)
          end),
      })
      for _, bracket in pairs({ { "(", ")" }, { "[", "]" }, { "{", "}" } }) do
        npairs.add_rules({
          Rule(bracket[1] .. " ", " " .. bracket[2])
            :with_pair(cond.none())
            :with_move(function(opts) return opts.char == bracket[2] end)
            :with_del(cond.none())
            :use_key(bracket[2]),
        })
      end
    end,
  },

  -- Align text to columns
  { "godlygeek/tabular", cmd = "Tabularize" },

  -- Surround text with brackets / tags
  { "tpope/vim-surround", event = "VeryLazy", dependencies = { "tpope/vim-repeat" } },

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
