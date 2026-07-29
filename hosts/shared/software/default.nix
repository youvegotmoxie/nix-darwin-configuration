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
    # TODO: Get this working on macOS and NixOS
    # Currently only working on macOS
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
