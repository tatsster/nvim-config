vim.g.monokaipro_filter = "spectrum"

local status, _ = pcall(vim.cmd, "colorscheme monokaipro")
if not status then
    print("Colorscheme not found!")
    return
end
