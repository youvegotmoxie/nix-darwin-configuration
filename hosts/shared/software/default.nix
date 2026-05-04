{
  pkgs,
  flake-inputs,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) system;
in {
  imports = [
    ./atuin.nix
    ./btop.nix
    ./fzf.nix
    ./ghostty.nix
    ./git.nix
    ./gnupg.nix
    ./pass.nix
    ./pkgs.nix
    ./starship.nix
    ./tmux.nix
    ./yazi.nix
    ./zoxide.nix
    ./zsh.nix
    ./llama-cpp.nix
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    # Disable the embedded ruby and python3 interpreters
    withRuby = false;
    withPython3 = false;
    # Don't overwrite ~/.config/nvim/init.lua
    sideloadInitLua = true;
  };

  # TODO: Remove this overlay configuration once direnv tests are passing in nixpkgs-unstable
  programs.direnv = {
    enable = true;
    config = {
      warn_timeout = "10m";
    };
    package = flake-inputs.nixos-unstable-small.legacyPackages.${system}.direnv;
    nix-direnv = {
      enable = true;
      package = flake-inputs.nixos-unstable-small.legacyPackages.${system}.nix-direnv;
    };
    enableZshIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableZshIntegration = true;
    git = true;
    extraOptions = [
      "-lahg"
      "--git-repos-no-status"
    ];
  };
}
