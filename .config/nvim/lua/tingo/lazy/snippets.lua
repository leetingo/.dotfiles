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
                if ls.expand_or_locally_jumpable() then
                    ls.expand_or_jump()
                end
            end, { silent = true, desc = "Snippet: expand or jump to next placeholder" })
            -- expr mapping: callbacks run under textlock, so return the <Plug>
            -- mapping instead of calling ls.jump(-1) directly; fall back to the
            -- built-in <C-j> (begin new line) outside a snippet
            vim.keymap.set({ "i", "s" }, "<C-j>", function()
                if ls.locally_jumpable(-1) then
                    return "<Plug>luasnip-jump-prev"
                end
                return "<C-j>"
            end, { expr = true, silent = true, desc = "Snippet: jump to previous placeholder" })
        end,
    }
}
