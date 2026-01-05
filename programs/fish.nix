{ pkgs, ... }: {
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
      set EDITOR hx
    '';
    plugins = [
      {
        name = "fzf";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "z";
        src = pkgs.fishPlugins.z.src;
      }
    ];
  };
}
