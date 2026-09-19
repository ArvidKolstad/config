vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
vim.keymap.set("t", "<C-space>", "<C-\\><C-n><C-w>h", { silent = true })

vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame variable" }) --Create nice layout
vim.keymap.set("n", "<leader>gl", function()
	local buf = vim.api.nvim_get_current_buf()

	vim.cmd("vsplit")
	vim.cmd("wincmd h")

	vim.cmd("split")
	vim.cmd("wincmd j")

	vim.cmd("terminal")
	vim.api.nvim_win_set_height(0, 13)

	vim.cmd("wincmd k")
	vim.api.nvim_set_current_buf(buf)
end)

--Molten KEYBINDS
vim.keymap.set("n", "<localleader>e", ":MoltenEvaluateOperator<CR>", { desc = "evaluate operator", silent = true })
vim.keymap.set(
	"n",
	"<localleader>os",
	":noautocmd MoltenEnterOutput<CR>",
	{ desc = "open output window", silent = true }
)
vim.keymap.set("n", "<localleader>rr", ":MoltenReevaluateCell<CR>", { desc = "re-eval cell", silent = true })
vim.keymap.set(
	"v",
	"<localleader>r",
	":<C-u>MoltenEvaluateVisual<CR>gv",
	{ desc = "execute visual selection", silent = true }
)
vim.keymap.set("n", "<localleader>oh", ":MoltenHideOutput<CR>", { desc = "close output window", silent = true })
vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "delete Molten cell", silent = true })

vim.keymap.set("n", "<localleader>ip", function()
	local venv = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX")
	if venv ~= nil then
		-- in the form of /home/benlubas/.virtualenvs/VENV_NAME
		venv = string.match(venv, "/.+/(.+)")
		vim.cmd(("MoltenInit %s"):format(venv))
	else
		vim.cmd("MoltenInit python3")
	end
end, { desc = "Initialize Molten for python3", silent = true })
