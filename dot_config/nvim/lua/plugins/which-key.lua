return {
  {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300

      local setup = {
        plugins = {
          marks = false, -- shows a list of your marks on ' and `
          registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
          spelling = {
            enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
            suggestions = 20, -- how many suggestions should be shown in the list?
          },
          -- the presets plugin, adds help for a bunch of default keybindings in Neovim
          -- No actual key bindings are created
          presets = {
            operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
            motions = true, -- adds help for motions
            text_objects = true, -- help for text objects triggered after entering an operator
            windows = true, -- default bindings on <c-w>
            nav = true, -- misc bindings to work with windows
            z = true, -- bindings for folds, spelling and others prefixed with z
            g = true, -- bindings for prefixed with g
          },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comments" },
        key_labels = {
          -- override the label used to display some keys. It doesn't effect WK in any other way.
          -- For example:
          -- ["<space>"] = "SPC",
          -- ["<CR>"] = "RET",
          -- ["<tab>"] = "TAB",
        },
        icons = {
          breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
          separator = "➜", -- symbol used between a key and it's label
          group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
          scroll_down = "<c-d>", -- binding to scroll down inside the popup
          scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
          border = "rounded", -- none, single, double, shadow
          position = "bottom", -- bottom, top
          margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
          padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
          winblend = 0,
        },
        layout = {
          height = { min = 4, max = 25 }, -- min and max height of the columns
          width = { min = 20, max = 50 }, -- min and max width of the columns
          spacing = 3, -- spacing between columns
          align = "left", -- align columns left, center or right
        },
        ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true, -- show help message on the command line when the popup is visible
        triggers = "auto", -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
          -- list of mode / prefixes that should never be hooked by WhichKey
          -- this is mostly relevant for key maps that start with a native binding
          -- most people should not need to change this
          i = { "j", "k" },
          v = { "j", "k" },
        },
      }

      local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
      }

      local mappings = {
        ["a"] = { "<cmd>Alpha<CR>", "Alpha (homescreen)" },
        ["e"] = { "<cmd>Neotree toggle<CR>", "Explorer" },
        ["E"] = {
          "<cmd>Neotree reveal_force_cwd<CR>",
          "Explorer (Change current working directory)",
        },
        ["q"] = { "<cmd>qa<CR>", "Quit" },
        ["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
        ["f"] = {
          "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, hidden = true})<CR>",
          "Find files",
        },
        ["c"] = { "<cmd>lua MiniBufremove.delete()<CR>", "Close Buffer" },
        ["u"] = { "<cmd>Telescope undo<cr>", "Undo Tree" },
        p = {
          name = "Packer",
          c = { "<cmd>PackerCompile<CR>", "Compile" },
          i = { "<cmd>PackerInstall<CR>", "Install" },
          s = { "<cmd>PackerSync<CR>", "Sync" },
          S = { "<cmd>PackerStatus<CR>", "Status" },
          u = { "<cmd>PackerUpdate<CR>", "Update" },
        },
        g = {
          name = "Git",
          g = { ":LazyGit<CR>", "Lazygit" },
          j = { "<cmd>lua require 'gitsigns'.next_hunk()<CR>", "Next Hunk" },
          k = { "<cmd>lua require 'gitsigns'.prev_hunk()<CR>", "Prev Hunk" },
          l = { "<cmd>lua require 'gitsigns'.blame_line()<CR>", "Blame" },
          L = { "<cmd>lua require 'gitsigns'.toggle_current_line_blame()<CR>", "Toggle Current Line Blame" },
          p = { "<cmd>lua require 'gitsigns'.preview_hunk()<CR>", "Preview Hunk" },
          r = { "<cmd>lua require 'gitsigns'.reset_hunk()<CR>", "Reset Hunk" },
          R = { "<cmd>lua require 'gitsigns'.reset_buffer()<CR>", "Reset Buffer" },
          s = { "<cmd>lua require 'gitsigns'.stage_hunk()<CR>", "Stage Hunk" },
          u = {
            "<cmd>lua require 'gitsigns'.undo_stage_hunk()<CR>",
            "Undo Stage Hunk",
          },
          o = { "<cmd>Telescope git_status<CR>", "Open changed file" },
          b = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
          c = { "<cmd>Telescope git_commits<CR>", "Checkout commit" },
          d = {
            "<cmd>Gitsigns diffthis HEAD<CR>",
            "Diff",
          },
        },
        l = {
          name = "LSP",
          a = {
            "<cmd>lua vim.lsp.buf.code_action()<CR>",
            "Code Action",
          },
          A = { "<cmd>lua require('neogen').generate()<CR>", "Generate Annotation" },
          d = {
            "<cmd>Telescope diagnostics<CR>",
            "Diagnostics List",
          },
          f = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
          i = { "<cmd>LspInfo<CR>", "Info" },
          I = { "<cmd>LspInstallInfo<CR>", "Installer Info" },
          j = {
            "<cmd>lua vim.diagnostic.goto_next()<CR>",
            "Next Diagnostic",
          },
          k = {
            "<cmd>lua vim.diagnostic.goto_prev()<CR>",
            "Prev Diagnostic",
          },
          l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "CodeLens Action" },
          q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", "Quickfix" },
          r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        },
        s = {
          name = "Search",
          b = {
            "<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<CR>",
            "Buffers",
          },
          B = { "<cmd>Telescope git_branches<CR>", "Checkout branch" },
          c = { "<cmd>Telescope commands<CR>", "Commands" },
          C = { "<cmd>Telescope colorscheme<CR>", "Colorscheme" },
          h = { "<cmd>Telescope help_tags<CR>", "Find Help" },
          M = { "<cmd>Telescope man_pages<CR>", "Man Pages" },
          r = { "<cmd>Telescope oldfiles<CR>", "Open Recent File" },
          R = { "<cmd>Telescope registers<CR>", "Registers" },
          k = { "<cmd>Telescope keymaps<CR>", "Keymaps" },
          p = { "<cmd>Telescope projects<CR>", "Projects" },
          f = {
            "<cmd>lua require('telescope.builtin').find_files({ hidden = true })<CR>",
            "Find files",
          },
          F = {
            "<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false, hidden = true})<CR>",
            "Find files",
          },
          t = { "<cmd>Telescope live_grep<CR>", "Find Text" },
          w = { "<cmd>Telescope grep_string<CR>", "Find Word" },
          s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
          S = {
            "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>",
            "Workspace Symbols",
          },
        },
        t = {
          name = "Terminal",
          n = { "<cmd>lua _NODE_TOGGLE()<CR>", "Node" },
          u = { "<cmd>lua _NCDU_TOGGLE()<CR>", "NCDU" },
          t = { "<cmd>lua _HTOP_TOGGLE()<CR>", "Htop" },
          p = { "<cmd>lua _PYTHON_TOGGLE()<CR>", "Python" },
          f = { "<cmd>ToggleTerm direction=float<CR>", "Float" },
          h = { "<cmd>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" },
          v = { "<cmd>ToggleTerm size=80 direction=vertical<CR>", "Vertical" },
        },
      }

      require("which-key").setup(setup)
      require("which-key").register(mappings, opts)
    end,
  },
}
