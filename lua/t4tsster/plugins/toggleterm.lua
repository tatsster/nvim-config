local status, toggleterm = pcall(require, "toggleterm")
if not status then
    return
end

toggleterm.setup({
    size = 15,
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    close_on_exit = true,
    direction = 'horizontal',
    float_opts = {
        border = "curved",
        winblend = 0,
        highlights = {
            border = "Normal",
            background = "Normal",
        },
    },
})

local wk = require("which-key")
wk.register({
    ['<C-\\>'] = { ':ToggleTerm<CR>', 'Toggle Terminal' }
})
