-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
    use('wbthomason/packer.nvim')

    -- lua functions that use again
    use('nvim-lua/plenary.nvim')

    -- Theme
    use('sainnhe/sonokai')

    -- Split windows nagivation
    use('christoomey/vim-tmux-navigator')

    -- maximize split
    use('szw/vim-maximizer')

    -- essential plugins
    use('numToStr/Comment.nvim') -- comment line with gc command

    -- file explorer
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    -- terminal 
    use {"akinsho/toggleterm.nvim", tag = '*'}

    -- keybindings
    use {
        "folke/which-key.nvim",
        config = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 100
        end
    }

    -- statusline
    use("nvim-lualine/lualine.nvim")
    use {
        'j-hui/fidget.nvim',
    }
    -- tabline
    use {'romgrk/barbar.nvim', wants = 'nvim-web-devicons'}

    -- fold
    use({'anuvyklack/pretty-fold.nvim'})

    -- fuzzy findding
    use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x" }) -- fuzzy finder
    use({ 'nvim-telescope/telescope-ui-select.nvim' })
    use({ "de-passage/telescope-makefile" }) -- Selection Makefile options
    use({ "princejoogie/dir-telescope.nvim", requires = {"nvim-telescope/telescope.nvim"}}) -- Grep in dir

    -- autocompletion
    use("hrsh7th/nvim-cmp") -- completion plugin
    use("hrsh7th/cmp-buffer") -- source for text in buffer
    use("hrsh7th/cmp-path") -- source for file system paths
    use("hrsh7th/cmp-cmdline") -- source for cmdline

    -- snippet
    use({
        "L3MON4D3/LuaSnip",
        -- follow latest release.
        tag = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!:).
        run = "make install_jsregexp"
    })
    use("saadparwaiz1/cmp_luasnip") -- for autocompletion
    use("rafamadriz/friendly-snippets") -- useful snippets

    -- managing & installing lsp servers
    use("williamboman/mason.nvim")
    use("williamboman/mason-lspconfig.nvim")

    -- configuring lsp servers
    use("neovim/nvim-lspconfig")
    use("hrsh7th/cmp-nvim-lsp") -- for autocompletion
    use({ 
        'nvimdev/lspsaga.nvim',
        after = 'nvim-lspconfig',
    }) -- enhanced lsp uis
    use("onsails/lspkind.nvim") -- vs-code like icons for autocompletion
    use('folke/lsp-colors.nvim')

    -- Golang
    use('ray-x/go.nvim')
    use('ray-x/guihua.lua') -- recommanded if need floating window support

    -- DAP
    use('mfussenegger/nvim-dap')
    use({
        "rcarriga/nvim-dap-ui",
        requires = {"mfussenegger/nvim-dap"}
    })
    use({
        "nvim-telescope/telescope-dap.nvim",
        requires = { "mfussenegger/nvim-dap", "nvim-telescope/telescope.nvim" },
    })
    use('leoluz/nvim-dap-go')

    -- Treesitter 
    use({'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
            ts_update()
        end,
    })

     -- formatting & linting
    use("jose-elias-alvarez/null-ls.nvim") -- configure formatters & linters
    use("jayp0521/mason-null-ls.nvim") -- bridges gap b/w mason & null-ls

    -- auto closing
    use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...
    use({ "windwp/nvim-ts-autotag", after = "nvim-treesitter" }) -- autoclose tags

    -- git integration
    use("lewis6991/gitsigns.nvim") -- show line modifications on left hand side
    use("tpope/vim-fugitive") -- Git in action

    -- Outline
    use("simrat39/symbols-outline.nvim")

    -- Autosave
    use("Pocco81/auto-save.nvim")

    if packer_bootstrap then
        require("packer").sync()
    end
end)
