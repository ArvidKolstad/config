-- Quarto: cell runner (run_cell/run_above/run_all) + LSP features (diagnostics,
-- completion, hover) inside python code cells, via otter.nvim

return {
	{
		"quarto-dev/quarto-nvim",
		ft = { "quarto", "markdown" },
		dependencies = { "jmbuhr/otter.nvim", "nvim-treesitter/nvim-treesitter" },
		opts = {
			codeRunner = {
				enabled = true,
				default_method = "molten",
				ft_runners = { python = "molten" },
			},
			lspFeatures = {
				enabled = true,
				chunks = "curly", -- only recognize ```{python} chunks, not plain ```python
				languages = { "python" },
				diagnostics = {
					enabled = true,
					triggers = { "BufWritePost" },
				},
				completion = { enabled = true },
			},
		},
		config = function(_, opts)
			-- quarto has no dedicated tree-sitter grammar; parse quarto buffers as markdown
			vim.treesitter.language.register("markdown", "quarto")

			require("quarto").setup(opts)

			-- lazy-loading means the FileType event that triggered this plugin to
			-- load already fired before the autocmd below existed -- activate the
			-- current buffer directly so the first notebook opened isn't missed
			if vim.bo.filetype == "markdown" then
				pcall(function()
					require("quarto").activate()
				end)
			end

			local runner = require("quarto.runner")
			vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "Run cell", silent = true })
			vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "Run cell and above", silent = true })
			vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "Run all cells", silent = true })
			vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "Run line", silent = true })
			vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "Run visual range", silent = true })
			vim.keymap.set("n", "<localleader>oi", "<Cmd>MoltenInterrupt<CR>", { desc = "Interrupt kernel" })
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "quarto",
				callback = function()
					local ok = pcall(function()
						require("quarto").activate()
					end)
				end,
			})
		end,
	},

	-- Extracts code-cell content into real hidden buffers so a normal LSP (pyright)
	-- can attach and provide diagnostics/completion/hover inside cells.
	{
		"jmbuhr/otter.nvim",
		opts = {
			lsp = {
				-- use the notebook's own working directory as root, so pyright finds
				-- the project's pyproject.toml / venv correctly
				root_dir = function()
					return vim.fn.getcwd()
				end,
			},
		},
	},
}
