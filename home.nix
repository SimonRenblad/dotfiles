{ config, pkgs, ... }:
{
  home.username = "srenblad";
  home.homeDirectory = "/home/srenblad";
  home.stateVersion = "24.05";
  home.packages = with pkgs; [
    alacritty
    bc
    bottom
    calibre
    cargo
    clang-tools_14
    cmake
    cmatrix
    cutter
    digital
    dos2unix
    fastfetch
    ffmpeg
    fzf
    gcc
    gforth
    helix
    kitty
    lazygit
    leetcode-cli
    libqalculate
    lua
    ncurses
    nil
    nixfmt-rfc-style
    nixfmt-rfc-style
    parallel
    ruff
    rust-analyzer
    rustc
    rustfmt
    slides
    texlab
    tmux
    tree
    tt
    verilog
    w3m
    yazi
    zig
    zls
    (python3.withPackages (p: [
      p.flake8
      p.matplotlib
      p.pylint
      p.pyqt5
      p.python-lsp-ruff
      p.python-lsp-server
    ]))
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "alacritty";
    SHELL = "fish";
    QT_PLUGIN_PATH = "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.dev.qtPluginPrefix}:${pkgs.qt5.qtsvg.bin}/${pkgs.qt5.qtbase.dev.qtPluginPrefix}";
  };

  # Let Home Manager install and manage itself.
  programs = {
    tmux = {
      enable = true;
      prefix = "C-q";
      mouse = false;
      escapeTime = 0;
    };

    fish = {
      enable = true;

      interactiveShellInit = ''
        set fish_greeting
        set EDITOR hx
      '';
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
          auto-format = false;
          formatter.command = "nixfmt";
        }
        {
          name = "c";
          auto-format = false;
          formatter.command = "clang-format";
        }
        {
          name = "python";
          auto-format = false;
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
          auto-format = false;
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
      languages.language-server.rust-analyzer.config = {
        cargo.features = "all";
      };
      themes = {
        autumn_night_transparent = {
          "inherits" = "autumn_night";
          "ui.background" = { };
        };
      };
    };

    alacritty = {
      enable = true;
      settings = {
        font.size = 9.0;
      };
    };

    git = {
      enable = true;
      userName = "Simon Renblad";
      userEmail = "srenblad@m-labs.hk";
    };
  };
}
