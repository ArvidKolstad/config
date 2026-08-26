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
}
