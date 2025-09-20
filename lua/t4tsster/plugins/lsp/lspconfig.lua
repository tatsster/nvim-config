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
    wk.add({
        { "g", desc = "GoTo" },
        { "gD", vim.lsp.buf.declaration, desc = "Go to declaration" },
        -- { "gd", "<cmd>Lspsaga peek_definition<CR>", desc = "Peek definition" },
        { "gd", vim.lsp.buf.definition, desc = "Go to definition"},
        { "gf", "<cmd>Lspsaga lsp_finder<CR>", desc = "Show definition, references" },
        { "gi", vim.lsp.buf.implementation, desc = "Go to implementation" },
    })

    --[[ wk.register({
        g = {
            "GoTo",
            f = { "<cmd>Lspsaga lsp_finder<CR>" , "Show definition, references"},
            D = { vim.lsp.buf.declaration, "Go to declaration"},
            d = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition"},
            i = { vim.lsp.buf.implementation, "Go to implementation"},
        }
    }, { prefix = '', mode = "n", opts }) ]]
    keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
    keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
    keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor

    wk.register({
        d = { "<cmd>Telescope diagnostics bufnr=0<cr>", "Document Diagnostics" },
        D = { "<cmd>Telescope diagnostics<cr>", "Workspace Diagnostics" },
    }, { prefix = "<leader>" , mode = "n", opts })

    if client.name == 'gopls' then
        wk.add({
            { "<leader>c", group = "Go Code" },
            { "<leader>ca", "<cmd>GoCodeAction<cr>", desc = "Code action" },
            { "<leader>ce", "<cmd>GoIfErr<cr>", desc = "Add if err" },
            { "<leader>cs", "<cmd>GoFillStruct<cr>", desc = "Autofill struct" },
            {
                { "<leader>ch", group = "Helper" },
                { "<leader>cha", "<cmd>GoAddTag<cr>", desc = "Add tags to struct" },
                { "<leader>chr", "<cmd>GoRMTag<cr>", desc = "Remove tags to struct" },
                { "<leader>cc", "<cmd>GoCoverage<cr>", desc = "Test coverage" },
                { "<leader>cg", "<cmd>lua require('go.comment').gen()<cr>", desc = "Generate comment" },
                { "<leader>cv", "<cmd>GoVet<cr>", desc = "Go vet" },
                { "<leader>ct", "<cmd>GoModTidy<cr>", desc = "Go mod tidy" },
                { "<leader>ci", "<cmd>GoModInit<cr>", desc = "Go mod init" },
            },
            {
                { "<leader>cx", group = "Code Lens" },
                { "<leader>cxl", "<cmd>GoCodeLenAct<cr>", desc = "Toggle Lens" },
                { "<leader>cxi", "<cmd>GoToggleInlay<CR>", desc = "Toggle InLay" },
            },
        })
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
vim.lsp.enable({
  name = 'html',
  cmd = { 'vscode-html-language-server', '--stdio' },
  root_patterns = { '.git', 'package.json' },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure golang with plugin
go.setup()
vim.lsp.enable({
    name = 'gopls',
    cmd = { 'gopls' },
    root_patterns = { 'go.mod', '.git' },
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
vim.lsp.enable({
  name = 'cssls',
  cmd = { 'vscode-css-language-server', '--stdio' },
  root_patterns = { '.git', 'package.json' },
  capabilities = capabilities,
  on_attach = on_attach,
})

-- configure lua server (with special settings)
vim.lsp.enable({
  name = 'lua_ls',
  cmd = { 'lua-language-server' },
  root_patterns = { '.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml', 'stylua.toml', 'selene.toml', 'selene.yml', '.git' },
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
