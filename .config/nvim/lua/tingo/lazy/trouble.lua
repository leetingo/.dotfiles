return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {},
    keys = {
        { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble: toggle diagnostics" },
        { "<leader>tn", function() require("trouble").next() end, desc = "Trouble: next item" },
        { "<leader>tp", function() require("trouble").prev() end, desc = "Trouble: previous item" },
        { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble: toggle quickfix list" },
    },
}
