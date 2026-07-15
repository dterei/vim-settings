-- ==============================================================================
-- Treesitter -- native, accurate highlighting + folding.
-- ==============================================================================

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    init = function()
      -- ensure languages installed
      local ensure_installed = {
        "go", "gomod", "gowork", "gosum",
        "rust", "typescript", "tsx", "javascript",
        "python", "lua", "vim", "vimdoc",
        "bash", "markdown", "markdown_inline",
        "yaml", "json", "toml", "graphql",
        "dockerfile", "git_config", "gitcommit", "diff",
        "powershell", "haskell",
      }
      local already = require("nvim-treesitter.config").get_installed()
      local to_install = vim.iter(ensure_installed)
        :filter(function(p) return not vim.tbl_contains(already, p) end)
        :totable()
      if #to_install > 0 then
        require("nvim-treesitter").install(to_install)
      end

      -- Enable highlighting, indentation, and folding per-buffer
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("my_treesitter", { clear = true }),
        callback = function(args)
          -- start TS highlighting if a parser exists for this filetype
          local ok = pcall(vim.treesitter.start)
          if not ok then return end

          -- Treesitter-based indentation (experimental on main)
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

          -- Treesitter-based folding, folds open by default
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo.foldmethod = "expr"
        end,
      })
    end,
  },

  -- Treesitter text objects: select / move / swap by function, class, parameter.
  -- main branch to match nvim-treesitter above; keymaps are set manually.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true }, -- jump forward to the textobject, like targets.vim
        move = { set_jumps = true },   -- record moves in the jumplist
      })

      local select = require("nvim-treesitter-textobjects.select")
      local move = require("nvim-treesitter-textobjects.move")
      local swap = require("nvim-treesitter-textobjects.swap")

      -- Select (visual / operator-pending): e.g. daf, cif, vac, dia
      local sel = {
        ["af"] = "@function.outer",  ["if"] = "@function.inner",
        ["ac"] = "@class.outer",     ["ic"] = "@class.inner",
        ["aa"] = "@parameter.outer", ["ia"] = "@parameter.inner",
      }
      for lhs, q in pairs(sel) do
        vim.keymap.set({ "x", "o" }, lhs, function()
          select.select_textobject(q, "textobjects")
        end, { silent = true, desc = "Select " .. q })
      end

      -- Move between functions. ]m/[m override the native method motions and
      -- avoid vim-unimpaired's ]f/[f (files) and ]a/[a (args), and gitsigns' ]c/[c.
      vim.keymap.set({ "n", "x", "o" }, "]m", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { silent = true, desc = "Next function start" })
      vim.keymap.set({ "n", "x", "o" }, "[m", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { silent = true, desc = "Prev function start" })
      vim.keymap.set({ "n", "x", "o" }, "]M", function()
        move.goto_next_end("@function.outer", "textobjects")
      end, { silent = true, desc = "Next function end" })
      vim.keymap.set({ "n", "x", "o" }, "[M", function()
        move.goto_previous_end("@function.outer", "textobjects")
      end, { silent = true, desc = "Prev function end" })

      -- Swap the parameter under the cursor with the next / previous one
      vim.keymap.set("n", "<leader>sa", function()
        swap.swap_next("@parameter.inner")
      end, { silent = true, desc = "Swap parameter next" })
      vim.keymap.set("n", "<leader>sA", function()
        swap.swap_previous("@parameter.inner")
      end, { silent = true, desc = "Swap parameter prev" })
    end,
  },
}
