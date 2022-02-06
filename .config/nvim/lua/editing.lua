require('config')

-- sane tab defaults
config.option('softtabstop', 2)
config.option('tabstop', 2)
config.option('shiftwidth', 2)
config.option('expandtab', true)

-- don't wrap in the middle of a word
config.option('linebreak', true)
-- 80-char line length
config.option('textwidth', 80)

-- format options, see help fo-table
config.option('formatoptions', 'tcqnbl1j')

-- automatically restore the cursor position when reopening a file, if possible.
vim.cmd [[autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \ exe "normal! g`\"" |
  \ endif]]
