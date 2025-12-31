local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "jk", "<ESC>", opts)
keymap.set("i", "JK", "<ESC>", opts)

keymap.set("n", "<C-s>", ":w<CR>", opts)
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", opts)

keymap.set("n", "<leader>w", ":w<CR>", opts)
keymap.set("n", "<leader>q", ":q<CR>", opts)
keymap.set("n", "<leader>Q", ":qa!<CR>", opts)
keymap.set("n", "<leader>x", ":x<CR>", opts)

keymap.set("n", "<C-p>", function()
  require("telescope.builtin").find_files({
    hidden = false,
    file_ignore_patterns = {
      "node_modules",
      ".git",
      ".next",
      "dist",
      "build",
      "coverage",
      ".DS_Store",
      "*.log",
    }
  })
end, opts)

keymap.set("n", "<C-S-p>", function()
  require("telescope.builtin").commands()
end, opts)

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

keymap.set("n", "<C-_>", function() require("Comment.api").toggle.linewise.current() end, opts)
keymap.set("v", "<C-_>", function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, opts)
keymap.set("i", "<C-_>", function() require("Comment.api").toggle.linewise.current() end, opts)

keymap.set("n", "<leader>d", '"_d', opts)
keymap.set("v", "<leader>d", '"_d', opts)

keymap.set("n", "<C-Tab>", ":BufferNext<CR>", opts)
keymap.set("n", "<C-S-Tab>", ":BufferPrevious<CR>", opts)
keymap.set("n", "<C-w>", ":BufferClose<CR>", opts)
keymap.set("i", "<C-Tab>", "<Esc>:BufferNext<CR>a", opts)
keymap.set("i", "<C-S-Tab>", "<Esc>:BufferPrevious<CR>a", opts)

keymap.set("n", "<C-down>", ":m .+1<CR>==", opts)
keymap.set("n", "<C-up>", ":m .-2<CR>==", opts)
keymap.set("i", "<C-down>", "<Esc>:m .+1<CR>==gi", opts)
keymap.set("i", "<C-up>", "<Esc>:m .-2<CR>==gi", opts)
keymap.set("v", "<C-down>", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<C-up>", ":m '<-2<CR>gv=gv", opts)

keymap.set("n", "<C-b>", ":NvimTreeToggle<CR>", opts)
keymap.set("n", "<C-S-b>", ":NvimTreeFocus<CR>", opts)