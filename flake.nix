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
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      punctuate,
      ttyper,
      morgan_pkgs,
      naersk,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      ftdv = pkgs.callPackage ./ftdv.nix { inherit pkgs; inherit naersk; };
    in
    {
      homeConfigurations."srenblad" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
        extraSpecialArgs = { inherit inputs; inherit ftdv; };
      };
    };
}
