-- Trim whitespace on save
return {
  'ropez/trim.nvim',
  opts = {
    ft_blocklist = {
      'diff',
    },
    trim_first_line = false,
    trim_last_line = false,
  }
}
