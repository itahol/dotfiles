if vim.g.vscode then
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  -- remap leader key
  -- keymap("n", "<Space>", "", opts)
  -- vim.g.mapleader = " "
  -- vim.g.maplocalleader = " "

  vim.api.nvim_set_option("clipboard","unnamed")

  -- yank to system clipboard
  -- keymap({"n", "v"}, "<leader>y", '"+y', opts)

  -- paste from system clipboard
  -- keymap({"n", "v"}, "<leader>p", '"+p', opts)

  -- better indent handling
  keymap("v", "<", "<gv", opts)
  keymap("v", ">", ">gv", opts)

  -- move text up and down
  keymap("v", "J", ":m .+1<CR>==", opts)
  keymap("v", "K", ":m .-2<CR>==", opts)
  keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
  keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

  -- keymap("n", "H", ":tabprev", opts)
  -- keymap("n", "L", ":tabnext", opts)

  -- paste preserves primal yanked piece
  keymap("v", "p", '"_dP', opts)

  -- removes highlighting after escaping vim search
  keymap("n", "<Esc>", "<Esc>:noh<CR>", opts)
  vim.cmd[[source $HOME/.config/vscode.neovim/settings.vim]]
end
