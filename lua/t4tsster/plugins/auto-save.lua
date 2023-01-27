local status, autosave = pcall(require, "auto-save")
if not status then
    return
end

autosave.setup({
    enabled = true,
    write_all_buffers = true,
    debounce_delay = 5000,
})
