return {
    -- {
    --     'nvim-lualine/lualine.nvim',
    --     event = "VeryLazy",
    --     dependencies = { 'nvim-tree/nvim-web-devicons' },
    --     config = function()
    --         require("lualine").setup()
    --     end,
    -- },
    -- {
    --     "folke/noice.nvim",
    --     event = "VeryLazy",
    --     dependencies = {
    --         "MunifTanjim/nui.nvim",
    --     },
    --     config = function()
    --         require("noice").setup({
    --             lsp = {
    --                 -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    --                 override = {
    --                     ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
    --                     ["vim.lsp.util.stylize_markdown"] = true,
    --                     ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
    --                 },
    --             },
    --             presets = {
    --                 bottom_search = true,
    --                 command_palette = true,
    --                 long_message_to_split = true,
    --                 inc_rename = false,
    --                 lsp_doc_border = false,
    --             }
    --         })
    --     end,
    -- },
    {
        "j-hui/fidget.nvim",
        event = "VeryLazy",
        config = function()
            require("fidget").setup()
        end,
    },
}
