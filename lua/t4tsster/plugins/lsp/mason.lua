local status, mason = pcall(require, "mason")
if not status then
    return
end

local status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status then
    return
end

local status, mason_null_ls = pcall(require, "mason-null-ls")
if not status then
    return
end

mason.setup()

mason_lspconfig.setup({
    ensure_installed = {
        "lua_ls",
        "jdtls",
        "gopls",
        "clangd",
        "html",
        "cssls",
    },
    -- auto-install configured servers (compatible with vim.lsp.enable)
    automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
    ensure_installed = {
        "prettier",
        "stylua",
        "golangci-lint",
        "goimports",
    },
})
