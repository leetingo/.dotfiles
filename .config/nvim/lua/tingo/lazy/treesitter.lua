return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        dependencies = {
            "windwp/nvim-ts-autotag",
            "nvim-treesitter/nvim-treesitter-context",
        },
        build = ":TSUpdate",
        config = function()
            local required_parsers = { "vim", "vimdoc", "lua" }
            local treesitter = require("nvim-treesitter")

            treesitter.setup({
                install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site"),
            })

            treesitter.install(required_parsers)

            local group = vim.api.nvim_create_augroup("TingoTreesitter", { clear = true })
            local install_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "site")
            local available_parsers = require("nvim-treesitter.parsers")

            local function parser_installed(lang)
                return vim.uv.fs_stat(vim.fs.joinpath(install_dir, "parser", lang .. ".so")) ~= nil
            end

            vim.api.nvim_create_autocmd("FileType", {
                group = group,
                pattern = "*",
                callback = function(args)
                    if vim.bo[args.buf].filetype == "markdown" then
                        vim.bo[args.buf].syntax = "on"
                    end

                    local ft = vim.bo[args.buf].filetype
                    local lang = vim.treesitter.language.get_lang(ft) or ft

                    if not parser_installed(lang) then
                        if available_parsers[lang] then
                            treesitter.install({ lang })
                            local buf = args.buf
                            local timer = vim.uv.new_timer()
                            local attempts = 0
                            timer:start(500, 500, vim.schedule_wrap(function()
                                attempts = attempts + 1
                                if parser_installed(lang) then
                                    timer:stop()
                                    timer:close()
                                    if vim.api.nvim_buf_is_valid(buf) then
                                        vim.treesitter.start(buf)
                                        vim.bo[buf].indentexpr =
                                            "v:lua.require'nvim-treesitter'.indentexpr()"
                                    end
                                elseif attempts >= 120 then
                                    timer:stop()
                                    timer:close()
                                end
                            end))
                        end
                        return
                    end

                    local ok = pcall(vim.treesitter.start, args.buf)
                    if ok then
                        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    end
                end,
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
        branch = "main",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require('nvim-treesitter-textobjects').setup({
                select = {
                    lookahead = true,
                },
            })

            local select = require("nvim-treesitter-textobjects.select")
            local keymaps = {
                ["af"] = "@function.outer",
                ["if"] = "@function.inner",
                ["ac"] = "@class.outer",
                ["ic"] = "@class.inner",
            }

            for lhs, query in pairs(keymaps) do
                vim.keymap.set({ "x", "o" }, lhs, function()
                    select.select_textobject(query, "textobjects")
                end)
            end
        end,
    },
}
