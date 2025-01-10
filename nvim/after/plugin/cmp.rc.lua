-- LSP key mapping settings
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
vim.keymap.set("n", "<Space>d", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<Space>r", "<cmd>Lspsaga rename<CR>")
vim.keymap.set("n", "<Space>t", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
-- vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
-- vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
-- vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set("n", "<Space>a", "<cmd>Lspsaga code_action<CR>")
vim.keymap.set("n", "<Space>]", "<cmd>Lspsaga diagnostic_jump_next<CR>")
vim.keymap.set("n", "<Space>[", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
vim.keymap.set("n", "<Space>f", "<cmd>Format<CR>")

-- Sign definition
vim.fn.sign_define("DiagnosticSignError", { text = "" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "" })
vim.fn.sign_define("DiagnosticSignHint", { text = "" })

-- Remove default virtual_text
vim.diagnostic.config({
  virtual_text = false,
})

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

-- LSP handlers
vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false })

-- Completion settings
local lspkind = require("lspkind")
local cmp = require("cmp")

cmp.setup({
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
      winblend = 5,
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
    },
    documentation = {
      border = "rounded",
      winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,Search:None",
      winblend = 5,
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
