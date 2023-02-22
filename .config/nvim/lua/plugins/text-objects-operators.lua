-- This file contains plugin configuration for two different (but related) types
-- of plugins:
-- 1) Plugins that create "text objects," which provide targets for various
--    operators
-- 2) Plugins that add or modify operators, which perform operations against
--    text objects/selections
return {
  -- allows for splitting and joining multiline statements
  'AndrewRadev/splitjoin.vim',

  --improves on matchit, adding a lot of text objects and some logic.
  'andymass/vim-matchup',

  -- provide a shortcut for sorting text in a motion/textobj
  'christoomey/vim-sort-motion',

  -- provide text objects for comments
  {
    'glts/vim-textobj-comment',
    dependencies = { 'kana/vim-textobj-user' }
  },

  -- provide text objects for indents
  {
    'kana/vim-textobj-indent',
    dependencies = { 'kana/vim-textobj-user' }
  },

  -- provide text objects for lines
  {
    'kana/vim-textobj-line',
    dependencies = { 'kana/vim-textobj-user' }
  },

  -- Provide operators for commenting code.
  'tpope/vim-commentary',

  -- Allow custom commands to be repeated
  'tpope/vim-repeat',

  -- Enables operators for manipulating surrounding punctuations
  'tpope/vim-surround',

  -- allow for a broader range of text objects
  'wellle/targets.vim',

}
