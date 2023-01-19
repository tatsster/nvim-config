vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps
keymap.set("i", "jk", "<ESC>") -- use jk to exit Insert mode

-- Clear search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

--------------------
-- Plugin keymaps
--------------------
-- vim-navigator
-- keymap.set("n", "<C-Left>", ":<C-U>TmuxNavigateLeft<cr>")
-- keymap.set("n", "<C-Right>", ":<C-U>TmuxNavigateRight<cr>")
-- keymap.set("n", "<C-Up>", ":<C-U>TmuxNavigateUp<cr>")
-- keymap.set("n", "<C-Down>", ":<C-U>TmuxNavigateDown<cr>")

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization 

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")

-- telescope
local builtin = require('telescope.builtin')
keymap.set('n', '<leader>ff', builtin.find_files, {}) -- find files within current working dir
keymap.set('n', '<leader>fs', builtin.live_grep, {}) -- find string in current working dir as you type
keymap.set('n', '<leader>fc', builtin.grep_string, {}) -- find string under cursor in current working dir
keymap.set('n', '<leader>fb', builtin.buffers, {}) -- list open buffers in current neovim instance
keymap.set('n', '<leader>fh', builtin.help_tags, {}) -- list available help tags

