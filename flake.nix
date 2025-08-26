{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable-small";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    systems.url = "github:nix-systems/default";
    nil.url = "github:oxalica/nil";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    home-manager,
    nixpkgs,
    systems,
    sops-nix,
    nil,
    ...
  }: let
    mainUser = "michaelbeasley";
    userHome = "/Users/${mainUser}";
  in {
    darwinConfigurations = {
      "MBeasley-23MBP" = nix-darwin.lib.darwinSystem {
        system = systems;
        # System level
        modules = [
          ./hosts/MBeasley-23MBP.local/darwin.nix
          sops-nix.darwinModules.sops
          home-manager.darwinModules.home-manager
          {
            sops = {
              age = {
                keyFile = "${userHome}/Library/Application Support/sops/age/keys.txt";
                sshKeyPaths = ["${userHome}/.ssh/sops_ed25519"];
              };
              # defaultSopsFile = ./homemanager/secrets/secrets.yaml;
              defaultSopsFile = ./hosts/MBeasley-23MBP.local/users/mike/home-manager/secrets/secrets.yaml;
            };
            # User level
            home-manager = {
              users.${mainUser} = {
                imports = [
                  ./hosts/MBeasley-23MBP.local/users/mike/home-manager/home.nix
                  sops-nix.homeManagerModules.sops
                ];
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hmback";
              extraSpecialArgs.flake-inputs = inputs;
            };
            users.users.${mainUser} = {
              home = "${userHome}";
            };
          }
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
