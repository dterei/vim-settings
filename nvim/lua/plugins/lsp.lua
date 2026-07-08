-- ==============================================================================
-- Language Server Protocol Configuration
-- ==============================================================================

return {
  {
    "neovim/nvim-lspconfig",
    ft = "go",
    config = function()
      require("lspconfig").gopls.setup({
        settings = {
          gopls = {
            directoryFilters = {
              "-vendor",
              "-bazel-out",
              "-bazel-bin",
              "-bazel-testlogs",
              "-**/node_modules",
              "-**/testdata",
            },
            analyses = {
              unusedparams = true,
              nilness = true,
              unusedwrite = true,
              useany = true,
            },
            hints = {
              parameterNames = true,
              assignVariableTypes = false,
              compositeLiteralFields = false,
            },
            buildFlags = {},
            completeUnimported = true,
            staticcheck = false,
            semanticTokens = false,
            usePlaceholders = true,
          },
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          -- buffer-local nav/doc keymaps when gopls attaches
          -- local map = function(lhs, fn) vim.keymap.set("n", lhs, fn, { buffer = buf, silent = true }) end
          -- map("gd", vim.lsp.buf.definition)   -- jump to definition
          -- map("K",  vim.lsp.buf.hover)         -- godoc popup
          -- map("gr", vim.lsp.buf.references)    -- find references
          -- map("gi", vim.lsp.buf.implementation)
          -- map("<leader>gr", vim.lsp.buf.rename)
          
          -- Format on demand
          map("<leader>gf", function()
            vim.lsp.buf.format({ async = false })
          end, "Format buffer")

          -- Organize imports on demand (add missing, remove unused, group)
          map("<leader>I", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.organizeImports" } },
              apply = true,
            })
          end, "Organize imports")

          -- Optional: both at once — imports then format
          map("<leader>gF", function()
            vim.lsp.buf.code_action({
              context = { only = { "source.organizeImports" } },
              apply = true,
            })
            vim.lsp.buf.format({ async = false })
          end, "Organize imports + format")
        end,
      })
    end,
  },
}
