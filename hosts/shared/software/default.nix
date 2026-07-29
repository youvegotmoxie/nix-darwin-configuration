{...}: {
  imports = [
    ./options.nix
    ./atuin.nix
    ./btop.nix
    ./fzf.nix
    ./git.nix
    ./gnupg.nix
    ./mcp.nix
    ./misc-dots.nix
    ./misc.nix
    ./pass.nix
    ./pkgs.nix
    # sops.nix excluded - macOS-only, not used on NixOS
    # Add to specific hosts that need it
    ./ssh.nix
    ./starship.nix
    ./syncthing.nix
    ./tmux.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
