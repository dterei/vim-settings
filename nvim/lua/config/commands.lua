-- ==============================================================================
-- User commands + small functions
-- ==============================================================================

-- ----------------------------------------------------------------------------
-- Highlight trailing whitespace + over-length lines (ToggleLongLines)
-- ----------------------------------------------------------------------------
local function set_long_line_highlights()
  vim.cmd([[highlight WhitespaceEOL ctermbg=DarkYellow ctermfg=white guibg=DarkYellow]])
  vim.cmd([[highlight OverLength    ctermbg=Red ctermfg=White guibg=#592929]])
end
vim.api.nvim_create_autocmd("ColorScheme", { callback = set_long_line_highlights })
set_long_line_highlights()

local function toggle_long_lines()
  local w = vim.w
  if w.long_line_match then
    pcall(vim.fn.matchdelete, w.long_line_match)
    w.long_line_match = nil
  else
    w.long_line_match = vim.fn.matchadd("OverLength", [[\%>80v.\+]], -1)
  end
  if w.trailing_spaces then
    pcall(vim.fn.matchdelete, w.trailing_spaces)
    w.trailing_spaces = nil
  else
    w.trailing_spaces = vim.fn.matchadd("WhitespaceEOL", [[\s\+$]], -1)
  end
end

vim.api.nvim_create_user_command("HighlightLongLines", toggle_long_lines, {})
vim.keymap.set("n", "<Leader>h", toggle_long_lines, { silent = true })

vim.api.nvim_create_user_command("DeleteTrailingWs", [[%s/\s\+$//e]], {})

-- ----------------------------------------------------------------------------
-- Sessions
-- ----------------------------------------------------------------------------
vim.api.nvim_create_user_command("SaveSession", "mksession! $SS/Session.vim", {})
vim.api.nvim_create_user_command("LastSession", "source $SS/Session.vim", {})

-- ----------------------------------------------------------------------------
-- Diff current buffer against the file on disk
-- ----------------------------------------------------------------------------
vim.api.nvim_create_user_command("DiffOrig", function()
  vim.cmd("vert new | set bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis")
end, {})

-- ----------------------------------------------------------------------------
-- Misc utility commands
-- ----------------------------------------------------------------------------

vim.api.nvim_create_user_command("Wgrep", function()
  vim.cmd("silent grep! " .. vim.fn.expand("<cword>"))
  vim.cmd("copen")
end, {})

vim.api.nvim_create_user_command("Latest", "later 10000d", {})
