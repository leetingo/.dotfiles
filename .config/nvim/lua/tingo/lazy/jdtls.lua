return {
    "mfussenegger/nvim-jdtls",
    dependencies = {
        "williamboman/mason.nvim",
        "mfussenegger/nvim-dap",
    },
    ft = "java",
    config = function()
        local mason_path = vim.fn.stdpath("data") .. "/mason"

        local jdtls_home = mason_path .. "/packages/jdtls"
        local launcher_path = jdtls_home .. "/plugins/org.eclipse.equinox.launcher_*.jar"
        local launcher_jar = vim.fn.glob(launcher_path)

        if vim.v.shell_error ~= 0 or vim.fn.empty(launcher_jar) == 1 then
            vim.notify("JDTLS launcher JAR not found at: " .. launcher_path, vim.log.levels.ERROR)
            return
        end

        local lombok_jar = vim.env.HOME .. "/.local/share/nvim/mason/packages/jdtls/lombok.jar"

        local bundles = {}

        local java_debug_path = mason_path .. "/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"
        local java_debug_jars = vim.fn.glob(java_debug_path, false, true)
        vim.list_extend(bundles, java_debug_jars)

        local java_test_path = mason_path .. "/packages/java-test/extension/server/*.jar"
        local java_test_jars = vim.fn.glob(java_test_path, false, true)
        vim.list_extend(bundles, java_test_jars)

        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

        local cmd = {
            "/Library/Java/JavaVirtualMachines/jdk-21.jdk/Contents/Home/bin/java",
            "-Declipse.application=org.eclipse.jdt.ls.core.id1",
            "-Dosgi.bundles.defaultStartLevel=4",
            "-Declipse.product=org.eclipse.jdt.ls.core.product",
            "-Dlog.level=ALL",
            "-Xmx1G",
            "--add-modules=ALL-SYSTEM",
            "--add-opens", "java.base/java.util=ALL-UNNAMED",
            "--add-opens", "java.base/java.lang=ALL-UNNAMED",
            "-javaagent:" .. lombok_jar,
            "-jar", launcher_jar,
            "-configuration", jdtls_home .. (vim.fn.has("mac") == 1 and "/config_mac" or "/config_linux"),
            "-data", workspace_dir,
        }

        local config = {
            root_dir = require("jdtls").setup.find_root({ ".git", "mvnw", "gradlew" }),
            cmd = cmd,
            init_options = {
                bundles = bundles,
            },
        }

        vim.api.nvim_create_autocmd("LspAttach", {
            pattern = "*.java",
            callback = function(args)
                if vim.lsp.get_client_by_id(args.data.client_id).name == "jdtls" then
                    require('jdtls').setup_dap({ hotcodereplace = 'auto' })
                end
            end
        })

        require("jdtls").start_or_attach(config)
    end,
}

