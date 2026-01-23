{
  description = "Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    systems.url = "github:nix-systems/default";
    nil.url = "github:oxalica/nil";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    argonaut = {
      url = "github:darksworm/argonaut";
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
    argonaut,
    ...
  }: {
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
                keyFile = "/Users/michaelbeasley/Library/Application Support/sops/age/keys.txt";
                sshKeyPaths = ["/Users/michaelbeasley/.ssh/sops_ed25519"];
              };
              # defaultSopsFile = ./homemanager/secrets/secrets.yaml;
              defaultSopsFile = ./hosts/MBeasley-23MBP.local/users/mike/home-manager/secrets/secrets.yaml;
            };
            # User level
            home-manager = {
              users."michaelbeasley" = {
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
            users.users."michaelbeasley" = {
              home = "/Users/michaelbeasley";
            };
          }
        ];
        specialArgs = {inherit inputs;};
      };
      "mike-macbook-air" = nix-darwin.lib.darwinSystem {
        system = systems;
        # System level
        modules = [
          ./hosts/mike-macbook-air/darwin.nix
          home-manager.darwinModules.home-manager
          {
            # User level
            home-manager = {
              users."mike" = {
                imports = [
                  ./hosts/mike-macbook-air/users/mike/home-manager/home.nix
                ];
              };
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "hmback";
              extraSpecialArgs.flake-inputs = inputs;
            };
          }
        ];
        specialArgs = {inherit inputs;};
      };
    };
  };
}
