local function get_package()
    local co = coroutine.running()
    if co then
        return coroutine.create(function()
            local pkgs = {}
            vim.ui.input({ prompt = "Package: " }, function(input)
                pkgs = vim.split(input or "", " ")
                pkgs[1] = string.gsub(pkgs[1], "\\.", "${workspaceFolder}")
            end)
            coroutine.resume(co, pkgs[1])
        end)
    else
        local pkgs = {}
        vim.ui.input({ prompt = "Package: " }, function(input)
            pkgs = vim.split(input or "", " ")
            pkgs[1] = string.gsub(pkgs[1], "\\.", "${workspaceFolder}")
        end)
        return pkgs[1]
    end
end

local status, dap_go = pcall(require, "dap-go")
if not status then
    return
end

dap_go.setup({
    dap_configurations = {
        {
            type = "go",
            name = "Debug Package (Custom)",
            request = "launch",
            program = get_package,
        },
    },
})
