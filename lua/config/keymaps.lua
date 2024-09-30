local keymap = vim.keymap
local opts = {noremap = true, silent = true}

-- Directory Navigation
keymap.set("n", "<leader>m", ":NvimTreeFocus<CR>", opts)
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- General
keymap.set("n", "<leader>s", ":w<CR>", opts)
keymap.set("n", "<leader>x", ":x<CR>", opts)
keymap.set("n", "<leader>t", ":term<CR>", opts)

-- Pane Navigation
keymap.set("n", "<C-h>", "<C-w>h", opts) -- Navigate Left
keymap.set("n", "<C-j>", "<C-w>j", opts) -- Navigate Down
keymap.set("n", "<C-k>", "<C-w>k", opts) -- Navigate Up
keymap.set("n", "<C-l>", "<C-w>l", opts) -- Navigate Right

-- Window Management
keymap.set("n", "<leader>sv", ":vsplit<CR>", opts) -- split vertically
keymap.set("n", "<leader>sh", ":split<CR>", opts) -- split horizontally
keymap.set("n", "<leader>bn", ":bn<CR>", opts) -- Buffer Next
keymap.set("n", "<leader>bp", ":bp<CR>", opts) -- Buffer Previous

-- Comments
vim.api.nvim_set_keymap("n", "<C-_>", "gcc", {noremap = false})
vim.api.nvim_set_keymap("v", "<C-_>", "gcc", {noremap = false})

-- Select and Yank
keymap.set("n", "vv", ":%y+<CR>", opts) -- Copy all text in documment MY CONFIG
