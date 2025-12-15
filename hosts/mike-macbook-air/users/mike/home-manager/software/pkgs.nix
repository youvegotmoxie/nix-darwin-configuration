{pkgs, ...}: let
  blame-line-pretty = pkgs.writeShellScriptBin "blame-line-pretty" (builtins.readFile ../../../../../shared/scripts/blame-line-pretty.sh);
  git-hunk = pkgs.writeShellScriptBin "git-hunk" (builtins.readFile ../../../../../shared/scripts/git-hunk.sh);
in {
  home = {
    packages = with pkgs; [
      bat
      bat-extras.batman
      bfs
      cargo
      delta
      eza
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
    ];
  };
}
