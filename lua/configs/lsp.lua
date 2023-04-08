local nvim_lsp = require('lspconfig')
require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup({
    -- 确保安装，根据需要填写
    ensure_installed = {
    },
})

--c/c++
require 'lspconfig'.clangd.setup {
    capabilities = capabilities,
}

--lua
require("lspconfig").lua_ls.setup {
    capabilities = capabilities,
}


local on_attach = function(client, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    local opts = { noremap = true, silent = true }
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- 跳函数声明
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    -- 跳函数定义
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    -- 文档窗
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gm', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    -- 重命名
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)

    -- code_action 修复建议
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gf', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- 代码格式化
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>gg=G<C-o>k', opts)

    --跳转到上一个或下一个错误
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gk', '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
    opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gj', '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
    opts)

    -- 错误信息浮窗
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    --问题发送到窗口
    --vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
end

-- -- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

local servers = { 'pyright', 'lua_ls', 'clangd' }
for _, lsp in pairs(servers) do
    require('lspconfig')[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = {
            debounce_text_changes = 150,
        }
    }
end
