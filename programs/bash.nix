{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      eval "$(fzf --bash)"
      eval "$(starship init bash)"  
    '';
  };
}
