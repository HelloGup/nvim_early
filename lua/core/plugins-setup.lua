local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

-- 保存自动安装插件
-- vim.cmd([[
--   augroup packer_user_config
--     autocmd!
--     autocmd BufWritePost plugins-setup.lua source <afile> | PackerSync
--   augroup end
-- ]])

return require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'      -- tokyonight主题
    use {
        'nvim-lualine/lualine.nvim', -- 状态栏
        --requires = { 'kyazdani42/nvim-web-devicons', opt = true }  -- 状态栏图标
    }
    use {
        'nvim-tree/nvim-tree.lua',         -- 文档树
        requires = {
            'nvim-tree/nvim-web-devicons', -- 文档树图标
        }
    }
    use "christoomey/vim-tmux-navigator" -- 用ctl-hjkl来定位窗口

    -- Treesittetr 高亮
    use "nvim-treesitter/nvim-treesitter"
    use "p00f/nvim-ts-rainbow" -- 配合treesitter，不同括号颜色区分
    -- use "romgrk/nvim-treesitter-context" -- show class/function at the top
    ----------------------------------------------

    use {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim", -- 这个相当于mason.nvim和lspconfig的桥梁
        "neovim/nvim-lspconfig"
    }

    -- 自动补全
    use "hrsh7th/nvim-cmp"
    use "hrsh7th/cmp-nvim-lsp"
    use "L3MON4D3/LuaSnip" -- snippets引擎，不装这个自动补全会出问题
    use "saadparwaiz1/cmp_luasnip"
    use "rafamadriz/friendly-snippets"
    use "hrsh7th/cmp-path" -- 文件路径
    use "hrsh7th/cmp-cmdline"
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lua"
    -------------------------

    -- 终端
    use "akinsho/toggleterm.nvim"

    -- 对选中文字进行高亮
    -- use "Pocco81/HighStr.nvim"

    use "numToStr/Comment.nvim"   -- gcc和gc注释
    use "windwp/nvim-autopairs"   -- 自动补全括号

    use "akinsho/bufferline.nvim" -- buffer分割线
    use "lewis6991/gitsigns.nvim" -- 左则git提示

    -- 文件检索
    -- 文本搜索本机环境需要安装rigpre
    use {
        "nvim-telescope/telescope-live-grep-args.nvim",
        commit = "10f62ecc6f6282e65adedaa3a0f18daea05664e64",
        requires = { { 'nvim-lua/plenary.nvim' } }
    }
    use "nvim-lua/popup.nvim"
    use {
        "nvim-telescope/telescope.nvim",
        tag = "nvim-0.6",
    }
    use "nvim-telescope/telescope-ui-select.nvim"
    use "nvim-telescope/telescope-rg.nvim"
    -- 模糊查找
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    use {
        "nvim-telescope/telescope-file-browser.nvim",
        requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
    }


    --书签
    use "MattesGroeger/vim-bookmarks"
    use "tom-anders/telescope-vim-bookmarks.nvim"

    ------------------------------------------------------
    -- 缩进线
    use "lukas-reineke/indent-blankline.nvim"

    --底部cmdline 改为通知显示
    use "folke/noice.nvim"
    use "MunifTanjim/nui.nvim"
    ------------------------------
    -- 文档大纲
    use "stevearc/aerial.nvim"
    --右上角通知
    use "rcarriga/nvim-notify"

    -- dap
    use {
        "ravenxrz/nvim-gdb",
        run = "./install.sh"
    }

    -- 快捷键
    -- use {
        --     "folke/which-key.nvim",
        --     config = function()
            --         vim.o.timeout = true
            --         vim.o.timeoutlen = 300
            --         require("which-key").setup {
                --             -- your configuration comes here
                --             -- or leave it empty to use the default settings
                --             -- refer to the configuration section below
                --         }
                --     end
                -- }
                -- My plugins here
                -- use 'foo1/bar1.nvim'
                -- use 'foo2/bar2.nvim'

                -- Automatically set up your configuration after cloning packer.nvim
                -- Put this at the end after all plugins
                if packer_bootstrap then
                    require('packer').sync()
                end
            end)
