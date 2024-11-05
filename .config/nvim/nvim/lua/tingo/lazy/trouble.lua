return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = function()
        require("trouble").setup{}

        vim.keymap.set("n", "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>")
        vim.keymap.set("n", "<leader>tn", function() require("trouble").next() end)
        vim.keymap.set("n", "<leader>tp", function() require("trouble").prev() end)
        vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>")
    end
}
