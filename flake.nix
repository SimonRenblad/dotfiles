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
    morgan_pkgs = {
      url = "github:MorganTL/pkgs_flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    naersk = {
      url = "github:nix-community/naersk";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    wik = {
      url = "github:SimonRenblad/wik";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    menth = {
      url = "github:SimonRenblad/pymenth";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations."srenblad" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [
          ./home.nix
          ./packages.nix
        ];
        extraSpecialArgs = {
          inherit inputs;
        };
      };
    };
}
