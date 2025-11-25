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
      {
        key = ";";
        options = {
          silent = true;
          noremap = true;
        };
        action = "<Right>";
      }
      {
        key = "l";
        options = {
          silent = true;
          noremap = true;
        };
        action = "gk";
      }
      {
        key = "k";
        options = {
          silent = true;
          noremap = true;
        };
        action = "gj";
      }
      {
        key = "j";
        options = {
          silent = true;
          noremap = true;
        };
        action = "<Left>";
      }
      {
        key = "<C-w>k";
        options = {
          noremap = true;
        };
        action = "<C-w>j";
      }
      {
        key = "<C-w><C-k>";
        options = {
          noremap = true;
        };
        action = "<C-w>j";
      }
      {
        key = "<C-w>l";
        options = {
          noremap = true;
        };
        action = "<C-w>k";
      }
      {
        key = "<C-w><C-l>";
        options = {
          noremap = true;
        };
        action = "<C-w>k";
      }
      {
        key = "<C-w>j";
        options = {
          noremap = true;
        };
        action = "<C-w>h";
      }
      {
        key = "<C-w><C-j>";
        options = {
          noremap = true;
        };
        action = "<C-w>h";
      }
      {
        key = "<C-w>;";
        options = {
          noremap = true;
        };
        action = "<C-w>l";
      }
      {
        key = "<C-w><C-semicolon>";
        options = {
          noremap = true;
        };
        action = "<C-w>l";
      }
      {
        key = "'";
        options = {
          noremap = true;
        };
        action = ";";
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
      web-devicons.enable = true;
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
      };
      telescope = {
        enable = true;
        keymaps = {
          "<leader>f" = "find_files";
          "<leader>/" = "live_grep";
          "<leader>b" = "buffers";
          "<leader>h" = "help_tags";
          "<leader>d" = "diagnostics";
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
          nil_ls.enable = true;
          pylsp = {
            enable = true;
            settings = {
              plugins = {
                flake8.enabled = true;
              };
            };
          };
          rust_analyzer = {
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
