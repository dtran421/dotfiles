-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Save file and quit
keymap.set("n", "<Leader>w", ":update<Return>", opts)
keymap.set("n", "<Leader>q", ":quit<Return>", opts)
keymap.set("n", "<Leader>Q", ":qa<Return>", opts)

-- Tab management
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
keymap.set("n", "tw", ":tabclose<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "<C-S-h>", "<C-w><")
keymap.set("n", "<C-S-l>", "<C-w>>")
keymap.set("n", "<C-S-k>", "<C-w>+")
keymap.set("n", "<C-S-j>", "<C-w>-")

-- Move selection up/down
keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Move next line up to current
keymap.set("n", "J", "mzJ`z")

-- Page movement
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")

-- Search movement
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

-- paste without copying deleted into buffer?
keymap.set("x", "<leader>p", [["_dP]])

-- Copy selection into local clipboard
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
-- Copy entire line into local clipboard
keymap.set("n", "<leader>Y", [["+Y]])

keymap.set("i", "jk", "<Esc>")
keymap.set("i", "<C-c>", "<Esc>")

-- tmux
keymap.set("n", "<C-h>", "<cmd>TmuxNavigateLeft<CR>")
keymap.set("n", "<C-l>", "<cmd>TmuxNavigateRight<CR>")
keymap.set("n", "<C-j>", "<cmd>TmuxNavigateDown<CR>")
keymap.set("n", "<C-k>", "<cmd>TmuxNavigateUp<CR>")

-- Find and replace all
keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make current file executable
keymap.set("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true })
