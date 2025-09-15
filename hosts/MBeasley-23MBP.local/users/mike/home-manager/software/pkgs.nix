{pkgs, ...}: let
  # Package shell scripts
  ssh-proxy = pkgs.writeShellScriptBin "ssh-proxy" (builtins.readFile ../../../../../shared/scripts/sshproxy.sh);
  tilt-connect = pkgs.writeShellScriptBin "tilt-connect" (builtins.readFile ../../../../../shared/scripts/tilt-connect.sh);
  blame-line-pretty = pkgs.writeShellScriptBin "blame-line-pretty" (builtins.readFile ../../../../../shared/scripts/blame-line-pretty.sh);
  git-hunk = pkgs.writeShellScriptBin "git-hunk" (builtins.readFile ../../../../../shared/scripts/git-hunk.sh);
in {
  home = {
    packages = with pkgs; [
      awscli2
      # ansible
      restic
      bat
      go
      bfs
      cargo
      delta
      eza
      fd
      gh
      ugrep
      pre-commit
      tree-sitter
      kubectl
      kubectx
      kubecolor
      kubent
      kubernetes-helm
      krew
      viddy
      nodejs_22
      jdk24_headless
      lazydocker
      obsidian
      p7zip
      ssm-session-manager-plugin
      stern
      tldr
      yt-dlp
      wget
      yq
      jq
      ripgrep
      ffmpeg
      fzf
      pulumi
      steampipe
      ssh-proxy
      tilt-connect
      git-hunk
      blame-line-pretty
    ];
  };
}
