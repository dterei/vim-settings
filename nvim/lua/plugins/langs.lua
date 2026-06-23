-- ==============================================================================
-- Filetype / language support plugins
-- ==============================================================================

return {
  -- Markdown (alternative syntax/conceal)
  { "plasticboy/vim-markdown", ft = "markdown" },

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
}
