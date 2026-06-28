-- ==============================================================================
-- Filetype / language support plugins
-- ==============================================================================

return {
  -- Rust
  { "rust-lang/rust.vim", ft = "rust" },

  -- Ansible
  {
    "pearofducks/ansible-vim",
    ft = { "yaml", "yaml.ansible", "ansible", "ansible_hosts", "jinja2" },
    init = function()
      vim.g.ansible_extra_syntaxes = "yaml.vim"
    end,
  },

  -- Markdown (better highlighting)
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-mini/mini.nvim' },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {},
  },
  -- {
  --   "lukas-reineke/headlines.nvim",
  --   dependencies = "nvim-treesitter/nvim-treesitter",
  --   config = true,
  -- },
}
