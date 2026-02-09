{pkgs, ...}: let
  blame-line-pretty = pkgs.writeShellScriptBin "blame-line-pretty" (builtins.readFile ../../../../../shared/scripts/blame-line-pretty.sh);
  git-hunk = pkgs.writeShellScriptBin "git-hunk" (builtins.readFile ../../../../../shared/scripts/git-hunk.sh);
  gpg-push-pull-keys = pkgs.writeShellScriptBin "gpg-push-pull-keys" (builtins.readFile ../../../../../shared/scripts/gpg-push-pull-keys.sh);
  helmVersion = "4.1.0";
  helmSHA = "sha256-fIhbwc6KcJP5wGjQR1Nt987g1suU3vv2nGkIsJVbqVk=";
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
      bat
      bat-extras.batman
      bfs
      cargo
      delta
      fd
      nh
      nix-output-monitor
      ugrep
      tree-sitter
      viddy
      p7zip
      tldr
      ripgrep
      nodejs_22
      jdk21_headless
      fzf
      yubikey-manager
      prek
      lazydocker
      kubectl
      krew
      kubectx
      kubecolor
      kubent
      passepartui
      pinentry-tty
      # Tmux stuff
      pam-reattach
      jq
      gh
      gawk
      nerd-fonts.monaspace
      noto-fonts
      # scripts
      git-hunk
      blame-line-pretty
      gpg-push-pull-keys
      helm4
    ];
  };
}
