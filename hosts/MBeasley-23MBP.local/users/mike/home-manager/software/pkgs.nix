{pkgs, ...}: let
  # Package shell scripts
  ssh-proxy = pkgs.writeShellScriptBin "ssh-proxy" (builtins.readFile ../../../../../shared/scripts/sshproxy.sh);
  tilt-connect = pkgs.writeShellScriptBin "tilt-connect" (builtins.readFile ../../../../../shared/scripts/tilt-connect.sh);
  blame-line-pretty = pkgs.writeShellScriptBin "blame-line-pretty" (builtins.readFile ../../../../../shared/scripts/blame-line-pretty.sh);
  git-hunk = pkgs.writeShellScriptBin "git-hunk" (builtins.readFile ../../../../../shared/scripts/git-hunk.sh);
  helmVersion = "4.0.4";
  helmSHA = "sha256-LCRBUeRnCs0WK3pCmBCBmCSFpfD7mglHciOjaWqx59c=";
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
in {
  home = {
    packages = with pkgs; [
      act
      awscli2
      ansible
      argocd
      bat
      bat-extras.batman
      bfs
      cargo
      delta
      eks-node-viewer
      eza
      go
      fd
      gh
      git-lfs
      nh
      nix-output-monitor
      ugrep
      pre-commit
      tree-sitter
      kubectl
      kubectx
      kubecolor
      kubent
      krew
      viddy
      nodejs_22
      jdk21_headless
      lazydocker
      p7zip
      ssm-session-manager-plugin
      stern
      tldr
      wget
      yq
      jq
      ripgrep
      fzf
      pulumi
      steampipe
      yubikey-manager
      passepartui
      # Tmux stuff
      pam-reattach
      jq
      gh
      gawk
      nerd-fonts.monaspace
      noto-fonts
      # scripts
      ssh-proxy
      tilt-connect
      git-hunk
      blame-line-pretty
      helm4
    ];
  };
}
