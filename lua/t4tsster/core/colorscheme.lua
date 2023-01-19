vim.g.material_style = "darker"

local status, _ = pcall(vim.cmd, "colorscheme material")
if not status then
    print("Colorscheme not found!")
    return
end
