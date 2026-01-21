return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VeryLazy",
  opts = {
    options = {
      mode = "buffers", -- show buffers, not tabs
      numbers = "none",
      diagnostics = "nvim_lsp",
      separator_style = "slant",
      sort_by = "insert_after_current",
      show_buffer_close_icons = true,
      show_close_icon = false,
      always_show_bufferline = true,
      offsets = {
        {
          filetype = "NvimTree",
          text = "File Explorer",
          highlight = "Directory",
          separator = true,
        },
      },
    },
  },
}
