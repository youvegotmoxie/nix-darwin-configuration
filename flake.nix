{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nil.url = "github:oxalica/nil";
    nil.inputs.nixpkgs.follows = "nixpkgs";
    # nixpkgs Rust lags behind the upstream stable versions
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    strace-macos = {
      url = "github:Mic92/strace-macos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nix-darwin,
    home-manager,
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
