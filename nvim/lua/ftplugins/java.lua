local jdtls = require("jdtls")
local home = os.getenv("HOME")
local workspace = home .. "/.local/share/nvim/jdtls-workspace/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local mason_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls"
local os_config = "config_linux"

local config = {
	cmd = {
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xmx1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		"-jar",
		vim.fn.glob(mason_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
		"-configuration",
		mason_path .. "/" .. os_config,
		"-data",
		workspace,
	},
	root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
	settings = {
		java = {
			signatureHelp = { enabled = true },
			completion = { enabled = true },
			references = { includeDecompiledSources = true },
			inlayHints = {
				parameterNames = { enabled = "all" },
			},
		},
	},
	init_options = {
		bundles = {},
	},
	on_attach = function(client, bufnr)
		local map = function(key, cmd)
			vim.keymap.set("n", key, cmd, { buffer = bufnr })
		end

		map("gd", vim.lsp.buf.definition)
		map("gr", vim.lsp.buf.references)
		map("K", vim.lsp.buf.hover)
		map("<leader>rn", vim.lsp.buf.rename)
		map("<leader>ca", vim.lsp.buf.code_action)
		map("<leader>oi", jdtls.organize_imports)
	end,
}

-- Maven keymaps
vim.keymap.set("n", "<leader>mr", ":!mvn compile exec:java<CR>")
vim.keymap.set("n", "<leader>mc", ":!mvn compile<CR>")
vim.keymap.set("n", "<leader>mt", ":!mvn test<CR>")

jdtls.start_or_attach(config)
