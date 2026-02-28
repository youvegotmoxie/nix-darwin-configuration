{
  pkgs,
  config,
  lib,
  ...
}: let
  # Package shell scripts
  ssh-proxy = pkgs.writeShellScriptBin "ssh-proxy" (builtins.readFile ../scripts/sshproxy.sh);
  tilt-connect = pkgs.writeShellScriptBin "tilt-connect" (builtins.readFile ../scripts/tilt-connect.sh);
  blame-line-pretty = pkgs.writeShellScriptBin "blame-line-pretty" (builtins.readFile ../scripts/blame-line-pretty.sh);
  git-hunk = pkgs.writeShellScriptBin "git-hunk" (builtins.readFile ../scripts/git-hunk.sh);
  gpg-push-pull-keys = pkgs.writeShellScriptBin "gpg-push-pull-keys" (builtins.readFile ../scripts/gpg-push-pull-keys.sh);
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
          bat
          bat-extras.batman
          bfs
          cargo
          delta
          fd
          gh
          git-lfs
          nh
          nix-output-monitor
          ugrep
          prek
          tree-sitter
          kubectl
          kubectx
          kubecolor
          krew
          yq
          viddy
          nodejs_22
          jdk21_headless
          lazydocker
          p7zip
          tldr
          jq
          ripgrep
          yubikey-manager
          pinentry-tty
          passepartui
          # Tmux stuff
          pam-reattach
          gawk
          nerd-fonts.monaspace
          noto-fonts
          # scripts
          blame-line-pretty
          git-hunk
          gpg-push-pull-keys
        ]
        ++ (lib.optionals cfg.workAliases.enable [
          # packages only needed for work
          pkgs.act
          pkgs.ansible
          pkgs.ansible-lint
          pkgs.awscli2
          pkgs.eks-node-viewer
          pkgs.go
          (pkgs.google-cloud-sdk.withExtraComponents [google-cloud-sdk.components.gke-gcloud-auth-plugin])
          pkgs.kubent
          pkgs.stern
          pkgs.ssm-session-manager-plugin
          pkgs.pulumi
          pkgs.wget
          helm4
          # scripts only needed for work
          ssh-proxy
          tilt-connect
        ]);
    };
  };
}
