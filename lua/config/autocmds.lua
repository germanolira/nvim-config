vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({
      bufnr = args.buf,
      async = false,
      lsp_format = "fallback",
    })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt.buflisted = false
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.opt.showtabline = 2
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.bo.filetype == "TelescopePrompt" then
      vim.opt.winblend = 0
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "NvimTree", "trouble", "toggleterm" },
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})
