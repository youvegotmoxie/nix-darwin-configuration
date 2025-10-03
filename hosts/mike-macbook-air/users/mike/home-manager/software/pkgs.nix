{pkgs, ...}: 
{
  home = {
    packages = with pkgs; [
      bat
      bat-extras.batman
      bfs
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
      fzf
    ];
  };
}
