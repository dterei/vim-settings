-- ==============================================================================
-- Options
-- ==============================================================================

local opt = vim.opt
local g = vim.g

-- Shell: inherit $SHELL (Neovim's default). No explicit override so that
-- external commands (:!, system(), plugins) run under the expected shell
-- without forcing zsh in environments where it isn't wanted.

-- Files: vim is stable & I save a lot
opt.backup = false
opt.swapfile = false
opt.autowrite = true  -- autosave before some commands
opt.encoding = "utf-8"
opt.switchbuf = "useopen"
opt.confirm = true    -- prompt to save instead of erroring on :q with changes

-- Permanent undo
opt.undofile = true
opt.undodir = vim.env.MYVIM .. "/undo"

-- Sessions
opt.sessionoptions = "blank,buffers,curdir,folds,help,resize,tabpages,winsize"

-- Completion
opt.completeopt = "menuone,noselect"
opt.history = 100

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Better grep if available
if vim.fn.executable("rg") == 1 then
  opt.grepprg = "rg --vimgrep --smart-case"
  opt.grepformat = "%f:%l:%c:%m"
end

-- Global ignore files
opt.wildignore:append({
  "*.o", "*.obj", "*.bak", "*.exe", "*~",
  "*.hi", "*.pyc", "*.class", "*.swp",
})

opt.autochdir = false  -- `set noacd`

-- Status bar
opt.cmdheight = 1
opt.laststatus = 3

-- Splits open to the right / below
opt.splitright = true
opt.splitbelow = true

-- Scrolling
opt.scrolloff = 3


-- Indentation
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true

-- Esc handling
opt.timeoutlen = 400
opt.ttimeoutlen = 10
-- Display
opt.number = false
opt.cursorline = true
opt.showmatch = true
opt.guicursor = "a:blinkon0"
opt.signcolumn = "yes"       -- always shown, so text doesn't jump when signs appear
opt.updatetime = 250         -- snappier CursorHold (gitsigns blame, diagnostics)
opt.spelloptions = "camel"   -- treat camelCase segments as separate spell words
opt.shada = "'500,<500,s50,:0,@30,/30,!" -- viminfo -> shada
opt.list = false
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.pumheight = 10
opt.inccommand = "split"  -- live preview of :s substitutions in a split

-- Folding (Treesitter-based folding is configured in plugins/treesitter.lua;
-- these are the global defaults so non-TS buffers behave as before)
opt.foldenable = true
opt.foldmethod = "indent"
opt.foldlevelstart = 99

-- Diff with syntax highlight
opt.diffopt:append("linematch:60")

-- Enable nerdfonts
g.have_nerd_font = true
