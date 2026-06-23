-- ==============================================================================
-- Keymaps
-- ==============================================================================

local map = vim.keymap.set
local s = { silent = true }

-- quick reload
map("n", "<Leader>5", "<cmd>edit<CR>", s)

-- clear search highlight
map("n", "Q", "<cmd>nohlsearch<CR>", s)

-- F2 save
map("n", "<F2>", "<cmd>w<CR>", s)
map("i", "<F2>", "<C-o><cmd>w<CR>", s)

-- super-save / sessions
map("n", "<Leader>S", "<cmd>mksession! $SS/Session.vim<CR>")

-- spell check toggle
map("n", "<F6>", "<cmd>setlocal spell! spelllang=en_au<CR>", s)
map("i", "<F6>", "<C-o><cmd>setlocal spell! spelllang=en_au<CR>", s)

-- SpellBad: plain underline (alacritty doesn't do undercurl)
vim.cmd("hi clear SpellBad")
vim.cmd("hi SpellBad cterm=underline")

-- _ to start of line, - to end
map("n", "_", "^")
map("n", "-", "$")

-- remap incr/decr (using <C-a>/<C-x> keys for other purposes)
map("n", "<C-y>", "<C-a>", s)
map("n", "<C-h>", "<C-x>", s)

-- complete cancel (since <C-e> remapped to emacs End)
map("i", "<C-l>", "<C-e>", s)

-- emacs-style keys
map("i", "<C-e>", "<End>", s)
map("i", "<C-a>", "<Home>", s)
map("n", "<C-e>", "$", s)
map("n", "<C-a>", "^", s)
map("i", "<C-f>", "<Right>", s)
map("i", "<C-b>", "<Left>", s)
map("i", "<C-h>", "<Backspace>", s)
map("i", "<C-d>", "<Delete>", s)

-- stay in visual mode when indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- tag jumping
map("n", "<A-j>", "<cmd>tag<CR>", s)
map("n", "<A-k>", "<cmd>pop<CR>", s)
map("n", "<A-l>", "<C-]>", s)

-- enter command line without shift
map("n", ";", ":")
map("c", ";", "<C-C>")

-- scroll movement
map("n", "<C-k>", "2<C-Y>")
map("n", "<C-j>", "2<C-E>")

-- buffer switch / cycling
map("n", "<C-@>", "<cmd>b#<CR>")
map("n", "<C-n>", "<cmd>bn<CR>")
map("n", "<C-p>", "<cmd>bp<CR>")

-- open at current file's dir
map("n", "<Leader>e", "<cmd>edit %:p:h<CR>")
map("n", "<Leader>E", "<cmd>edit .<CR>")

-- close/quit
map("n", "<Leader>q", "<cmd>bp|bd #<CR>")
map("n", "<Leader>w", "<cmd>close<CR>")
map("n", "<Leader>Q", "<cmd>qall!<CR>")

-- :w!! to save with sudo
map("c", "w!!", "w !sudo tee % >/dev/null")
