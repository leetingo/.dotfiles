return {
    'mfussenegger/nvim-dap',
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "nvim-neotest/nvim-nio",
        "rcarriga/nvim-dap-ui",
        "theHamsta/nvim-dap-virtual-text",
    },
    config = function()
        -- not sure this is needed
        require("mason").setup()
        require("mason-nvim-dap").setup({
            ensure_installed = {
                "delve", "codelldb"
            },
        })
        require("dapui").setup()
        require("nvim-dap-virtual-text").setup()

        local dap = require("dap")
        dap.listeners.after.event_initialized["dapui"] = function()
            require("dapui").open({})
            require("nvim-dap-virtual-text").refresh()
        end
        dap.listeners.after.event_terminated["dapui"] = function()
            require("dapui").close({})
            require("nvim-dap-virtual-text").refresh()
            vim.cmd("silent! bd! \\[dap-repl]")
        end
        dap.listeners.before.event_exited["dapui"] = function()
            require("dapui").close({})
            require("nvim-dap-virtual-text").refresh()
            vim.cmd("silent! bd! \\[dap-repl]")
        end

        -- set up go debugging
        dap.adapters.delve = {
            type = "server",
            port = "${port}",
            executable = {
                command = "dlv",
                args = { "dap", "-l", "127.0.0.1:${port}" },
            }
        }
        dap.configurations.go = {
            {
                type = "delve",
                name = "Debug",
                request = "launch",
                program = "${file}",
            },
            {
                type = "delve",
                name = "Debug test",
                request = "launch",
                mode = "test",
                program = "${file}"
            },
            {
                type = "delve",
                name = "Debug test (go.mod)",
                request = "launch",
                mode = "test",
                program = "./${relativeFileDirname}"
            }
        }
        -- setting up rust debugging
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = "codelldb",
                args = { "--port", "${port}"},
            },
        }
        dap.configurations.rust = {
            {
                name = "Debug (codelldb)",
                type = "codelldb",
                request = "launch",
                program = "${workspaceFolder}/target/debug/${workspaceFolderBasename}",
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                runInTerminal = true,
                terminal = "integrated",
            },
            {
                name = "Debug with args (codelldb)",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/${workspaceFolderBasename}", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
                runInTerminal = true,
                terminal = "integrated",
                args = function()
                    local args = {}
                    local i = 1
                    while true do
                        local arg = vim.fn.input("Argument [" .. i .. "]: ")
                        if arg == "" then
                            break
                        end
                        args[i] = arg
                        i = i + 1
                    end
                    return args
                end,
            },
            {
                name = "attach PID (codelldb)",
                type = "codelldb",
                request = "attach",
                pid = require("dap.utils").pick_process,
            },
            {
                name = "Attach to Name (wait) (codelldb)",
                type = "codelldb",
                request = "attach",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                waitFor = true,
            },
        }

        vim.keymap.set('n', '<leader>dB', function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end)
        vim.keymap.set('n', '<leader>db', function() require("dap").toggle_breakpoint() end)
        vim.keymap.set('n', '<F5>', function() require("dap").continue() end)
        vim.keymap.set('n', '<F6>', function() require("dap").pause() end)
        vim.keymap.set('n', '<F7>', function() require("dap").terminate() end)
        vim.keymap.set('n', '<F10>', function() require("dap").step_over() end)
        vim.keymap.set('n', '<F11>', function() require("dap").step_into() end)
        vim.keymap.set('n', '<F12>', function() require("dap").step_out() end)
        vim.keymap.set('n', '<leader>dr', function() require("dap").repl.open() end)
        vim.keymap.set('n', '<leader>dl', function() require("dap").run_last() end)
        vim.keymap.set('n', '<leader>dh', function() require("dap.ui.widgets").hover() end)

        vim.keymap.set('n', '<leader>du', function() require("dapui").toggle({ }) end)
        vim.keymap.set('n', '<leader>de', function() require("dapui").eval() end)
    end
}
