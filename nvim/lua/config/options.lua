vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4 -- Gör att en tabb (\t) bara visas som 4 tecken bred i stället för 8
vim.opt.shiftwidth = 4 -- Storleken på ett indrag
vim.opt.expandtab = true -- Omvandlar tabbar till mellanslag när du själv trycker på Tab
vim.opt.clipboard:append("unnamedplus")

vim.opt.mouse = ""

--venvfinder
local function find_venv()
	local cwd = vim.fn.getcwd()
	-- Look for .venv in current dir or up to 4 levels up
	local venv = vim.fn.finddir(".venv", cwd .. ";")
	if venv ~= "" then
		return vim.fn.fnamemodify(venv, ":p")
	end
	return nil
end

local venv_path = find_venv()

if venv_path then
	-- Set the environment variables globally for Neovim
	vim.env.VIRTUAL_ENV = venv_path
	if vim.fn.has("win32") == 1 then
		vim.env.PATH = venv_path .. "Scripts;" .. vim.env.PATH
	else
		vim.env.PATH = venv_path .. "bin:" .. vim.env.PATH
	end
end

vim.g.clipboard = {
	name = "wl-clipboard",
	copy = {
		["+"] = "wl-copy --type text/plain",
		["*"] = "wl-copy --primary --type text/plain",
	},
	paste = {
		["+"] = "wl-paste --no-newline --type text/plain",
		["*"] = "wl-paste --no-newline --primary --type text/plain",
	},
	cache_enabled = 0,
}
