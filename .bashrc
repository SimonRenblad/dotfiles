export PYTHONPATH=/home/srenblad/artiq:$PYTHONPATH
export EDITOR=nvim

__nix_upgrade() { 
    nix profile list | awk '/Flake attribute:/ { print $NF }' | fzf | xargs nix profile upgrade;
}
__nix_remove() {
    nix profile list | awk '/Flake attribute:/ { print $NF }' | fzf | xargs nix profile remove;
}

alias nix_upgrade="__nix_upgrade"
alias nix_remove="__nix_remove"

eval "$(starship init bash)"
