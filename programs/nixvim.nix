{
  programs.nixvim = {
    enable = true;
    colorschemes.onedark.enable = true;
    globals = {
      mapleader = " ";
      localmapleader = " ";
    };
    keymaps = [
      {
        mode = "n";
        key = "<leader>sp";
        options.silent = true;
        action = "<cmd>LspStop<CR>";
      }
      {
        mode = "n";
        key = "<leader>sr";
        options.silent = true;
        action = "<cmd>LspStart<CR>";
      }
    ];
    opts = {
      hlsearch = false;
      scrolloff = 10;
      number = true;
      relativenumber = true;
      mouse = "a";
      clipboard = "unnamedplus";
      breakindent = true;
      undofile = true;
      ignorecase = true;
      smartcase = true;
      signcolumn = "yes";
      updatetime = 250;
      timeout = true;
      timeoutlen = 300;
      completeopt = "menuone,noselect";
      termguicolors = true;
      smarttab = true;
      tabstop = 2;
      expandtab = true;
      shiftwidth = 2;
    };
    plugins = {
      # TODO: add oil
      bufferline = {
        enable = true;
      };
      lualine = {
        enable = true;
      };
      gitsigns.enable = true;
      cmp.enable = true;

      cmp-nvim-lsp = {
        enable = true; # Enable suggestions for LSP
      };
      cmp-buffer = {
        enable = true; # Enable suggestions for buffer in current file
      };
      cmp-path = {
        enable = true; # Enable suggestions for file system paths
      };
      cmp_luasnip = {
        enable = true; # Enable suggestions for code snippets
      };
      cmp-cmdline = {
        enable = false; # Enable autocomplete for command line
      };
      treesitter = {
        enable = true;
        nixvimInjections = true;
        folding = false;
        indent = true;
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>sf" = "find_files";
          "<leader>fg" = "live_grep";
          "<leader> " = "buffers";
          "<leader>fh" = "help_tags";
          "<leader>fd" = "diagnostics";
          "<C-p>" = "git_files";
          "<leader>p" = "oldfiles";
          "<C-f>" = "live_grep";
        };
        settings.defaults = {
          file_ignore_patterns = [
            "^.git/"
            "^.mypy_cache/"
            "^__pycache__/"
            "^output/"
            "^data/"
            "%.ipynb"
          ];
          set_env.COLORTERM = "truecolor";
        };
        extensions = {
          fzf-native = {
            enable = true;
          };
        };
      };
      lsp = {
        enable = true;
        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
            "<leader>q" = "setloclist";
          };
          lspBuf = {
            gd = "definition";
            gD = "references";
            gt = "type_definition";
            gi = "implementation";
            K = "hover";
            "<F2>" = "rename";
          };
        };
        servers = {
          clangd.enable = true;
          lua-ls.enable = true;
          texlab.enable = true;
          zls.enable = true;
          nil-ls.enable = true;
          ruff-lsp.enable = true;
          pylsp = {
            enable = true;
            settings = {
              plugins = {
                flake8.enabled = true;
              };
            };
          };
          rust-analyzer = {
            enable = true;
            installRustc = true;
            installCargo = true;
          };
        };
      };
    };
    extraConfigLua = ''
      -- Shortcut to disable lsp for a buffer
      -- function M.LspSwap()
      --   if vim.b.lsp_enabled == false then
      --       M.LspShow()
      --   else
      --       M.LspHide()
      --   end
      -- end

      -- vim.api.nvim_buf_set_keymap(0, 'n', 'yop',
      --                                 '<cmd>lua require("lsp-local").LspSwap()<CR>',
      --                                 {noremap = true})
    '';
  };
}
