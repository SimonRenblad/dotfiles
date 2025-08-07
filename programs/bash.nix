{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      if [[ -t 1 ]]; then
        eval "$(fzf --bash)"
        eval "$(starship init bash)"  
      fi
    '';
  };
}
