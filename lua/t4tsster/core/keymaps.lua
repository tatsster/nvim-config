local wk = require("which-key")
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

-- general keymaps
keymap.set("t", "<ESC>", "<C-\\><C-n>") -- Exit terminal mode

-- Clear search highlight
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- Window management
wk.register({
    s = {
        name = "Windows", -- optional group name
        v = {"<C-w>v", "Split window vertically"},
        h = {"<C-w>s", "Split window horizontally"},
        e = {"<C-w>=", "Make split windows equally"},
        x = {":close<CR>", "Close current window"},
    },
}, { prefix = "<leader>" })

-- Tab management
wk.register({
    t = {
        name = "Tab",
        o = {":tabnew<CR>", "Open New Tab"},
        x = {":tabclose<CR>", "Close Tab"},
        n = {":tabn<CR>", "Go to next Tab"},
        p = {":tabp<CR>", "Go to previous Tab"},
    },
}, {prefix = "<leader>"})

--------------------
-- Plugin keymaps
--------------------

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization 

-- nvim-tree
wk.register({
    e = {
        name = "Nvim Tree",
        t = { "<cmd>NvimTreeToggle<CR>", "Toggle Nvim Tree" },
        f = { "<cmd>NvimTreeFindFile<CR>", "Focus file on buffer"},
    }
}, { prefix = "<leader>"})

-- telescope
wk.register({
    f = {
        name = "Find", -- optional group name
        f = { "<cmd>Telescope find_files<CR>", "Find File" },
        l = { "<cmd>Telescope live_grep<CR>", "Live Grep all" },
        d = { "<cmd>Telescope dir live_grep<CR>", "Live Grep in dir"},
        s = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Find in current file"},
        b = { "<cmd>Telescope buffers<CR>", "Open Buffers" },
        h = { "<cmd>Telescope help_tags<CR>", "Help Tags"},
    },
}, { prefix = "<leader>" })

wk.register({
    M = { ":Telescope make<CR>", "Make Targets", },
})

-- symbols-outline
keymap.set("n", "<leader>so", ":SymbolsOutline<CR>") -- toggle Symbols Outline

-- Debugging
keymap.set("n", "<F5>", ":lua require'dap'.continue()<CR>")
keymap.set("n", "<F10>", ":lua require'dap'.step_over()<CR>")
keymap.set("n", "<F11>", ":lua require'dap'.step_into()<CR>")
keymap.set("n", "<F12>", ":lua require'dap'.step_out()<CR>")
keymap.set("n", "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>")
wk.register({
    d = {
        name = "DAP",
        t = { ":lua require'dapui'.toggle()<CR>", "Toggle DAP UI"},
    }
})

