-- ==============================================================================
-- Language Server Protocol Configuration
-- ==============================================================================

return {
  -- LSP progress indicator (shows "gopls: indexing…" so you know when it's ready)
  { "j-hui/fidget.nvim", opts = {} },

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
              "-bazel-out",
              "-bazel-bin",
              "-bazel-testlogs",
              "-bazel-*",
              "-**/vendor",
              "-**/node_modules",
              "-**/testdata",
              "-**/.git",
            },
            analyses = {
              unusedparams = false,
              shadow = false,
              nilness = false,
              unusedwrite = false,
              useany = false,
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
            expandWorkspaceToModule = false,
          },
        },
      })

      -- Start/attach gopls for matching buffers
      vim.lsp.enable("gopls")

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local buf = args.buf
          local map = function(lhs, fn, desc)
            vim.keymap.set("n", lhs, fn, { buffer = buf, silent = true, desc = desc })
          end

          -- buffer-local nav/doc keymaps when gopls attaches
          map("gd", vim.lsp.buf.definition, "Go to definition")
          map("grr", vim.lsp.buf.references, "References")
          map("gri", vim.lsp.buf.implementation, "Implementation")
          map("<leader>gr", vim.lsp.buf.rename, "Rename")
          map("<leader>d", vim.diagnostic.open_float, "Line diagnostics")

          -- Code action / type definition / signature help
          map("<leader>ca", vim.lsp.buf.code_action, "Code action")
          map("gy", vim.lsp.buf.type_definition, "Go to type definition")
          vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help,
            { buffer = buf, silent = true, desc = "Signature help" })

          -- -- Toggle inlay hints
          -- if vim.lsp.inlay_hint then
          --   map("<leader>th", function()
          --     vim.lsp.inlay_hint.enable(
          --       not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
          --   end, "Toggle inlay hints")
          -- end

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
