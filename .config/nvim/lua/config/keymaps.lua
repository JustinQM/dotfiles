--Keymaps file:
--NOTE: This is for global vim specific keybinds. Plugins are expected to
--map their keybinds within their configuration file

local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

--map jk to escape and shorten timeout
map('i', 'jk', '<ESC>', opts)

--ash_script

vim.keymap.set({'n','v'}, 'g?/', '<Cmd>lua require("scripts.ash_encode").vim_encode()<CR>')

--map leader and localleader
vim.g.mapleader = " " 
vim.g.maplocalleader = "\\" 

--hotkey to close buffer
map('n', '<A-w>', '<Cmd>bd<CR>', opts)

