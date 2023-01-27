local status, telescope = pcall(require, "telescope")
if not status then
    return
end

local status, actions = pcall(require, "telescope.actions")
if not status then
    return
end

telescope.setup({
    -- configure custom mappings
    defaults = {
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous, -- move to prev result
                ["<C-j>"] = actions.move_selection_next, -- move to next result
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            },
        },
    },
})

local status, telescope_makefile = pcall(require, "telescope-makefile")
if not status then
    return
end

telescope_makefile.setup({
    default_target = 'default',
})

local status, telescope_dir = pcall(require, "dir-telescope")
if not status then
    return
end
telescope_dir.setup({
    hidden = true,
    respect_gitignore = true,
})

telescope.load_extension("fzf")
telescope.load_extension("dap")
telescope.load_extension("ui-select")
telescope.load_extension("make")
telescope.load_extension("dir")
