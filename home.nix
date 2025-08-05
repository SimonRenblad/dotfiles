{
  config,
  pkgs,
  inputs,
  username,
  ...
}:
{
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "24.05";
  home.packages = import ./packages.nix { inherit pkgs; inherit inputs; };

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
    glance = import ./services/glance.nix {};
  };

  # Let Home Manager install and manage itself.
  programs = {
    tmux = import ./programs/tmux.nix { inherit pkgs; };
    fish = import ./programs/fish.nix { inherit pkgs; };
    bash = import ./programs/bash.nix {};
    helix = import ./programs/helix.nix {};
    alacritty = import ./programs/alacritty.nix {};
    git = import ./programs/git.nix {};
  };
}
