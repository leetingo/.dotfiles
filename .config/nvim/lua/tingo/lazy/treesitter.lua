return {
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/nvim-treesitter-context",
        },
        build = ":TSUpdate",
        config = function()
            require('nvim-treesitter').setup({
                ensure_installed = { "vim", "vimdoc", "lua" },
                auto_install = true,
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.bo.syntax = "on"
                end,
            })

            require('nvim-ts-autotag').setup()
            require("treesitter-context").setup({
                max_lines = 1,
                multiline_threshold = 1,
                trim_scope = "outer",
                separator = nil,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        event = "VeryLazy",
        config = function()
            require('nvim-treesitter-textobjects').setup({
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            })
        end,
    },
}
