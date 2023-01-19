local status, gitsigns = pcall(require, "gitsigns")
if not status then
    return
end

gitsigns.setup({
    signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
    numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
    linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
    on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
    
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end
        
        map('n', '<leader>gb', gs.toggle_current_line_blame)
    end
})
