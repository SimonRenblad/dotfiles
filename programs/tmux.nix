{ pkgs }:
{
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
}
