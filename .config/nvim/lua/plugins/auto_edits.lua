-- This file contains configuration information for plugins that perform
-- automatic edits (or other operations like ctags generation) based on context. Programmer's little helpers.
return {
  -- keep HTML tags in sync
  'AndrewRadev/tagalong.vim',

  -- autogenerate tagfiles
  'ludovicchabant/vim-gutentags',

  -- Automatically add 'end' statements as appropriate
  'tpope/vim-endwise',

  -- ruby auto-formatter
  {
    'ruby-formatter/rufo-vim',
    config = function()
      vim.g.rufo_auto_formatting = 1
    end,
  },

}
