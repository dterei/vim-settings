-- ==============================================================================
-- Go support (vim-go)
-- ==============================================================================

return {
  {
    "fatih/vim-go",
    build = ":GoUpdateBinaries",
    ft = "go",
    init = function()
      local g = vim.g

      -- features
      g.go_gopls_enabled = 0
      g.go_code_completion_enabled = 0
      g.go_asmfmt_autosave = 0
      g.go_fmt_autosave = 0
      g.go_imports_autosave = 0
      g.go_auto_sameids = 0
      g.go_auto_type_info = 0
      g.go_metalinter_autosave = 0
      g.go_gocode_autobuild = 0
      g.go_diagnostics_enabled = 1
      g.go_dispatch_enabled = 1

      -- gopls tuning
      g.go_def_mapping_enabled = 0
      g.go_gopls_options = { '-remote.debug=:0', '--remote=auto' }

      -- doc
      g.go_doc_keywordprg_enabled = 1
      g.go_doc_popup_window = 1

      -- testing
      g.go_test_show_name = 1
      g.go_test_timeout = "20s"

      -- engines
      g.go_info_mode = "gopls"
      g.go_fmt_command = "gopls"
      g.go_imports_mode = "goimports"
      g.go_metalinter_command = "golangci-lint"
      g.go_implements_mode = "gopls"
      g.go_def_mode = "gopls"
      g.go_fillstruct_mode = "fillstruct"
      g.go_referrers_mode = "gopls"

      -- syntax highlighting
      g.go_highlight_functions = 1
      g.go_highlight_methods = 1
      g.go_highlight_structs = 1
      g.go_highlight_interfaces = 1
      g.go_highlight_operators = 1
      g.go_highlight_function_parameters = 0
      g.go_highlight_function_calls = 0
      g.go_highlight_types = 1
      g.go_highlight_fields = 0

      -- goimports local prefix
      g.go_gopls_local = "rubrik"
    end,
    config = function()
      local function setup_go_buffer(buf)
        local function m(lhs, rhs)
          vim.keymap.set("n", lhs, rhs, { buffer = buf, silent = true })
        end

        m("<leader>dv", "<Plug>(go-def-vertical)")
        m("<leader>ds", "<Plug>(go-def-split)")
        m("<leader>D", "<Plug>(go-doc)")
        m("<leader>gd", "<Plug>(go-doc-vertical)")
        m("<leader>gb", "<Plug>(go-doc-browser)")
        m("<leader>I", "<cmd>GoImports<CR>")
        m("<leader>B", "<Plug>(go-build)")
        m("<leader>R", "<Plug>(go-run)")
        m("<leader>T", "<cmd>GoTest -short<CR>")
        m("<leader>gT", "<Plug>(go-test-func)")
        m("<leader>gi", "<Plug>(go-info)")
        m("<leader>gr", "<Plug>(go-rename)")
        m("<leader>gf", "<Plug>(go-format)")
        m("<leader>gl", "<Plug>(go-metalinter)")
        m("<leader>gt", "<cmd>GoDecls<CR>")

        -- GoAlternate with traditional :A / :AV / :AS / :AT commands
        vim.api.nvim_buf_create_user_command(buf, "A", function(o)
          vim.fn["go#alternate#Switch"](o.bang, "edit")
        end, { bang = true })
        vim.api.nvim_buf_create_user_command(buf, "AV", function(o)
          vim.fn["go#alternate#Switch"](o.bang, "vsplit")
        end, { bang = true })
        vim.api.nvim_buf_create_user_command(buf, "AS", function(o)
          vim.fn["go#alternate#Switch"](o.bang, "split")
        end, { bang = true })
        vim.api.nvim_buf_create_user_command(buf, "AT", function(o)
          vim.fn["go#alternate#Switch"](o.bang, "tabedit")
        end, { bang = true })
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("mygo", { clear = true }),
        pattern = "go",
        callback = function(args) setup_go_buffer(args.buf) end,
      })

      -- Handle the buffer that triggered the lazy-load (autocmd already fired for it)
      if vim.bo.filetype == "go" then
        setup_go_buffer(vim.api.nvim_get_current_buf())
      end
    end,
  },
}
