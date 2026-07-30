{
  pkgs,
  config,
  lib,
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
    version = "v0.8.0";
    src = pkgs.fetchFromGitHub {
      owner = "vladkens";
      repo = finalAttrs.pname;
      tag = finalAttrs.version;
      hash = "sha256-9UD/PXmMln5RiUQXjp2GV3m1R2IQ5ItvoOfpkqGNg/I=";
    };
    cargoHash = "sha256-hgZiXMvQwXDyEh0yVAftJEDk9i2e+Drgq11q9ze/mUc=";
    meta = {
      description = "A sudoless performance monitoring CLI tool for Apple Silicon processors";
      homepage = "https://github.com/vladkens/macmon";
      license = lib.licenses.mit;
      mainProgram = finalAttrs.pname;
    };
  });

  # Helm v4 is not available in nixpkgs
  helm4 = pkgs.stdenv.mkDerivation (finalAttrs: {
    pname = "helm";
    version = "4.2.3";
    sourceRoot = ".";
    src = pkgs.fetchzip {
      name = finalAttrs.pname;
      url = "https://get.${finalAttrs.pname}.sh/${finalAttrs.pname}-v${finalAttrs.version}-darwin-arm64.tar.gz";
      hash = "sha256-zPD0mkwE2bV79mCVRGeSWr4Z2Iqup6Hg7tHSafy6vZA=";
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
    version = "v0.18.0";
    src = pkgs.fetchFromGitHub {
      owner = "clawscli";
      repo = finalAttrs.pname;
      tag = finalAttrs.version;
      hash = "sha256-CnnU4OCO1Mslf7+fSu3scKHQ2LJWG+XxMtTyk9CIVYk=";
    };
    # This fails tests due to using `/homeless-shelter/.` Google buildroot nonsense
    doCheck = false;
    vendorHash = "sha256-Ef/2Xs15E5noUYJk2J9k48g0kfTPB6v+D9uUHdOyya0=";
    meta = {
      description = "A TUI for AWS resource management";
      homepage = "https://github.com/clawscli/claws";
      license = lib.licenses.mit;
      mainProgram = finalAttrs.pname;
    };
  });

  cfg = config.extras.extraPackages;
in {
  config = {
    home = {
      packages = with pkgs;
        [
          bat
          bat-extras.batman
          delta
          fd
          findutils
          gawk
          gh
          jq
          nh
          nix-output-monitor
          p7zip
          pinentry-tty
          prek
          ripgrep
          shfmt
          tldr
          ugrep
          viddy
          yq
          # Scripts
          blame-line-pretty
          git-hunk
          gpg-push-pull-keys
        ]
        ++ (lib.optionals (!cfg.minimal.enable) [
          alejandra
          cmake
          jdk21_headless
          lazydocker
          nerd-fonts.monaspace
          nodejs_26
          noto-fonts
          rustup
        ])
        ++ (lib.optionals cfg.macOnly.enable [
          pam-reattach
          sops
          yubikey-manager
        ])
        ++ (lib.optionals cfg.appleSiliconOnly.enable [
          macmon
        ])
        ++ (lib.optionals cfg.workOnly.enable [
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
