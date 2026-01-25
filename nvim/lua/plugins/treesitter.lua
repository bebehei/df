return {
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate',
  cond = function()
    return vim.fn.executable 'tree-sitter' == 1
  end,
  config = function()
    require("config.treesitter")
  end,
}
