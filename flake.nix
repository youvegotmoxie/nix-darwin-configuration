{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    # Used as a pkg overlays where nixpkgs-unstable remains broken for long periods
    # hosts/shared/software/default.nix(direnv)
    nixos-unstable-small.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    systems.url = "github:nix-systems/default";
    nil.url = "github:oxalica/nil";
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    home-manager,
    nixpkgs,
    nixos-unstable-small,
    systems,
    nil,
    ...
  }: let
    mkDarwinHost = {
      mainUser,
      hostDir,
    }:
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/${hostDir}/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users.${mainUser} = {
                imports = [
                  ./hosts/${hostDir}/users/${mainUser}/home-manager/home.nix
                ];
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hmback";
              extraSpecialArgs.flake-inputs = inputs;
            };
          }
        ];
        specialArgs = {
          inherit inputs mainUser;
        };
      };
  in {
    darwinConfigurations = {
      "MBeasley-23MBPlocal" = mkDarwinHost {
        mainUser = "michaelbeasley";
        hostDir = "MBeasley-23MBP.local";
      };
      "mike-macbook-air" = mkDarwinHost {
        mainUser = "mike";
        hostDir = "mike-macbook-air";
      };
    };
  };
}
