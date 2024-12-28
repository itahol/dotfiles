return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    -- init = function()
    --   vim.cmd.colorscheme 'catppuccin'
    -- end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    opts = { dim_inactive_windows = true },
    init = function()
      vim.cmd.colorscheme 'rose-pine'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
