-- ==============================================================================
-- Autocommands
-- ==============================================================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- Jump to last known cursor position when editing a file
autocmd("BufReadPost", {
  group = augroup("myjump", { clear = true }),
  callback = function(args)
    local ft = vim.bo[args.buf].filetype
    if ft == "gitcommit" or ft == "gitrebase" then return end
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Join lines: remove the comment leader when joining with J.
-- Applied on FileType (with opt_local) so it wins over the built-in ftplugins,
-- which reset formatoptions per-buffer after options.lua runs.
autocmd("FileType", {
  group = augroup("my_formatoptions", { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:append("j")
  end,
})

-- Flash when text is yanked
autocmd("TextYankPost", {
  group = augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.hl.on_yank({ timeout = 200 })
  end,
})

-- Fix solarized diff highlighting (scoped to the solarized-osaka scheme so it
-- doesn't clobber diff colors if a different colorscheme is loaded)
local function fix_diff_hl()
  vim.api.nvim_set_hl(0, "DiffAdd",    { bg = "#073642" })
  vim.api.nvim_set_hl(0, "DiffChange", { bg = "#073642" })
  vim.api.nvim_set_hl(0, "DiffText",   { bg = "#0a4a52", bold = true })
  vim.api.nvim_set_hl(0, "DiffDelete", { bg = "#073642" })
end
autocmd("ColorScheme", { pattern = "solarized-osaka*", callback = fix_diff_hl })
if vim.g.colors_name and vim.g.colors_name:match("^solarized%-osaka") then
  fix_diff_hl()
end
