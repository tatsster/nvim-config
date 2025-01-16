local wk = require("which-key")
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps
keymap.set("t", "<ESC>", "<C-\\><C-n>") -- Exit terminal mode

-- Clear search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Window management
wk.add({
    { "<leader>s", group = "Windows" },
    { "<leader>sv", "<C-w>v", desc = "Split window vertically" },
    { "<leader>sh", "<C-w>s", desc = "Split window horizontally" },
    { "<leader>se", "<C-w>=", desc = "Make split windows equally" },
    { "<leader>sx", ":close<CR>", desc = "Close current window" },
})

-- Tab management
wk.add({
    { "<leader>t", group = "Tab" },
    { "<leader>tn", ":tabn<CR>", desc = "Go to next Tab" },
    { "<leader>to", ":tabnew<CR>", desc = "Open New Tab" },
    { "<leader>tp", ":tabp<CR>", desc = "Go to previous Tab" },
    { "<leader>tx", ":tabclose<CR>", desc = "Close Tab" },
})

--------------------
-- Plugin keymaps
--------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization 

-- nvim-tree
wk.add({
    { "<leader>e", group = "Nvim Tree" },
    { "<leader>ef", "<cmd>NvimTreeFindFile<CR>", desc = "Focus file on buffer" },
    { "<leader>et", "<cmd>NvimTreeToggle<CR>", desc = "Toggle Nvim Tree" },
})

-- telescope
wk.add({
    { "<leader>f", group = "Find" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Open Buffers" },
    { "<leader>fd", "<cmd>Telescope dir live_grep<CR>", desc = "Live Grep in dir" },
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find File" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help Tags" },
    { "<leader>fl", "<cmd>Telescope live_grep<CR>", desc = "Live Grep all" },
    { "<leader>fs", "<cmd>Telescope current_buffer_fuzzy_find<CR>", desc = "Find in current file" },
})

wk.add({
    { "M", ":Telescope make<CR>", desc = "Make Targets" },
})

-- symbols-outline
keymap.set("n", "<leader>so", ":SymbolsOutline<CR>") -- toggle Symbols Outline

-- Debugging
keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>")
keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>")
keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
wk.add({
    { "d", group = "DAP" },
    { "dt", ":lua require'dapui'.toggle()<CR>", desc = "Toggle DAP UI" },
})

