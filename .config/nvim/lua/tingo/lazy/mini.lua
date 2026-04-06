return {
    {
        'echasnovski/mini.ai',
        event = "VeryLazy",
        version = false,
        config = function()
            local ai = require('mini.ai')
            ai.setup({
                n_lines = 500,
                custom_textobjects = {
                    o = ai.gen_spec.treesitter({
                        a = { "@block.outer", "@conditional.outer", "@loop.outer" },
                        i = { "@block.inner", "@conditional.inner", "@loop.inner" },
                    }, {}),
                    f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
                    c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
                    t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
                },
            })
        end
    },
    {
        'echasnovski/mini.pairs',
        event = "VeryLazy",
        version = false,
        config = function()
            require('mini.pairs').setup({
                    modes = { insert = true, command = true, terminal = false },
                    -- skip autopair when next character is one of these
                    skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
                    -- skip autopair when the cursor is inside these treesitter nodes
                    skip_ts = { "string" },
                    -- skip autopair when next character is closing pair
                    -- and there are more closing pairs than opening pairs
                    skip_unbalanced = true,
                    -- better deal with markdown code blocks
                    markdown = true,
                })
        end
    },
    {
        'echasnovski/mini.surround',
        event = "VeryLazy",
        version = false,
        config = function()
            require('mini.surround').setup()
        end
    },
    {
        'echasnovski/mini.comment',
        event = "VeryLazy",
        version = false,
        config = function()
            require('mini.comment').setup()
        end
    },
}
