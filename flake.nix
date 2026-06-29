{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nil = {
      url = "github:oxalica/nil";
    };
    strace-macos = {
      url = "github:Mic92/strace-macos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mcp-nixos = {
      url = "github:utensils/mcp-nixos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nix-darwin,
    home-manager,
    nixpkgs,
    sops-nix,
    nix-index-database,
    ...
  }: let
    mkDarwinHost = {
      mainUser,
      hostDir,
      system ? "aarch64-darwin",
    }:
      nix-darwin.lib.darwinSystem {
        inherit system;
        modules = [
          ./hosts/${hostDir}/darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users.${mainUser} = {
                imports = [
                  ./hosts/${hostDir}/users/${mainUser}/home-manager/home.nix
                  sops-nix.homeManagerModules.sops
                  nix-index-database.homeModules.default
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
          inherit inputs mainUser system;
        };
      };
    mkNixOSHost = {
      mainUser,
      hostDir,
      system ? "x86_64-linux",
    }:
      nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/${hostDir}/configuration.nix
          home-manager.nixosModules.home-manager
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
          inherit inputs mainUser system hostDir;
        };
      };
  in {
    darwinConfigurations = {
      "MBeasley-23MBPlocal" = mkDarwinHost {
        mainUser = "michaelbeasley";
        hostDir = "MBeasley-23MBPlocal";
      };
      "mike-macbook-pro" = mkDarwinHost {
        mainUser = "mike";
        hostDir = "mike-macbook-pro";
      };
      "mike-mac-pro" = mkDarwinHost {
        mainUser = "mike";
        hostDir = "mike-mac-pro";
        system = "x86_64-darwin";
      };
    };
    nixosConfigurations = {
      "llama-server" = mkNixOSHost {
        mainUser = "mike";
        hostDir = "llama-server";
      };
    };
  };
}
