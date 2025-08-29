{pkgs, ...}: let
  # Package shell scripts
  ssh-proxy = pkgs.writeShellScriptBin "ssh-proxy" (builtins.readFile ../../../../../shared/scripts/sshproxy.sh);
  tilt-connect = pkgs.writeShellScriptBin "tilt-connect" (builtins.readFile ../../../../../shared/scripts/tilt-connect.sh);
  blame-line-pretty = pkgs.writeShellScriptBin "blame-line-pretty" (builtins.readFile ../../../../../shared/scripts/blame-line-pretty.sh);
  git-hunk = pkgs.writeShellScriptBin "git-hunk" (builtins.readFile ../../../../../shared/scripts/git-hunk.sh);
in {
  home = {
    packages = [
      pkgs.restic
      pkgs.bat
      pkgs.go
      pkgs.bfs
      pkgs.cargo
      pkgs.delta
      pkgs.eza
      pkgs.fd
      pkgs.gh
      pkgs.ugrep
      pkgs.pre-commit
      pkgs.tree-sitter
      pkgs.viddy
      pkgs.nodejs_22
      pkgs.jdk24_headless
      pkgs.lazydocker
      pkgs.p7zip
      pkgs.tldr
      pkgs.yt-dlp
      pkgs.wget
      pkgs.yq
      pkgs.jq
      pkgs.ripgrep
      pkgs.ffmpeg
      pkgs.fzf
      # Shell scripts
      ssh-proxy
      tilt-connect
      git-hunk
      blame-line-pretty
    ];
  };
}
