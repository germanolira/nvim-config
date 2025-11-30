local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "jk", "<ESC>", opts)
keymap.set("i", "JK", "<ESC>", opts)

keymap.set("n", "<leader>w", ":w<CR>", opts)
keymap.set("n", "<leader>q", ":q<CR>", opts)
keymap.set("n", "<leader>Q", ":qa!<CR>", opts)
keymap.set("n", "<leader>x", ":x<CR>", opts)

keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

keymap.set("n", "<leader>v", "<C-w>v", opts)
keymap.set("n", "<leader>s", "<C-w>s", opts)
keymap.set("n", "<leader>=", "<C-w>=", opts)

keymap.set("n", "<leader>h", ":nohlsearch<CR>", opts)

keymap.set("n", "<leader>+", "<C-a>", opts)
keymap.set("n", "<leader>-", "<C-x>", opts)

keymap.set("n", "<C-u>", "<C-u>zz", opts)
keymap.set("n", "<C-d>", "<C-d>zz", opts)
keymap.set("n", "n", "nzz", opts)
keymap.set("n", "N", "Nzz", opts)

keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

keymap.set("x", "<leader>p", '"_dP', opts)

keymap.set("n", "<leader>y", '"+y', opts)
keymap.set("v", "<leader>y", '"+y', opts)
keymap.set("n", "<leader>Y", '"+Y', opts)

keymap.set("n", "<leader>d", '"_d', opts)
keymap.set("v", "<leader>d", '"_d', opts)
