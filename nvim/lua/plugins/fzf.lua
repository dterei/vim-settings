-- ==============================================================================
-- FZF fuzzy finding
-- ==============================================================================

return {
  {
    "junegunn/fzf.vim",
    dependencies = {
      { "junegunn/fzf", build = ":call fzf#install()" },
    },
    lazy = false,
    config = function()
      -- :Rg using ripgrep with preview
      vim.cmd([[
        command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always '.shellescape(<q-args>), 1,
          \   <bang>0 ? fzf#vim#with_preview('up:60%')
          \           : fzf#vim#with_preview('right:50%:hidden', '?'),
          \   <bang>0)
      ]])

      local map = vim.keymap.set
      local s = { silent = true }

      map("n", "<Leader>t", "<cmd>Files<CR>", s)
      map("n", "<Leader>bb", "<cmd>Buffers<CR>", s)
      map("n", "<Leader>c", "<cmd>BTag<CR>", s)  -- needs universal-ctags

      -- fzf-maps
      map("n", "<leader><tab>", "<plug>(fzf-maps-n)", { remap = true })
      map("x", "<leader><tab>", "<plug>(fzf-maps-x)", { remap = true })
      map("o", "<leader><tab>", "<plug>(fzf-maps-o)", { remap = true })

      -- insert-mode completion
      map("i", "<c-x><c-f>", "<plug>(fzf-complete-path)", { remap = true })
      map("i", "<c-x><c-j>", "<plug>(fzf-complete-file)", { remap = true })
      map("i", "<c-x><c-l>", "<plug>(fzf-complete-line)", { remap = true })
      map("i", "<c-x><c-k>", function()
        return vim.fn["fzf#vim#complete#word"]({ left = "15%" })
      end, { expr = true })

      -- text search
      map("n", "<Leader>f", ":Rg<space>")
      map("n", "<Leader>F", ":Rg!<space>")
      map("n", "<Leader>G", "<cmd>execute 'Rg '.expand('<cword>')<CR>", s)
    end,
  },
}
