-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("config") .. "/lua/lazy"
if not vim.loop.fs_stat(lazypath) then
  -- Submodule should exist, but fail gracefully
  vim.notify("lazy.nvim submodule not found!", vim.log.levels.ERROR)
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- automatically check for plugin updates
  checker = { enabled = true },
  -- disable luarocks
  rocks = { enabled = false },
})
