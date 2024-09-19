{
  config,
  pkgs,
  nixvim,
  ...
}:

{
  home.username = "srenblad";
  home.homeDirectory = "/home/srenblad";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    digital
    calibre
    ffmpeg
    nixfmt-rfc-style
    nil
    ruff
    kitty
    cmatrix
    gcc
    cmake
    cargo
    rustc
    rust-analyzer
    rustfmt
    bc
    parallel
    lua
    w3m
    zig
    fzf
    clang-tools_14
    zathura
    fd
    tt
    verilog
    stlink
    blackmagic
    zls
    fastfetch
    gcc-arm-embedded
    ncurses
    yazi
    tree
    nixfmt-rfc-style
    texlab
    (python3.withPackages (p: [
      p.matplotlib
      p.pyqt5
      p.flake8
      p.python-lsp-server
      p.python-lsp-ruff
      p.pylint
    ]))
    sox
    serpl
    gforth
    up
    crawley
    slides
    libqalculate
    grex
    bcal
    helix
    xsel
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "kitty";
    SHELL = "fish";
    QT_PLUGIN_PATH = "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.dev.qtPluginPrefix}:${pkgs.qt5.qtsvg.bin}/${pkgs.qt5.qtbase.dev.qtPluginPrefix}";
  };

  # Let Home Manager install and manage itself.
  programs = {

    bash = {
      enable = true;
    };

    helix = {
      enable = true;
      settings = {
        theme = "autumn_night_transparent";
        editor.cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        editor.lsp.display-messages = true;
        editor.lsp.display-inlay-hints = true;
      };
      languages.language = [
        {
          name = "nix";
          formatter.command = "nixfmt";
        }
        {
          name = "c";
          formatter.command = "clang-format";
        }
        {
          name = "python";
          formatter = {
            command = "ruff";
            args = [
              "format"
              "-"
            ];
          };
          language-servers = [ "pylsp" ];
        }
        {
          name = "rust";
          formatter = {
            command = "rustfmt";
          };
        }
      ];
      languages.language-server.pylsp.config.pylsp.plugins = {
        ruff = {
          enabled = true;
          ignore = [ "F401" ];
          lineLength = 120;
        };
        pylint.enabled = true;
        flake8.enabled = true;
      };

      themes = {
        autumn_night_transparent = {
          "inherits" = "autumn_night";
          "ui.background" = { };
        };
      };
    };

    nixvim = {
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

    kitty = {
      enable = true;
      shellIntegration.enableBashIntegration = true;
      settings = {
        tab_bar_style = "powerline";
        tab_powerline_style = "angled";
        background_opacity = "0.7";
        background_blur = 1;
        startup_session = "artiq";
        shell = "fish";
        foreground = "#979eab";
        background = "#282c34";
        color0 = "#282c34";
        color1 = "#e06c75";
        color2 = "#98c379";
        color3 = "#e5c07b";
        color4 = "#61afef";
        color5 = "#be5046";
        color6 = "#56b6c2";
        color7 = "#979eab";
        color8 = "#393e48";
        color9 = "#d19a66";
        color10 = "#56b6c2";
        color11 = "#e5c07b";
        color12 = "#61afef";
        color13 = "#be5046";
        color14 = "#56b6c2";
        color15 = "#abb2bf";
        active_tab_foreground = "#282c34";
        active_tab_background = "#979eab";
        inactive_tab_foreground = "#abb2bf";
        inactive_tab_background = "#282c34";
      };
    };

    git = {
      enable = true;
      userName = "Simon Renblad";
      userEmail = "srenblad@m-labs.hk";
    };
  };
}
