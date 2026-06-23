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
}
