return {
	"mason-org/mason-lspconfig.nvim",
	opts = {
		automatic_enable = {
			exclude = { "rust_analyzer" },
		},
	},
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		"neovim/nvim-lspconfig",
	},
	config = function(_, opts)
		-- 1. Initialize mason-lspconfig with your existing options
		require("mason-lspconfig").setup(opts)

		-- 2. Configure basedpyright using the new Neovim 0.11 native API
		vim.lsp.config("basedpyright", {
			settings = {
				basedpyright = {
					analysis = {
						typeCheckingMode = "standard",
						diagnosticMode = "workspace",
						inlayHints = {
							callArgumentNames = true,
							variableTypes = true,
							functionReturnTypes = true,
						},
					},
				},
			},
		})

		-- 3. Explicitly enable the server
		vim.lsp.enable("basedpyright")
	end,
}
