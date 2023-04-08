local opt = vim.opt

-- 行号
opt.relativenumber = true
opt.number = true

-- 缩进
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.autoindent = true
opt.cindent = true

--持久性撤销
opt.undofile =true
--持久性撤销文件保存目录，需要确保目录已经存在
opt.undodir = vim.fn.expand("~/.config/nvim/.tmp/undo")

--使用+=-连在一起的单词认为是一个单词
vim.cmd([[set iskeyword+=-]])

-- creates a swapfile
opt.swapfile = false

--不生成备份文件
opt.backup = false

-- 自动折行
opt.wrap = true

-- 高亮当前行
opt.cursorline = true

-- 启用鼠标
opt.mouse:append("a")

opt.encoding = "utf-8"

-- 系统剪贴板
opt.clipboard:append("unnamedplus")

-- 默认新窗口右和下
opt.splitright = true
opt.splitbelow = true

-- 搜索忽略大小写
opt.ignorecase = true
opt.smartcase = true --搜索时若只有大写字母就区分大小写
opt.incsearch = true --边输入边搜索

--自动保存
opt.autowrite = true

--光标上下移动保留的行数
opt.scrolloff = 5

--取消新行自动注释
vim.api.nvim_create_autocmd({ "FileType" },{
    pattern = { "*" },
    command = "setlocal formatoptions-=c formatoptions-=r formatoptions-=o",
})

--高亮yy复制的内容
local au = vim.api.nvim_create_autocmd
local ag = vim.api.nvim_create_augroup
au("TextYankPost",{
    group = ag("yank_highlight",{}),
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch",timeout = 300 })
    end,
})

--打开文件时光标移动到上次退出的位置
vim.api.nvim_create_autocmd("BufReadPost", {
    pattern = "*",
    callback = function()
        if vim.fn.line("'\"") > 0 and vim.fn.line("'\"") <= vim.fn.line("$") then
            vim.fn.setpos(".", vim.fn.getpos("'\""))
            vim.cmd("silent! foldopen")
        end
    end,
})

-- 外观
opt.termguicolors = true -- 终端真颜色
-- 左侧标识列
opt.signcolumn = "yes"

-- 主题
vim.cmd[[colorscheme tokyonight-night]]

-- vim.o.background = "dark" -- or "light" for light mode
-- vim.cmd([[colorscheme gruvbox]])

