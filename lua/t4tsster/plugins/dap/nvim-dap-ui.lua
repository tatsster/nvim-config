local status, dapui = pcall(require, "dapui")
if not status then
    return
end

dapui.setup({
    layouts = {
        {
            elements = {
            -- Elements can be strings or table with id and size keys.
                { id = "scopes", size = 0.25 },
                { id = "watches", size = 0.25 },
                { id = "breakpoints", size = 0.25 },
                { id = "stacks", size = 0.25 },
            },
            size = 40, -- 40 columns
            position = "left",
        },
        {
            elements = {
                "repl",
            },
            size = 0.2,
            position = "bottom",
        },
    },
})

local dap = require("dap")
dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end
