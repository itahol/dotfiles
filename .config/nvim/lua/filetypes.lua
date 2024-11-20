vim.filetype.add {
  extension = {
    kbd = 'kanata',
  },
}

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'kanata',
  callback = function()
    vim.opt_local.commentstring = ';; %s'
  end,
})
