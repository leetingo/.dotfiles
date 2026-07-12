return {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
        { "<leader>pf", function() require("telescope.builtin").find_files() end, desc = "Telescope: find files" },
        { "<C-p>", function() require("telescope.builtin").git_files() end, desc = "Telescope: git files" },
        {
            "<leader>ps",
            function()
                require("telescope.builtin").grep_string({ search = vim.fn.input('Grep > '), })
            end,
            desc = "Telescope: grep string",
        },
        { "<leader>vh", function() require("telescope.builtin").help_tags() end, desc = "Telescope: help tags" },
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' }
    },
    config = function()
        require("telescope").load_extension("fzf")
    end
}
