{
  config,
  pkgs,
  inputs,
  ftdv,
  ...
}:
{
  home.username = "srenblad";
  home.homeDirectory = "/home/srenblad";
  home.stateVersion = "24.05";
  home.packages =
    with pkgs;
    [
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
      glance
      graphviz
      hecate
      helix
      kitty
      lazygit
      leetcode-cli
      libqalculate
      llvmPackages_14.clang-unwrapped
      lua
      mtr
      ncurses
      nil
      nixfmt-rfc-style
      nixd
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
      qemu
      qownnotes
      river
      ruff
      rust-analyzer
      rustc
      rustfmt
      slides
      starship
      sway
      tclPackages.tk
      texlab
      tmux
      traceroute
      tree
      tt
      units
      verilog
      w3m
      wl-clipboard
      whois
      wmenu
      yazi
      zig
      zls
    ]
    ++ [
      inputs.ttyper.packages.x86_64-linux.default
      inputs.punctuate.packages.x86_64-linux.default
      ftdv
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "alacritty";
    SHELL = "bash";
    QT_PLUGIN_PATH = "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.dev.qtPluginPrefix}:${pkgs.qt5.qtsvg.bin}/${pkgs.qt5.qtbase.dev.qtPluginPrefix}";
  };

  services = {
    glance = {
      enable = true;
      settings = {
        theme = {
          background-color = "232 23 18";
          contrast-multiplier = 1.2;
          primary-color = "220 83 75";
          positive-color = "105 48 72";
          negative-color = "351 74 73";
        };
        server = {
          host = "localhost";
          port = 8080;
        };
        pages = [
          {
            name = "RSS";
            columns = [
              {
                size = "full";
                widgets = [
                  {
                    type = "rss";
                    style = "detailed-list";
                    limit = 20;
                    collapse-after = -1;
                    cache = "12h";
                    feeds = [
                      {
                        url = "https://selfh.st/rss/";
                      }
                      {
                        url = "https://www.phoronix.com/rss.php"; 
                      }
                      {
                        url = "https://www.cnx-software.com/feed/";
                      }
                      {
                        url = "https://hforsten.com/feeds/all.atom.xml";
                      }
                      {
                        url = "https://jwt625.github.io/feed.xml";
                      }
                      {
                        url = "https://chipsandcheese.com/feed";
                      }
                    ];
                  }
                ];
              }
            ];
          }
        ];
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs = {
    tmux = {
      enable = true;
      prefix = "C-q";
      mouse = false;
      escapeTime = 0;
      shell = "${pkgs.bash}/bin/bash";
      extraConfig = ''
        # create a popup
        bind-key u display-popup $SHELL

        # search keybindings
        bind-key H display-popup "tmux list-keys | fzf"

        # display btm for performance
        bind-key b display-popup "btm -b"
      '';
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

    bash = {
      enable = true;
      enableCompletion = true;
      bashrcExtra = ''
        eval "$(fzf --bash)"
        eval "$(starship init bash)"  
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
      languages = {
        language = [
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
        language-server = {
          pylsp.config.pylsp.plugins = {
            ruff = {
              enabled = true;
              ignore = [ "F401" ];
              lineLength = 120;
            };
            pylint.enabled = true;
            flake8.enabled = true;
          };
          rust-analyzer.config = {
            cargo.features = "all";
          };
          nixd = {
            command = "nixd";
          };
        };
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
