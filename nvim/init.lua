require("config.lazy")

-- old vim config
vim.opt.number = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

-- Automatically create directories when writing to files with non-existent dirs
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
  callback = function(event)
    -- Skip URIs like scp://, oil://, etc.
    if event.match:match("://") then
      return
    end

    local dir = vim.fn.fnamemodify(event.match, ":p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})
