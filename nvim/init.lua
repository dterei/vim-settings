-- ==============================================================================
-- David Terei's Neovim configuration (ported from .vimrc)
--
-- Layout:
--   init.lua                  -- this file: globals + bootstrap
--   lua/config/options.lua    -- `set` options
--   lua/config/keymaps.lua    -- key mappings
--   lua/config/autocmds.lua   -- autocommands
--   lua/config/commands.lua   -- user commands + small functions
--   lua/plugins/*.lua         -- file per plugin/group, auto-imported by lazy
-- ==============================================================================

-- ----------------------------------------------------------------------------
-- Globals that must be set BEFORE plugins load
-- ----------------------------------------------------------------------------

-- Leader keys (lazy.nvim requires these set before it loads)
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

-- Location for undo and session files
local datadir = vim.fn.stdpath("data")
vim.env.MYVIM = datadir
vim.env.SS = datadir .. "/sessions"
vim.fn.mkdir(datadir .. "/undo", "p")
vim.fn.mkdir(datadir .. "/sessions", "p")

-- ----------------------------------------------------------------------------
-- Bootstrap lazy.nvim
-- ----------------------------------------------------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- ----------------------------------------------------------------------------
-- Load core config (order matters: options first)
-- ----------------------------------------------------------------------------

require("config.options")

require("lazy").setup("plugins", {
  install = {},
  change_detection = { notify = false },
  ui = { border = "rounded" },
})

require("config.keymaps")
require("config.autocmds")
require("config.commands")
