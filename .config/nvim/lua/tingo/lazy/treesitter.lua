return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "windwp/nvim-ts-autotag",
        "RRethy/vim-illuminate",
    },
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter').setup()
        require('nvim-treesitter').install({ "vim", "vimdoc", "lua" })
        require('nvim-ts-autotag').setup()

        -- Enable treesitter highlighting and auto-install missing parsers
        local available = require('nvim-treesitter').get_available()
        local available_set = {}
        for _, lang in ipairs(available) do
            available_set[lang] = true
        end

        vim.api.nvim_create_autocmd("FileType", {
            callback = function(ev)
                local lang = vim.treesitter.language.get_lang(vim.bo[ev.buf].filetype)
                if not lang then return end
                if pcall(vim.treesitter.language.inspect, lang) then
                    vim.treesitter.start(ev.buf)
                elseif available_set[lang] then
                    require('nvim-treesitter').install({ lang })
                end
            end,
        })
    end
}
