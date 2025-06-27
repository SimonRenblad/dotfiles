{
  description = "Home Manager configuration of srenblad";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    punctuate = {
      url = "github:SimonRenblad/punctuate";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ttyper = {
      url = "github:SimonRenblad/ttyper";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, punctuate, ttyper, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      homeConfigurations."srenblad" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit punctuate; inherit ttyper; };
      };
    };
}
