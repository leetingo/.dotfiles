return {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
        -- "nvim-treesitter/nvim-treesitter-context",
        "RRethy/vim-illuminate",
    },
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            -- A list of parser names
            ensure_installed = { "vim", "vimdoc", "lua", "go" },

            -- Install parsers synchronously (only applied to `ensure_installed`)
            sync_install = false,

            -- Automatically install missing parsers when entering buffer
            -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
            auto_install = true,

            highlight = {
                -- `false` will disable the whole extension
                enable = true,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = { "markdown" },
            },

            textobjects = {
                select = {
                    enable = true,

                    lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim

                    keymaps = {
                        -- You can use the capture groups defined in textobjects.scm
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                }
            }
        })
        require('nvim-ts-autotag').setup()
    end
}
