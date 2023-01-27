local setup, null_ls = pcall(require, "null_ls")
if not setup then
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

-- to setup format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local gotest = require("go.null_ls").gotest()
local gotest_codeaction = require("go.null_ls").gotest_action()

null_ls.setup({
    sources = {
        formatting.prettier,
        formatting.stylua,
        formatting.goimports.with({
            extra_args = {
                "--max-len=180",
                "--base-formatter=gofumpt",
            },
        }),
        formatting.autopep8,
        diagnostics.eslint_d,
        diagnostics.golangci_lint,
        diagnostics.revive,
        gotest,
        gotest_codeaction,
    },
    -- configure format on save
    on_attach = function(current_client, bufnr)
        if current_client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    vim.lsp.buf.format({
                        filter = function(client)
                            --  only use null-ls for formatting instead of lsp server
                            return client.name == "null-ls"
                        end,
                        bufnr = bufnr,
                    })
                end,
            })
        end
    end,
})
