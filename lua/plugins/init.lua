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
    cmd = "Telescope",
    keys = {
      { "<leader>ff", function()
          require("telescope.builtin").find_files({
            hidden = false,
            file_ignore_patterns = {
              "node_modules",
              ".git",
              ".next",
              "dist",
              "build",
              "coverage",
              ".DS_Store",
              "*.log",
            }
          })
        end, desc = "Find files" },
      { "<leader>fg", function()
          require("telescope.builtin").live_grep({
            additional_args = function(args)
              return vim.tbl_extend("force", args, {
                "--glob",
                "!node_modules/**",
                "--glob",
                "!.git/**",
                "--glob",
                "!.next/**",
                "--glob",
                "!dist/**",
                "--glob",
                "!build/**",
                "--glob",
                "!coverage/**",
              })
            end
          })
        end, desc = "Live grep" },
      { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
      { "<leader>fh", function() require("telescope.builtin").help_tags() end, desc = "Help tags" },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSUpdate", "TSInstall" },
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file explorer", silent = true }
    },
    init = function()
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
    end,
    opts = {
      update_focused_file = {
        enable = true,
      },
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      }
    }
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
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
      event = { "BufReadPost", "BufNewFile" },
      opts = {},
    },

    {
      "akinsho/toggleterm.nvim",
      version = "*",
      opts = {
        open_mapping = [[<C-`>]],
        direction = "float",
        float_opts = {
          border = "rounded",
          width = function() return math.floor(vim.o.columns * 0.9) end,
          height = function() return math.floor(vim.o.lines * 0.8) end,
        },
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        close_on_exit = true,
        shell = vim.fn.executable("zsh") == 1 and "zsh" or "bash",
      },
      keys = {
        { "<C-`>", "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
        { "<C-\\>", "<Cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle horizontal terminal" },
      },
    },

    {
      "akinsho/toggleterm.nvim",
      version = "*",
      opts = {
        open_mapping = [[<C-`>]],
        direction = "float",
        float_opts = {
          border = "rounded",
          width = function() return math.floor(vim.o.columns * 0.9) end,
          height = function() return math.floor(vim.o.lines * 0.8) end,
        },
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        close_on_exit = true,
        shell = vim.fn.executable("zsh") == 1 and "zsh" or "bash",
      },
      keys = {
        { "<C-`>", "<Cmd>ToggleTerm<CR>", desc = "Toggle terminal" },
        { "<C-\\>", "<Cmd>ToggleTerm direction=horizontal<CR>", desc = "Toggle horizontal terminal" },
      },
    },

    {
      "romgrk/barbar.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      init = function()
        vim.g.barbar_auto_setup = false
      end,
      opts = {
        animation = true,
        insert_at_start = true,
        letters = "asdfjkl;ghzxcvbnmiaeoruqtwpcy",
        no_name_title = nil,
        sidebar_filetypes = {
          NvimTree = true,
          undotree = { text = "Undotree" },
          diff = { text = "Diff" },
          fugitive = { text = "Fugitive" },
          fugitiveblame = { text = "Blame" },
        },
        exclude_filetypes = {
          "netrw",
          "toggleterm",
        },
      },
      keys = {
        { "<C-Tab>", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
        { "<C-S-Tab>", "<Cmd>BufferPrevious<CR>", desc = "Previous buffer" },
        { "<C-w>", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
        { "<C-1>", "<Cmd>BufferGoto 1<CR>", desc = "Go to buffer 1" },
        { "<C-2>", "<Cmd>BufferGoto 2<CR>", desc = "Go to buffer 2" },
        { "<C-3>", "<Cmd>BufferGoto 3<CR>", desc = "Go to buffer 3" },
        { "<C-4>", "<Cmd>BufferGoto 4<CR>", desc = "Go to buffer 4" },
        { "<C-5>", "<Cmd>BufferGoto 5<CR>", desc = "Go to buffer 5" },
        { "<C-6>", "<Cmd>BufferGoto 6<CR>", desc = "Go to buffer 6" },
        { "<C-7>", "<Cmd>BufferGoto 7<CR>", desc = "Go to buffer 7" },
        { "<C-8>", "<Cmd>BufferGoto 8<CR>", desc = "Go to buffer 8" },
        { "<C-9>", "<Cmd>BufferGoto 9<CR>", desc = "Go to buffer 9" },
        { "<C-0>", "<Cmd>BufferLast<CR>", desc = "Go to last buffer" },
      },
    },

    {
      "romgrk/barbar.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      init = function()
        vim.g.barbar_auto_setup = false
      end,
      opts = {
        animation = true,
        insert_at_start = true,
        letters = "asdfjkl;ghzxcvbnmiaeoruqtwpcy",
        no_name_title = nil,
        sidebar_filetypes = {
          NvimTree = true,
          undotree = { text = "Undotree" },
          diff = { text = "Diff" },
          fugitive = { text = "Fugitive" },
          fugitiveblame = { text = "Blame" },
        },
        exclude_filetypes = {
          "netrw",
          "toggleterm",
        },
      },
      keys = {
        { "<C-Tab>", "<Cmd>BufferNext<CR>", desc = "Next buffer" },
        { "<C-S-Tab>", "<Cmd>BufferPrevious<CR>", desc = "Previous buffer" },
        { "<C-w>", "<Cmd>BufferClose<CR>", desc = "Close buffer" },
        { "<C-1>", "<Cmd>BufferGoto 1<CR>", desc = "Go to buffer 1" },
        { "<C-2>", "<Cmd>BufferGoto 2<CR>", desc = "Go to buffer 2" },
        { "<C-3>", "<Cmd>BufferGoto 3<CR>", desc = "Go to buffer 3" },
        { "<C-4>", "<Cmd>BufferGoto 4<CR>", desc = "Go to buffer 4" },
        { "<C-5>", "<Cmd>BufferGoto 5<CR>", desc = "Go to buffer 5" },
        { "<C-6>", "<Cmd>BufferGoto 6<CR>", desc = "Go to buffer 6" },
        { "<C-7>", "<Cmd>BufferGoto 7<CR>", desc = "Go to buffer 7" },
        { "<C-8>", "<Cmd>BufferGoto 8<CR>", desc = "Go to buffer 8" },
        { "<C-9>", "<Cmd>BufferGoto 9<CR>", desc = "Go to buffer 9" },
        { "<C-0>", "<Cmd>BufferLast<CR>", desc = "Go to last buffer" },
      },
    },

    {
      "folke/trouble.nvim",
      dependencies = {
        "nvim-tree/nvim-web-devicons",
      },
      cmd = { "Trouble" },
      keys = {
        { "<C-S-m>", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Toggle problems panel" },
        { "<leader>xx", "<Cmd>Trouble diagnostics toggle<CR>", desc = "Problems (all)" },
        { "<leader>xw", "<Cmd>Trouble workspace_diagnostics toggle<CR>", desc = "Workspace diagnostics" },
        { "<leader>xd", "<Cmd>Trouble document_diagnostics toggle<CR>", desc = "Document diagnostics" },
        { "<leader>xq", "<Cmd>Trouble quickfix toggle<CR>", desc = "Quickfix" },
        { "<leader>xl", "<Cmd>Trouble loclist toggle<CR>", desc = "Loclist" },
        { "gR", "<Cmd>Trouble lsp_references toggle<CR>", desc = "LSP references" },
      },
      opts = {
        mode = "diagnostics",
        action_keys = {
          open = { "<CR>", "o" },
          close = { "<C-q>", "q", "<Esc>" },
          cancel = "<Esc>",
          refresh = "r",
          jump = { "<CR>", "<C-o>", "o" },
          jump_close = { "e" },
        },
        indent_lines = true,
        auto_open = false,
        auto_close = false,
        auto_preview = true,
        auto_fold = false,
        auto_jump = { "first" },
        signs = {
          error = "✗",
          warning = "⚠",
          hint = "💡",
          information = "ℹ",
          other = "•",
        },
        use_diagnostic_signs = true,
      },
    },

    {
      "stevearc/conform.nvim",
      event = { "BufWritePre" },
      cmd = { "ConformInfo" },
      keys = {
        {
          "<leader>lf",
          function()
            require("conform").format({ async = true, lsp_format = "fallback" })
          end,
          mode = "",
          desc = "Format file",
        },
      },
      opts = {
        formatters_by_ft = {
          lua = { "stylua" },
          javascript = { "prettierd", "prettier", "biome" },
          typescript = { "prettierd", "prettier", "biome" },
          javascriptreact = { "prettierd", "prettier", "biome" },
          typescriptreact = { "prettierd", "prettier", "biome" },
          json = { "jq", "prettier" },
          yaml = { "yamlfmt" },
          markdown = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          sql = { "sqlfmt" },
          python = { "black", "ruff" },
          rust = { "rustfmt" },
          go = { "gofmt" },
          java = { "google-java-format" },
          c = { "clang-format" },
          cpp = { "clang-format" },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = "fallback",
        },
        format_after_save = {
          lsp_format = "fallback",
        },
        notify_on_error = true,
        default_format_opts = {
          async = false,
          quiet = false,
          lsp_format = "fallback",
        },
      },
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
    "yaml",
    "toml",
    "gitignore",
    "bash",
    "markdown",
    "markdown_inline",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
    disable = function(lang, buf)
      local max_filesize = 100 * 1024
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,
  },
  indent = { enable = true, disable = { "yaml" } },
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

local lspconfig = require("lspconfig")
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

vim.diagnostic.config({
  virtual_text = {
    source = "if_many",
    prefix = "●",
  },
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
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
      local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
        header = '',
        max_width = 80,
      }
      vim.diagnostic.open_float(nil, opts)
    end
  })

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

mason.setup()

mason_lspconfig.setup({
  ensure_installed = {
    "ts_ls",
    "lua_ls",
    "jsonls",
    "yamlls",
  },
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end,
    ["ts_ls"] = function()
      lspconfig.ts_ls.setup({
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
    end,
    ["lua_ls"] = function()
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
    end,
  },
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