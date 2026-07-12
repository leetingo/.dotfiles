return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        priority = 1000,
        config = function()
            require("rose-pine").setup({
                disable_background = true,
                styles = {
                    italic = false,
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
            function ColorMyPencils(color)
                color = color or "rose-pine"
                vim.cmd.colorscheme(color)

                vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
                vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
            end

            ColorMyPencils()
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
