return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    {
      'rose-pine/neovim',
      name = 'rose-pine',
      opts = { dark_variant = 'moon', dim_inactive_windows = true },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
