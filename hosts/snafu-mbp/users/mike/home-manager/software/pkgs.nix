{pkgs, ...}: let
  # Package shell scripts
  ssh-proxy = pkgs.writeShellScriptBin "ssh-proxy" (builtins.readFile ../../../../../shared/scripts/sshproxy.sh);
  tilt-connect = pkgs.writeShellScriptBin "tilt-connect" (builtins.readFile ../../../../../shared/scripts/tilt-connect.sh);
  blame-line-pretty = pkgs.writeShellScriptBin "blame-line-pretty" (builtins.readFile ../../../../../shared/scripts/blame-line-pretty.sh);
  git-hunk = pkgs.writeShellScriptBin "git-hunk" (builtins.readFile ../../../../../shared/scripts/git-hunk.sh);
in {
  home = {
    packages = with pkgs; [
      restic
      bat
      bat-extras.batman
      go
      bfs
      cargo
      delta
      eza
      fd
      gh
      nh
      nix-output-monitor
      ugrep
      pre-commit
      tree-sitter
      viddy
      nodejs_22
      jdk24_headless
      lazydocker
      p7zip
      tldr
      yt-dlp
      wget
      yq
      jq
      ripgrep
      ffmpeg
      fzf
      # Shell scripts
      ssh-proxy
      tilt-connect
      git-hunk
      blame-line-pretty
    ];
  };
}
