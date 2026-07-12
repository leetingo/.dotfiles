return {
    {
        "L3MON4D3/LuaSnip",
        event = "InsertEnter",
        -- follow latest release.
        version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
        -- install jsregexp (optional!).
        build = "make install_jsregexp",

        dependencies = { "rafamadriz/friendly-snippets" },

        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()

            local ls = require("luasnip")
            -- <C-h> is taken by signature_help (LspAttach), so use <C-l>/<C-j>
            vim.keymap.set({ "i", "s" }, "<C-l>", function()
                if ls.expand_or_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true, desc = "Snippet: expand or jump to next placeholder" })
            vim.keymap.set({ "i", "s" }, "<C-j>", function()
                if ls.jumpable(-1) then
                    ls.jump(-1)
                end
            end, { silent = true, desc = "Snippet: jump to previous placeholder" })
        end,
    }
}
