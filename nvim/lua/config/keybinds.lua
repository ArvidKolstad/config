vim.g.mapleader = " "
    vim.g.maplocalleader = " "

    vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)
    vim.keymap.set('t', '<C-space>', "<C-\\><C-n><C-w>h", { silent = true })

    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = 'LSP: [R]e[n]ame variable' })


    vim.keymap.set('n', '<leader>gl', function()
  local buf = vim.api.nvim_get_current_buf()
  vim.cmd('vsplit')                     -- split into left and right
  vim.cmd('wincmd h')                   -- go to left window
  vim.cmd('split')                      -- split left window horizontally
  vim.cmd('terminal')                   -- terminal in bottom-left
  vim.cmd('resize 10')                  -- shrink terminal
  vim.cmd('wincmd k')                   -- go to top-left editor
  vim.api.nvim_set_current_buf(buf)     -- restore original file there
end)

vim.keymap.set('n', '<leader>gl', function()
  local buf = vim.api.nvim_get_current_buf()

  vim.cmd('vsplit')
  vim.cmd('wincmd h') 

  vim.cmd('split')
  vim.cmd('wincmd j')  

  vim.cmd('terminal')
  vim.api.nvim_win_set_height(0, 13)  

  vim.cmd('wincmd k')
  vim.api.nvim_set_current_buf(buf)
end)
