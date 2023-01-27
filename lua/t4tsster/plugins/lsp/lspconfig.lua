local status, lspconfig = pcall(require, "lspconfig")
if not status then
    return
end

local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status then
    return
end

local status, go = pcall(require, "go")
if not status then
    return
end

local keymap = vim.keymap

-- enable keybinds for available lsp server
local on_attach = function(client, bufnr)
    -- keybind options
    local opts = { noremap = true, silent = true, buffer = bufnr }

    local wk = require("which-key")

    -- set keybinds
    wk.register({
        g = {
            "GoTo",
            f = { "<cmd>Lspsaga lsp_finder<CR>" , "Show definition, references"},
            D = { vim.lsp.buf.declaration, "Go to declaration"},
            d = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition"},
            i = { vim.lsp.buf.implementation, "Go to implementation"},
        }
    }, { prefix = '', mode = "n", opts })
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

    wk.register({
        d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
        D = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
    }, { prefix = "<leader>" , mode = "n", opts })

    if client.name == 'gopls' then
        wk.register({
            c = {
                name = "Go Code",
                a = { "<cmd>GoCodeAction<cr>", "Code action" },
                e = { "<cmd>GoIfErr<cr>", "Add if err" },
                h = {
                    name = "Helper",
                    a = { "<cmd>GoAddTag<cr>", "Add tags to struct" },
                    r = { "<cmd>GoRMTag<cr>", "Remove tags to struct" },
                    c = { "<cmd>GoCoverage<cr>", "Test coverage" },
                    g = { "<cmd>lua require('go.comment').gen()<cr>", "Generate comment" },
                    v = { "<cmd>GoVet<cr>", "Go vet" },
                    t = { "<cmd>GoModTidy<cr>", "Go mod tidy" },
                    i = { "<cmd>GoModInit<cr>", "Go mod init" },
                },
                s = { "<cmd>GoFillStruct<cr>", "Autofill struct" },
                x = {
                    name = "Code Lens",
                    l = { "<cmd>GoCodeLenAct<cr>", "Toggle Lens" },
                    i = { "<cmd>GoToggleInlay<CR>", "Toggle InLay" },
                },
            },
        }, { prefix = "<leader>", mode = "n", opts })
    end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

-- configure html server
lspconfig["html"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure golang with plugin
go.setup()
lspconfig["gopls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            experimentalPostfixCompletions = true,
            analyses = {
                unusedparams = true,
		        shadow = true,
		    },
		    staticcheck = true,
		},
	},
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure lua server (with special settings)
lspconfig["sumneko_lua"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  settings = { -- custom settings for lua
    Lua = {
      -- make the language server recognize "vim" global
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        -- make language server aware of runtime files
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
})
