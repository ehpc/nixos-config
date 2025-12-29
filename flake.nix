{
  description = "ehpc's desktop flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      sops-nix,
      ...
    }:
    let
      mkHost =
        { system, hostname }:
        let
          pkgsUnstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
        in
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit hostname inputs pkgsUnstable;
          };
          modules = [
            ./modules
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs pkgsUnstable;
              };
              home-manager.users.ehpc = ./home-manager/users/ehpc;
              home-manager.sharedModules = [
                sops-nix.homeManagerModules.sops
              ];
            }
          ];
        };
    in
    {
      nixosConfigurations = {
        ehpc-desktop = mkHost {
          system = "x86_64-linux";
          hostname = "ehpc-desktop";
        };
      };
    };
}
