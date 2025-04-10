return {
  -- Cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "neovim/nvim-lspconfig",
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-vsnip",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "hrsh7th/vim-vsnip",
      "rafamadriz/friendly-snippets",
    },
    event = { "InsertEnter" },
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
    end,
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
    event = { "InsertEnter" },
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
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "off",
              diagnosticMode = "openFilesOnly",
            },
          },
        },
      })
    end,
  },
  -- Cool LSP UI
  {
    "nvimdev/lspsaga.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    event = { "InsertEnter" },
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
      vim.keymap.set("n", "<Space>r", "<cmd>Lspsaga rename<CR>")
      vim.keymap.set("n", "<Space>a", "<cmd>Lspsaga code_action<CR>")
      vim.keymap.set("n", "<Space>]", "<cmd>Lspsaga diagnostic_jump_next<CR>")
      vim.keymap.set("n", "<Space>[", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
      vim.keymap.set("n", "<Space>t", "<cmd>Lspsaga goto_type_definition<CR>")
      vim.keymap.set("n", "<Space>d", "<cmd>Lspsaga goto_definition<CR>")
    end,
  },
  -- Formmater
  {
    "stevearc/conform.nvim",
    event = { "InsertEnter" },
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

      -- Key mapping
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

      vim.keymap.set("n", "<Space>f", "<cmd>Format<CR>")
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
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
    opts = {
      -- add any opts here
      -- for example
      -- provider = "openai",
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- timeout in milliseconds
      --   temperature = 0, -- adjust if needed
      --   max_tokens = 4096,
      -- },
      provider = "copilot",
      auto_suggestions_provider = "copilot",
      windows = {
        position = "right",
        width = 30,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
        edit = {
          start_insert = false,
        },
        ask = {
          floating = true,
          start_insert = false,
          border = "rounded",
        },
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      -- "echasnovski/mini.pick", -- for file_selector provider mini.pick
      -- "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      -- "ibhagwan/fzf-lua", -- for file_selector provider fzf
      -- "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
