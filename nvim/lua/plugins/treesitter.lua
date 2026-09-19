-- parsing on any filetype anymore -- it must be started explicitly per buffer.

return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		-- Make sure these are installed (safe to re-run; skips what's already there):
		-- :TSInstall markdown markdown_inline python latex

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(args)
				local ft = args.match
				local lang = vim.treesitter.language.get_lang(ft) or ft

				-- skip filetypes with no real parser (Telescope prompt, etc.) quietly
				if not pcall(vim.treesitter.language.add, lang) then
					return
				end

				local ok = pcall(vim.treesitter.start)
				if ok then
					vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
					vim.wo[0][0].foldmethod = "expr"
					vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}
