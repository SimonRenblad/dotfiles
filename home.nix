{ config, pkgs, ... }:

{
  home.username = "srenblad";
  home.homeDirectory = "/home/srenblad";

  home.stateVersion = "24.05";

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    kitty
    cmatrix
    neovim
    gcc
    cmake
    python310Packages.python-lsp-server
    python310Packages.flake8
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
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    bash = {
      enable = true;
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
