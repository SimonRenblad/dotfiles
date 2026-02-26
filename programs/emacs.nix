{ pkgs, ... }: {
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;  # replace with pkgs.emacs-gtk if desired
    extraPackages = epkgs: [
      epkgs.nix-mode
      epkgs.nixfmt
      epkgs.rust-mode
    ];
    extraConfig = ''
      (setq standard-indent 2)
      (tool-bar-mode -1)
      (menu-bar-mode -1)
      (toggle-scroll-bar -1)
      (tool-bar-mode -1)
    '';
  };
}
