{ pkgs }:
{
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
}
