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
  zed-config-sync = pkgs.writeShellScriptBin "zed-config-sync" (
    builtins.readFile ../scripts/zed-config-sync.sh
  );
  zed-config-restore = pkgs.writeShellScriptBin "zed-config-restore" (
    builtins.readFile ../scripts/zed-config-restore.sh
  );

  helmVersion = "4.1.1";
  helmSHA = "sha256-v678Bfxf/0ugEd/OUrGnm1eFxj60t0mA8hqMS3qczrA=";
  helm4 = pkgs.stdenv.mkDerivation rec {
    pname = "helm";
    version = helmVersion;
    sourceRoot = ".";
    src = pkgs.fetchzip {
      name = pname;
      url = "https://get.${pname}.sh/${pname}-v${helmVersion}-darwin-arm64.tar.gz";
      sha256 = helmSHA;
      stripRoot = false;
    };
    installPhase = ''
      runHook preInstall
      install -m 0755 -D helm/darwin-arm64/helm $out/bin/helm
      runHook postInstall
    '';
  };
  cfg = config.zshConfig;
in {
  config = {
    home = {
      packages = with pkgs;
        [
          alejandra
          bat
          bat-extras.batman
          bfs
          blame-line-pretty
          cargo
          delta
          fd
          gawk
          gh
          git-hunk
          gpg-push-pull-keys
          jdk21_headless
          jq
          krew
          kubecolor
          kubectl
          kubectx
          lazydocker
          nerd-fonts.monaspace
          nh
          nix-index
          nix-output-monitor
          nodejs_22
          noto-fonts
          p7zip
          pam-reattach
          passepartui
          pinentry-tty
          prek
          ripgrep
          rustc
          rustfmt
          tldr
          tree-sitter
          ugrep
          viddy
          yq
          yubikey-manager
          zed-config-sync
          zed-config-restore
        ]
        ++ (lib.optionals cfg.workAliases.enable [
          (pkgs.google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
          helm4
          pkgs.act
          pkgs.ansible
          pkgs.ansible-lint
          pkgs.awscli2
          pkgs.eks-node-viewer
          pkgs.git-lfs
          pkgs.go
          pkgs.kubent
          pkgs.pulumi
          pkgs.ssm-session-manager-plugin
          pkgs.stern
          pkgs.wget
          ssh-proxy
          tilt-connect
        ]);
    };
  };
}
