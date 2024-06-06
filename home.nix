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
    kitty
    cmatrix
    gcc
    cmake
    cargo
    rustc
    rust-analyzer
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
    starship
    tree
    nixfmt-rfc-style
    texlab
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "nvim";
    TERMINAL = "kitty";
    SHELL = "bash";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    bash = {
      enable = true;
    };

    nixvim = {
      enable = true;
      colorschemes.onedark.enable = true;
      globals = {
        mapleader = " ";
        localmapleader = " ";
      };
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
              "<leader>e" = "open_float";
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
            pyright.enable = true;
            rust-analyzer = {
              enable = true;
              installRustc = true;
              installCargo = true;
            };
          };
        };
      };
    };

    kitty = {
      enable = true;
      shellIntegration.enableBashIntegration = true;
      settings = {
        enabled_layouts = "grid";
        tab_bar_style = "powerline";
        tab_powerline_style = "angled";
        foreground = "#ffffff";
        background = "#121212";
        background_opacity = "0.7";
        background_blur = 1;
        startup_session = "artiq";
        shell = "bash";
      };
    };

    git = {
      enable = true;
      userName = "Simon Renblad";
      userEmail = "srenblad@m-labs.hk";
    };

    starship = {
      enable = true;
      settings = {
        add_newline = false;
        format = "$time\\[$username@$hostname\\]$git_branch$nix_shell$directory\n$character";
        time = {
          format = "\\[[$time]($style)\\]";
        };
        username = {
          format = "[$user]($style)";
          show_always = true;
        };
        hostname = {
          ssh_only = false;
          format = "[$hostname]($style)";
        };
        git_branch = {
          format = "\\([$branch]($style)\\)";
        };
        nix_shell = {
          format = "\\([$name]($style)\\)";
        };
      };
    };
  };
}
