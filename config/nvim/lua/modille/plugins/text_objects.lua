return {
  {
    'kana/vim-textobj-user',
    dependencies = {
      'kana/vim-textobj-function',
      'Julian/vim-textobj-variable-segment',
      'glts/vim-textobj-comment',
      'haya14busa/vim-textobj-function-syntax',
    },
  },
  { 'michaeljsmith/vim-indent-object' },
  { 'nelstrom/vim-textobj-rubyblock', ft = 'ruby' },
  { 'vim-scripts/argtextobj.vim' },
}
