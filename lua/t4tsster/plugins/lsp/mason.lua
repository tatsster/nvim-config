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
        "html",
        "cssls",
        "sumneko_lua",
        "jedi_language_server",
        "jdtls",
        "gopls",
        "clangd",
    },
    -- auto-install configured servers (with lspconfig)
    automatic_installation = true, -- not the same as ensure_installed
})

mason_null_ls.setup({
    ensure_installed = {
        "prettier",
        "stylua",
        "eslint",
        "goimports",
        "autopep8",
    },
})
