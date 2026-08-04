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
    ./nh.nix
    ./pass.nix
    ./pkgs.nix
    # sops.nix is Darwin-specific and is imported via mkDarwinHost in flake.nix
    # Re-enable here once the Linux key path / launchd is figured out
    # ./sops.nix
    ./ssh.nix
    ./starship.nix
    ./syncthing.nix
    ./tmux.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
  ];
}
