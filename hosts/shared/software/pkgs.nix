{
  pkgs,
  config,
  lib,
  flake-inputs,
  ...
}: let
  # Package shell scripts
  ssh-proxy = pkgs.writeShellScriptBin "ssh-proxy" (
    builtins.readFile ../scripts/sshproxy.sh
  );
  tilt-connect = pkgs.writeShellScriptBin "tilt-connect" (
    builtins.readFile ../scripts/tilt-connect.sh
  );
  blame-line-pretty = pkgs.writeShellScriptBin "blame-line-pretty" (
    builtins.readFile ../scripts/blame-line-pretty.sh
  );
  git-hunk = pkgs.writeShellScriptBin "git-hunk" (
    builtins.readFile ../scripts/git-hunk.sh
  );
  gpg-push-pull-keys = pkgs.writeShellScriptBin "gpg-push-pull-keys" (
    builtins.readFile ../scripts/gpg-push-pull-keys.sh
  );

  # Build this from source since nixpkgs is lagging and this software
  # no longer builds on a recent version of Rust
  macmon = pkgs.rustPlatform.buildRustPackage (finalAttrs: {
    pname = "macmon";
    version = "v0.7.2";
    src = pkgs.fetchFromGitHub {
      owner = "vladkens";
      repo = finalAttrs.pname;
      tag = finalAttrs.version;
      hash = "sha256-i6x4ZAh+gIG6aHEfoSifwFU/itOcPmBiQ0IrBkqz+L8=";
    };
    cargoHash = "sha256-faEuoroZ/d8FntZaxkTbgVQ0nSwddxZR7KOfNPrU4Eg=";
    meta = {
      description = "A sudoless performance monitoring CLI tool for Apple Silicon processors";
      homepage = "https://github.com/vladkens/macmon";
      mainProgram = finalAttrs.pname;
    };
  });

  # Helm v4 is not available in nixpkgs
  helm4 = pkgs.stdenv.mkDerivation (finalAttrs: {
    pname = "helm";
    version = "4.2.0";
    sourceRoot = ".";
    src = pkgs.fetchzip {
      name = finalAttrs.pname;
      url = "https://get.${finalAttrs.pname}.sh/${finalAttrs.pname}-v${finalAttrs.version}-darwin-arm64.tar.gz";
      hash = "sha256-sgU3NgZaeWjdZxxt8KpUBMg8RyQf1FzHT5Z0OmLgTfQ=";
      stripRoot = false;
    };
    installPhase = ''
      runHook preInstall
      install -m 0755 -D helm/darwin-arm64/helm $out/bin/helm
      runHook postInstall
    '';
    meta = {
      description = "Package management for Kubernetes";
      homepage = "https://helm.sh";
      mainProgram = finalAttrs.pname;
    };
  });

  # Not available in nixpkgs
  claws = pkgs.buildGoLatestModule (finalAttrs: {
    pname = "claws";
    version = "v0.16.0";
    src = pkgs.fetchFromGitHub {
      owner = "clawscli";
      repo = finalAttrs.pname;
      tag = finalAttrs.version;
      hash = "sha256-mdZ2TM3iHef0JweLTYq5oPBWZUOYyydPbCYb+So5WsA=";
    };
    # This fails tests due to using `/homeless-shelter/.` Google buildroot nonsense
    doCheck = false;
    vendorHash = "sha256-Ef/2Xs15E5noUYJk2J9k48g0kfTPB6v+D9uUHdOyya0=";
    meta = {
      description = "A TUI for AWS resource management";
      homepage = "https://github.com/clawscli/claws";
      mainProgram = finalAttrs.pname;
    };
  });

  rust-overlay-pkgs = pkgs.extend flake-inputs.rust-overlay.overlays.default;
  cfg = config.zshConfig;
in {
  config = {
    home = {
      packages = with pkgs;
        [
          alejandra
          bat
          bat-extras.batman
          cmake
          delta
          fd
          findutils
          gawk
          gh
          jdk21_headless
          jq
          lazydocker
          macmon
          nerd-fonts.monaspace
          nh
          nix-output-monitor
          nodejs_26
          noto-fonts
          p7zip
          pam-reattach
          pinentry-tty
          prek
          ripgrep
          rust-overlay-pkgs.rust-bin.stable."1.95.0".default
          shfmt
          sops
          tldr
          tree-sitter
          ugrep
          viddy
          yq
          yubikey-manager
          # Scripts
          blame-line-pretty
          git-hunk
          gpg-push-pull-keys
        ]
        ++ (lib.optionals cfg.workAliases.enable [
          (pkgs.google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
          pkgs.act
          pkgs.ansible
          pkgs.ansible-lint
          pkgs.awscli2
          claws
          pkgs.eks-node-viewer
          pkgs.go
          helm4
          pkgs.krew
          pkgs.kubecolor
          pkgs.kubectl
          pkgs.kubectx
          pkgs.kubent
          pkgs.ssm-session-manager-plugin
          pkgs.stern
          pkgs.wget
          # Scripts
          ssh-proxy
          tilt-connect
        ]);
    };
  };
}
