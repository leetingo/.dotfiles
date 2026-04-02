require("tingo.remap")
require("tingo.set")
require("tingo.lazy_init")

local augroup = vim.api.nvim_create_augroup
local TingoGroup = augroup('Tingo', {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup('HighlightYank', {})

autocmd('TextYankPost', {
    group = yank_group,
    pattern = '*',
    callback = function()
        vim.hl.on_yank({
            higroup = 'IncSearch',
            timeout = 40,
        })
    end,
})

autocmd({"BufWritePre"}, {
    group = TingoGroup,
    pattern = "*",
    callback = function()
        if vim.bo.filetype == "markdown" then return end
        local view = vim.fn.winsaveview()
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.winrestview(view)
    end,
})

autocmd('LspAttach', {
    group = TingoGroup,
    callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.jump({count=1, float=true}) end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.jump({count=-1, float=true}) end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
    end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25
