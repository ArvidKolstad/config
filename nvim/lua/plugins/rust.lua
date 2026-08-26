return {
	-- Core Rust tooling (LSP, debugging, code actions)
	{
		"mrcjkb/rustaceanvim",
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				server = {
					default_settings = {
						["rust-analyzer"] = {
							cargo = {
								allFeatures = true,
							},
							-- FIX IS HERE: Change 'checkOnSave' to 'check'
							check = {
								command = "clippy",
							},
						},
					},
				},
			}
		end,
	},

	-- Append rust-analyzer to your existing Mason setup safely
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "rust-analyzer")
		end,
	},
}
