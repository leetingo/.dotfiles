return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                styles = {
                    italic = false,
                    transparency = true,
                },
                highlight_groups = {
                    -- Fix LSP semantic tokens overriding treesitter highlights
                    ["@lsp.type.keyword"] = {},
                    ["@lsp.type.modifier"] = {},
                    ["@lsp.type.class"] = {},
                    ["@lsp.type.type"] = {},
                    ["@lsp.type.variable"] = {},
                    ["@lsp.type.property"] = {},
                },
            })
            vim.cmd.colorscheme("rose-pine")
        end
    },
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "tpope/vim-fugitive",
        cmd = { "Git", "G", "Gedit", "Gdiffsplit", "Gvdiffsplit", "Gread", "Gwrite", "Gclog" },
    }
}
