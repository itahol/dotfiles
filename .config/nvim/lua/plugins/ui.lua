return {
  {
    'echasnovski/mini.statusline',
    version = false,
    opts = { use_icons = vim.g.have_nerd_font },
    dependencies = { { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font } },
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false,
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true, -- add a border to hover docs and signature help
      },
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    keys = {
      -- Dismiss notifications
      { '<leader><Tab>', '<cmd>lua require("notify").dismiss()<cr>', desc = 'Dismiss notifications' },
    },
  },
}
