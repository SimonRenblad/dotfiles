{
  config,
  pkgs,
  punctuate,
  ttyper,
  ...
}:
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
    cmake
    cmatrix
    cutter
    difftastic
    digital
    dmenu
    dos2unix
    expect
    fastfetch
    ffmpeg
    fzf
    gcc
    gforth
    graphviz
    hecate
    helix
    kitty
    lazygit
    leetcode-cli
    libqalculate
    llvmPackages_14.clang-unwrapped
    lua
    ncurses
    nil
    nixfmt-rfc-style
    nixfmt-rfc-style
    parallel
    (python3.withPackages (p: [
      p.flake8
      p.matplotlib
      p.pylint
      p.pyqt5
      p.python-lsp-ruff
      p.python-lsp-server
      p.qtile
    ]))
    punctuate.packages.x86_64-linux.default
    qemu
    qownnotes
    river
    ruff
    rust-analyzer
    rustc
    rustfmt
    slides
    sway
    tclPackages.tk
    texlab
    tmux
    tree
    tt
    verilog
    w3m
    wl-clipboard
    wmenu
    yazi
    zig
    zls
  ] ++ [
   ttyper.packages.x86_64-linux.default 
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
        fzf --fish | source
      '';
      plugins = [
        {
          name = "z";
          src = pkgs.fishPlugins.z.src;
        }
      ];
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
        {
          name = "gas";
          auto-format = false;
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
          "type" = "gold";
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
