-- ==============================================================================
-- Language Server Protocol Configuration
-- ==============================================================================

return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre *.go", "BufNewFile *.go" },
    config = function()
      -- Inline diagnostic messages at end of line. Neovim 0.11+ defaults this
      -- to false (signs + underline only); flip to true to try inline text.
      vim.diagnostic.config({ virtual_text = false })

      vim.lsp.config("gopls", {
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

      -- Start/attach gopls for matching buffers
      vim.lsp.enable("gopls")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local map = function(lhs, fn)
            vim.keymap.set("n", lhs, fn, { buffer = buf, silent = true })
          end

          -- buffer-local nav/doc keymaps when gopls attaches
          map("gd", vim.lsp.buf.definition)
          map("grr", vim.lsp.buf.references)
          map("gi", vim.lsp.buf.implementation)
          map("<leader>gr", vim.lsp.buf.rename)
          map("I", vim.diagnostic.open_float)

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
