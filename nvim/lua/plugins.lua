local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use { 'wbthomason/packer.nvim' }

  -- Unitility for plugins
  use { 'MunifTanjim/nui.nvim' }
  use({ 'nvim-lua/plenary.nvim' })
  use({ 'nvim-tree/nvim-web-devicons' })

  -- ColorScheme
  use({ 'rktjmp/lush.nvim' })
  use({
    'kan-bayashi/nvim-jellybeans',
    requires = { 'rktjmp/lush.nvim' },
  })

  -- Apperaence {{{
  use({
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true },
    config = function()
      require('lualine').setup({
        options = {
          theme = 'jellybeans',
        },
        sections = {
          lualine_b = {
            { 'branch' },
            { 'diff' },
            {
              'diagnostics',
              symbols = { error = ' ', warn = ' ', info = ' ', hint = ' ' },
            }
          },
          lualine_c = {
            {
              'filename',
              path = 1,
              newfile_status = true,
              shorting_target = 24,
              symbols = { modified = '_󰷥', readonly = ' ', newfile = '󰄛' },
            }
          },
        },
        tabline = {},
      })
    end,
  })
  use({
    'akinsho/bufferline.nvim',
    tag = "*",
    requires = 'nvim-tree/nvim-web-devicons',
    config = function()
      require('bufferline').setup({
        options = {
          mode = 'tabs',
          numbers = 'none',
          diagnostics = 'coc',
          show_buffer_close_icons = false,
          show_close_icon = false,
          show_tab_indicators = true,
          separator_style = 'thick',
          always_show_bufferline = true,
          sort_by = 'id',
        },
      })
      vim.api.nvim_set_keymap("n", "tl", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
      vim.api.nvim_set_keymap("n", "th", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
    end,
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append "eol:↴"
      require("indent_blankline").setup {
        show_end_of_line = true,
      }
    end
  })
  use({
    'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      local dashboard = require('alpha.themes.dashboard')
      dashboard.section.header.val = {
        [[                                                          ]],
        [[                                                          ]],
        [[  ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗  ]],
        [[  ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║  ]],
        [[  ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║  ]],
        [[  ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║  ]],
        [[  ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║  ]],
        [[  ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝  ]],
        [[                                                          ]],
      }
      require('alpha').setup(dashboard.config)
    end
  })
  use {
    'kevinhwang91/nvim-hlslens',
    requires = "petertriho/nvim-scrollbar",
    config = function()
      require('hlslens').setup({
        override_lens = function(render, posList, nearest, idx, relIdx)
          local sfw = vim.v.searchforward == 1
          local indicator, text, chunks
          local absRelIdx = math.abs(relIdx)
          if absRelIdx > 1 then
            indicator = ('%d%s'):format(absRelIdx, sfw ~= (relIdx > 1) and '▲' or '▼')
          elseif absRelIdx == 1 then
            indicator = sfw ~= (relIdx == 1) and '▲' or '▼'
          else
            indicator = ''
          end

          local lnum, col = table.unpack(posList[idx])
          if nearest then
            local cnt = #posList
            if indicator ~= '' then
              text = ('[%s %d/%d]'):format(indicator, idx, cnt)
            else
              text = ('[%d/%d]'):format(idx, cnt)
            end
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLensNear' } }
          else
            text = ('[%s %d]'):format(indicator, idx)
            chunks = { { ' ', 'Ignore' }, { text, 'HlSearchLens' } }
          end
          render.setVirt(0, lnum - 1, col - 1, chunks, nearest)
        end
      })
      require("scrollbar.handlers.search").setup()

      local kopts = { noremap = true, silent = true }

      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>zz]],
        kopts)
      vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
      vim.api.nvim_set_keymap('n', '<Esc><Esc>', '<Cmd>noh<CR>', kopts)
    end
  }
  use {
    'lewis6991/gitsigns.nvim',
    requires = "petertriho/nvim-scrollbar",
    config = function()
      require('gitsigns').setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
          end, { expr = true })

          -- Actions
          map('n', '<leader>ha', gs.stage_hunk)
          map('n', '<leader>hu', gs.reset_hunk)

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end
      })
      require("scrollbar.handlers.gitsigns").setup()
    end
  }
  use {
    "petertriho/nvim-scrollbar",
    config = function()
      require("scrollbar").setup()
    end
  }
  -- }}}

  -- LSP {{{
  use({ 'honza/vim-snippets' })
  use({
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsExpandTrigger = '<Nop>'
    end
  })
  use({
    "neoclide/coc.nvim",
    branch = "release",
    config = function() --  {{{
      vim.g.coc_global_extensions = {
        'coc-json',
        'coc-pyright',
        'coc-diagnostic',
        'coc-word',
        'coc-syntax',
        'coc-snippets',
        'coc-yaml',
        'coc-toml',
        'coc-tsserver',
        'coc-prettier',
      }

      local keyset = vim.keymap.set
      -- Autocomplete
      function _G.check_back_space()
        local col = vim.fn.col('.') - 1
        return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
      end

      -- Use Tab for trigger completion with characters ahead and navigate
      -- NOTE: There's always a completion item selected by default, you may want to enable
      -- no select by setting `"suggest.noselect": true` in your configuration file
      -- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
      -- other plugins before putting this into your config
      local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
      keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
        opts)
      keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

      -- Make <CR> to accept selected completion item or notify coc.nvim to format
      -- <C-g>u breaks current undo, please make your own choice
      keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

      -- Use <c-j> to trigger snippets
      keyset("i", "<C-k>", "<Plug>(coc-snippets-expand-jump)")
      vim.g.coc_snippet_next = '<C-n>'
      vim.g.coc_snippet_prev = '<C-p>'

      -- Use `[g` and `]g` to navigate diagnostics
      -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
      keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
      keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

      -- GoTo code navigation
      keyset("n", "<leader>d", "<Plug>(coc-definition)", { silent = true })

      -- Use K to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end

      keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', { silent = true })

      -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
      })

      -- Symbol renaming
      keyset("n", "<leader>r", "<Plug>(coc-rename)", { silent = true })

      -- Setup formatexpr specified filetype(s)
      vim.api.nvim_create_autocmd("FileType", {
        group = "CocGroup",
        pattern = "typescript,json",
        command = "setl formatexpr=CocAction('formatSelected')",
        desc = "Setup formatexpr specified filetype(s)."
      })

      -- Update signature help on jump placeholder
      vim.api.nvim_create_autocmd("User", {
        group = "CocGroup",
        pattern = "CocJumpPlaceholder",
        command = "call CocActionAsync('showSignatureHelp')",
        desc = "Update signature help on jump placeholder"
      })

      -- Remap <C-d> and <C-u> to scroll float windows/popups
      ---@diagnostic disable-next-line: redefined-local
      local opts = { silent = true, nowait = true, expr = true }
      keyset("n", "<C-d>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset("n", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
      keyset("i", "<C-d>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
      keyset("i", "<C-u>",
        'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
      keyset("v", "<C-d>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
      keyset("v", "<C-u>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

      -- Add `:Format` command to format current buffer
      vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

      -- " Add `:Fold` command to fold current buffer
      vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = '?' })

      -- Add `:OR` command for organize imports of the current buffer
      vim.api.nvim_create_user_command("OR", "call CocActionAsync('runCommand', 'editor.action.organizeImport')", {})
    end -- }}}
  })
  use({
    'github/copilot.vim',
    config = function()
      vim.api.nvim_set_keymap('i', '<c-]>', 'copilot#Accept("<CR>")', { silent = true, expr = true })
      vim.g.copilot_no_tab_map = true
    end
  })

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = { enable = true },
        ensure_installed = {
          "python",
          "bash",
          "json",
          "toml",
          "yaml",
          "typescript",
          "javascript",
          "tsx",
          "make",
          "markdown",
          "vim",
          "lua",
        },
        additional_vim_regex_highlighting = false,
      })
    end
  }
  -- }}}

  -- Fuzzy finder {{{
  use {
    'gelguy/wilder.nvim',
    config = function()
      local wilder = require('wilder')
      wilder.setup({ modes = { ':', '/', '?' } })
      wilder.set_option('renderer', wilder.popupmenu_renderer(
        wilder.popupmenu_border_theme({
          border = 'rounded',
          highlights = { boader = 'Normal' },
          highlighter = wilder.basic_highlighter(),
          left = { ' ', wilder.popupmenu_devicons() },
          right = { ' ', wilder.popupmenu_scrollbar() },
        })
      ))
    end,
  }
  use { 'fannheyward/telescope-coc.nvim' }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use { 'natecraddock/telescope-zf-native.nvim' }
  use {
    'nvim-telescope/telescope.nvim',
    tag = "*",
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'fannheyward/telescope-coc.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'natecraddock/telescope-zf-native.nvim' },
    },
    config = function() -- {{{
      -- General configuration
      local themes = require("telescope.themes")
      local actions = require("telescope.actions")
      require("telescope").setup {
        defaults = {
          prompt_prefix = ">>> ",
          selection_caret = "  ",
          shorten_path = true,
          color_devicons = true,
          winblend = 10,
          set_env = { ['COLORTERM'] = 'truecolor' },
          mappings = {
            n = {
              ["t"] = actions.select_tab,
              ["q"] = actions.close,
              ["<C-o>"] = actions.close,
              ["dd"] = actions.delete_buffer,
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<S-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
            i = {
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<S-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
          },
        },
        pickers = {
          find_files = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 }, hidden = true }),
          live_grep = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
          buffers = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
          git_status = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
          grep_string = themes.get_dropdown({ layout_config = { height = 0.25, width = 0.85 } }),
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            cwd_to_path = true,
            files = true,
            hidden = { file_browser = true, folder_browser = true },
            mappings = {
              ["i"] = {
                ["<C-o>"] = false,
                ["<bs>"] = false,
              },
            },
          },
        }
      }
      -- Add extentions
      require("telescope").load_extension("coc")
      require("telescope").load_extension("zf-native")
      require("telescope").load_extension("file_browser")

      -- Keybindings
      local keymap = vim.api.nvim_set_keymap
      local keymap_opts = { noremap = true, silent = true }
      keymap("n", "<C-f>f", "<cmd>Telescope find_files<CR>", keymap_opts)
      keymap("n", "<C-f>g", "<cmd>Telescope git_status<CR>", keymap_opts)
      keymap("n", "<C-f><C-g>", "<cmd>Telescope live_grep<CR>", keymap_opts)
      keymap("n", "<C-f>b", "<cmd>Telescope buffers<CR>", keymap_opts)
      keymap("n", "<C-f><Space>", "<cmd>Telescope file_browser<CR>", keymap_opts)
      keymap("n", "<C-f>e", "<cmd>Telescope emoji<CR>", keymap_opts)
      keymap("n", "<C-f>q",
        '<cmd>Telescope coc diagnostics theme=dropdown layout_config={"height":0.25,"width":0.85}<CR>', keymap_opts)
      keymap("n", "<C-f>*", "<cmd>Telescope grep_string<CR>", keymap_opts)
      keymap("n", "<C-f>/",
        'builtin.live_grep({search_dirs={vim.fn.expand("%:p")}, previewer=false, path_display={shorten=1}})<CR>',
        keymap_opts)
      keymap("n", "<C-f><C-f>", "<cmd>Telescope resume<CR>", keymap_opts)
    end -- }}}
  }
  -- }}}

  -- Others {{{
  use({
    'ntpeters/vim-better-whitespace',
    setup = function()
      vim.g.better_whitespace_filetypes_blacklist = { 'dashboard', 'help' }
    end
  })
  use({
    'christoomey/vim-tmux-navigator',
    setup = function()
      vim.g.tmux_navigator_disable_when_zoomed = 1
    end,
  })

  use { 'tpope/vim-surround' }
  use { 'tpope/vim-repeat' }
  use { 'tomtom/tcomment_vim' }
  use {
    'Konfekt/FastFold',
    config = function()
      vim.g.fastfold_fold_command_suffixes = {}
    end
  }
  use {
    'andymass/vim-matchup',
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
  }
  use {
    "ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup()
    end
  }
  use { 'tmhedberg/SimpylFold' }
  use {
    'gabrielpoca/replacer.nvim',
    config = function()
      vim.api.nvim_create_user_command('QFReplace', 'lua require("replacer").run()', {})
    end
  }
  use { 'stefandtw/quickfix-reflector.vim' }
  use { 'roxma/vim-paste-easy' }
  use {
    'mg979/vim-visual-multi',
    config = function()
      vim.cmd([[
        let g:VM_maps = {}
        let g:VM_maps['Find Under'] = '<space>n'
        let g:VM_maps['Find Subword Under'] = '<space>n'
        aug VMlens
          au!
          au User visual_multi_start lua require('vmlens').start()
          au User visual_multi_exit lua require('vmlens').exit()
        aug END
      ]])
    end
  }
  use {
    "kylechui/nvim-surround",
    tag = "*",
    config = function()
      require("nvim-surround").setup()
    end
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use {
    'stevearc/aerial.nvim',
    config = function()
      require('aerial').setup({
        layout = {
          -- Determines the default direction to open the aerial window. The 'prefer'
          -- options will open the window in the other direction *if* there is a
          -- different buffer in the way of the preferred direction
          -- Enum: prefer_right, prefer_left, right, left, float
          default_direction = "prefer_left",
        },
      })
      -- You probably also want to set a keymap to toggle aerial
      vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle<CR>')
    end
  }
  use {
    "gbprod/yanky.nvim",
    config = function()
      require("yanky").setup()
      vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
      vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
      vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
      vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
      vim.keymap.set("n", "<c-p>", "<Plug>(YankyCycleForward)")
      vim.keymap.set("n", "<c-n>", "<Plug>(YankyCycleBackward)")
    end
  }
  use {
    'tpope/vim-fugitive',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>gs', ':Git<CR><C-w>J', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>ga', ':Gwrite<CR>', { noremap = true, silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gc', ':Git commit<CR>', { noremap = true, silent = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "fugitive",
        command = "nmap <buffer> q gq",
      })
    end
  }
  -- }}}

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
