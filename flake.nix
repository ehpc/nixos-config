{
  description = "ehpc's desktop flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/nix-darwin-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      nix-darwin,
      home-manager,
      sops-nix,
      ...
    }:
    let
      mkHost =
        { system, hostname }:
        let
          isDarwin = system == "aarch64-darwin" || system == "x86_64-darwin";
          pkgsUnstable = import nixpkgs-unstable {
            inherit system;
            config.allowUnfree = true;
          };
          libSystem = if isDarwin then nix-darwin.lib.darwinSystem else nixpkgs.lib.nixosSystem;
          hmModule =
            if isDarwin then
              home-manager.darwinModules.home-manager
            else
              home-manager.nixosModules.home-manager;
        in
        libSystem {
          inherit system;
          specialArgs = {
            inherit
              self
              system
              nixpkgs
              hostname
              inputs
              pkgsUnstable
              isDarwin
              ;
          };
          modules = [
            ./modules
            hmModule
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = {
                inherit inputs pkgsUnstable isDarwin;
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
      darwinConfigurations = {
        "ehpc-air" = mkHost {
          system = "aarch64-darwin";
          hostname = "ehpc-air";
        };
      };
    };
}
