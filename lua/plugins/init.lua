local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })
    end,
  },

  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { silent = true })
    end,
  },

  { "lewis6991/gitsigns.nvim" },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },

  { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },

  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    opts = {},
  },
})

vim.cmd.colorscheme("catppuccin")

require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "javascript",
    "typescript",
    "tsx",
    "lua",
    "json",
    "jsonc",
    "yaml",
    "toml",
    "gitignore",
    "bash",
    "markdown",
    "markdown_inline",
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})

require("lualine").setup({
  options = {
    theme = "catppuccin",
    section_separators = { left = "", right = "" },
    component_separators = { left = "│", right = "│" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})

require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

require("gitsigns").setup({
  signs = {
    add = { text = "+" },
    change = { text = "~" },
    delete = { text = "_" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", { desc = "Stage hunk" })
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", { desc = "Reset hunk" })
    map("n", "<leader>hS", gs.stage_buffer, { desc = "Stage buffer" })
    map("n", "<leader>hu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
    map("n", "<leader>hR", gs.reset_buffer, { desc = "Reset buffer" })
    map("n", "<leader>hp", gs.preview_hunk, { desc = "Preview hunk" })
    map("n", "<leader>hb", function()
      gs.blame_line({ full = true })
    end, { desc = "Blame line" })
  end,
})

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "tsserver",
    "lua_ls",
    "jsonls",
    "yamlls",
  },
})

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

local signs = { Error = "✗", Warn = "⚠", Hint = "💡", Info = "ℹ" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local on_attach = function(_, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, bufopts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, bufopts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
  vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)
end

lspconfig.tsserver.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    typescript = {
      format = {
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterSemicolonInForStatements = true,
        insertSpaceBeforeAndAfterBinaryOperators = true,
        insertSpaceAfterConstructor = false,
        insertSpaceAfterKeywordsInControlFlowStatements = true,
        insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
        insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
        insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
        insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
        insertSpaceAfterTypeAssertion = false,
        placeOpenBraceOnNewLineForFunctions = false,
        placeOpenBraceOnNewLineForControlBlocks = false,
      },
    },
    javascript = {
      format = {
        insertSpaceAfterCommaDelimiter = true,
        insertSpaceAfterSemicolonInForStatements = true,
        insertSpaceBeforeAndAfterBinaryOperators = true,
        insertSpaceAfterConstructor = false,
        insertSpaceAfterKeywordsInControlFlowStatements = true,
        insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
        insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
        insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
        insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
        insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
        insertSpaceAfterTypeAssertion = false,
        placeOpenBraceOnNewLineForFunctions = false,
        placeOpenBraceOnNewLineForControlBlocks = false,
      },
    },
  },
})

lspconfig.lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.jsonls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

lspconfig.yamlls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})

cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})
