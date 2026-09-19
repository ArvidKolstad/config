return {
	{
		"benlubas/molten-nvim",
		version = "^1.0.0", -- use version <2.0.0 to avoid breaking changes
		dependencies = { "3rd/image.nvim" },
		build = ":UpdateRemotePlugins",
		init = function()
			-- these are examples, not defaults. Please see the readme
			vim.g.molten_image_provider = "image.nvim"
			vim.g.molten_output_win_max_height = 20
			vim.g.molten_auto_open_output = true
			vim.g.molten_wrap_output = true
			vim.g.molten_virt_text_output = true
			vim.g.molten_virt_lines_off_by_1 = true
		end,
	},
	{
		"3rd/image.nvim",
		opts = {
			backend = "kitty",
			max_width = 100,
			max_height = 12,
			max_height_window_percentage = math.huge,
			max_width_window_percentage = math.huge,
			window_overlap_clear_enabled = true,
			window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
		},
	},
	{
		"quarto-dev/quarto-nvim",
		dependencies = {
			"jmbuhr/otter.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
	},
	{
		"GCBallesteros/jupytext.nvim",
		lazy = false,
		config = function()
			require("jupytext").setup({
				style = "markdown",
				output_extension = ".md",
				force_ft = "markdown",
			})
		end,
	},

	{
		"OXY2DEV/markview.nvim",
		ft = { "markdown" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		opts = {},
	},
	{
		"chrisgrieser/nvim-various-textobjs",
		opts = {},
		keys = {
			{
				"gx",
				function()
					require("various-textobjs").url()
					local foundURL = vim.fn.mode() == "v"
					if not foundURL then
						return
					end
					local url = vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = "v" })[1]
					vim.ui.open(url)
					vim.cmd.normal({ "v", bang = true }) -- leave visual mode
				end,
				desc = "Open URL under/after cursor",
			},
		},
	},
}
