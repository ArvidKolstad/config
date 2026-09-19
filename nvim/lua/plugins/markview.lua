-- Renders markdown/quarto formatting (headers, tables, LaTeX math -- including
-- multi-line block equations) inline. Uses Unicode symbol substitution for math,
-- not a real LaTeX engine, so a handful of commands (\left, \right, \mathrm{})
-- won't render and will show as raw text -- this is a known limitation, cosmetic
-- only, does not affect the underlying .ipynb content.

return {
	"OXY2DEV/markview.nvim",
	lazy = false, -- do not lazy-load
	ft = { "markdown", "quarto" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {},
}

-- Requires tree-sitter parsers: markdown, markdown_inline, latex
-- (already installed via plugins/treesitter.lua's :TSInstall list)
