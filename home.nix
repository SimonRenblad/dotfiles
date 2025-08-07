{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./programs
    ./services
  ];
  home.username = "srenblad";
  home.homeDirectory = "/home/srenblad";
  home.stateVersion = "24.05";
  home.sessionVariables = {
    EDITOR = "hx";
    TERMINAL = "alacritty";
    SHELL = "bash";
    QT_PLUGIN_PATH = "${pkgs.qt5.qtbase}/${pkgs.qt5.qtbase.dev.qtPluginPrefix}:${pkgs.qt5.qtsvg.bin}/${pkgs.qt5.qtbase.dev.qtPluginPrefix}";
  };
}
