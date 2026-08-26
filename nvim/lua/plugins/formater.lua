return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				-- Web & Dokument (Prettier)
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },

				-- Lua
				lua = { "stylua" },

				-- Python (Uppdaterat till ruff!)
				python = { "ruff_format" },

				-- C / C++ (Från din null-ls-önskan)
				rust = { "rust-analyzer" },
				c = { "clang-format" },
				cpp = { "clang-format" },

				-- LaTeX (Bytt från latexindent till blixtsnabba tex-fmt + bibtex-tidy)
				tex = { "tex-fmt" },
				bib = { "bibtex-tidy" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 3000,
			},
		})

		-- Din existerande keymap för manuell formatering med <leader>mp
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
