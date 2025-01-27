return {
  -- Cmp
  { "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/vim-vsnip",
      "rafamadriz/friendly-snippets",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "onsails/lspkind.nvim",
      "neovim/nvim-lspconfig",
    },
    config = function()
      -- Completion settings
      local lspkind = require("lspkind")
      local cmp = require("cmp")

      require("cmp").setup({
        -- Completion settings
        snippet = {
          expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp" },
          { name = "nvim_lsp_signature_help" },
          { name = "buffer" },
          { name = "path" },
          -- { name = "cody" },
        },
        mapping = cmp.mapping.preset.insert({
          ["<TAB>"] = cmp.mapping.select_next_item(),
          ["<S-TAB>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-k>"] = cmp.mapping.complete({
            config = {
              sources = {
                { name = "vsnip" },
              },
            },
          }),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping({
            i = function(fallback)
              if cmp.visible() and cmp.get_active_entry() then
                cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
              else
                fallback()
              end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = function(fallback)
              if cmp.visible() then
                cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", false)
              else
                fallback()
              end
            end,
          }),
          ["<C-d>"] = cmp.mapping.scroll_docs(6),
          ["<C-u>"] = cmp.mapping.scroll_docs(-6),
        }),
        experimental = {
          ghost_text = false,
        },

        -- Appearance settings
        view = {
          docs = {
            auto_open = true,
          },
        },
        window = {
          completion = {
            border = "rounded",
            scrollbar = true,
            winblend = 10,
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
          },
          documentation = {
            border = "rounded",
            winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
            winblend = 10,
          },
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = {
              manu = 50,
              abbr = 50,
            },
            ellipsis_char = "...",
            show_labelDetails = true,
            symbol_map = { Cody = "❄" },
          }),
        },
      })
      cmp.setup.cmdline("/", {
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
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })

      -- LSP handlers
      vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })
    end
  },
  -- Mason
  {
    "williamboman/mason.nvim",
    dependencies = {
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("mason").setup()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "pyright",
          "yamlls",
          "jsonls",
          "lua_ls",
          "ruff",
          "shfmt",
          "shellcheck",
          "stylua",
          "prettierd",
          "prettier",
        },
      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
          })
        end,
      })
      require("lspconfig").lua_ls.setup({
        settings = {
          Lua = {
            -- Disable global vim warning
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      require("lspconfig").pyright.setup({
        -- Disable hint level diagnostics
        capabilities = {
          textDocument = {
            publishDiagnostics = {
              tagSupport = {
                valueSet = { 2 },
              },
            },
          },
        },
      })
    end,
  },
  -- Cool LSP UI
  {
    "nvimdev/lspsaga.nvim",
    after = "nvim-lspconfig",
    config = function()
      require("lspsaga").setup({
        lightbulb = {
          enable = false,
        },
        symbol_in_winbar = {
          enable = false,
        },
        scroll_preview = {
          scroll_down = "<C-d>",
          scroll_up = "<C-u>",
        },
        ui = {
          border = "rounded",
          title = true,
        },
      })

      -- LSP key mapping settings
      vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
      vim.keymap.set("n", "<Space>d", "<cmd>lua vim.lsp.buf.definition()<CR>")
      vim.keymap.set("n", "<Space>r", "<cmd>Lspsaga rename<CR>")
      vim.keymap.set("n", "<Space>t", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
      vim.keymap.set("n", "<Space>a", "<cmd>Lspsaga code_action<CR>")
      vim.keymap.set("n", "<Space>]", "<cmd>Lspsaga diagnostic_jump_next<CR>")
      vim.keymap.set("n", "<Space>[", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      vim.keymap.set("n", "<Space>f", "<cmd>Format<CR>")

      -- Show diagnostic on hover
      local function on_cursor_hold()
        vim.cmd("Lspsaga show_line_diagnostics ++unfocus")
      end
      local diagnostic_hover_augroup = vim.api.nvim_create_augroup("lspconfig-diagnostic", { clear = true })
      vim.api.nvim_create_autocmd("LspAttach", {
        group = diagnostic_hover_augroup,
        callback = function(args)
          local bufnr = args.buf
          vim.api.nvim_create_autocmd("CursorHold", {
            group = diagnostic_hover_augroup,
            buffer = bufnr,
            callback = on_cursor_hold,
          })
        end,
      })
    end,
  },
  -- Formmater
  {
    "stevearc/conform.nvim",
    config = function()
      require("conform").setup({
        formatters = {
          shfmt = {
            inherit = false,
            command = "shfmt",
            args = { "-i", "4", "-ci", "-sr", "-fn", "-filename", "$FILENAME" },
          },
          stylua = {
            prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
          },
        },
        formatters_by_ft = {
          lua = { "stylua" },
          -- Conform will run multiple formatters sequentially
          python = function(bufnr)
            if require("conform").get_formatter_info("ruff_format", bufnr).available then
              return { "ruff_format", "ruff_fix", "ruff_organize_imports" }
            else
              return { "isort", "black" }
            end
          end,
          sh = { "shfmt" },
          -- Conform will run the first available formatter
          javascript = { "prettierd", "prettier", stop_after_first = true },
        },
      })
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        require("conform").format({ async = true, lsp_format = "fallback", range = range })
      end, { range = true })
    end,
  },

  {
    "github/copilot.vim",
    event = { "InsertEnter" },
    init = function()
      vim.g.copilot_no_tab_map = true
      vim.api.nvim_set_keymap("i", "<c-]>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
    end,
  },
  -- {
  -- 	"sourcegraph/sg.nvim",
  -- 	config = function()
  -- 		require("sg").setup()
  -- 	end,
  -- },
}
