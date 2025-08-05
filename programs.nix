{ pkgs, ... }: {
  programs = {
    tmux = import ./programs/tmux.nix { inherit pkgs; };
    fish = import ./programs/fish.nix { inherit pkgs; };
    bash = import ./programs/bash.nix {};
    helix = import ./programs/helix.nix {};
    alacritty = import ./programs/alacritty.nix {};
    git = import ./programs/git.nix {};
  };
}
