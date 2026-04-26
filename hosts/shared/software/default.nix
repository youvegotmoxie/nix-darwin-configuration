{...}: {
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
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    # Disable the embedded ruby and python3 interpreters
    withRuby = false;
    withPython3 = false;
  };

  programs.direnv = {
    enable = true;
    # Account for large flake builds
    config.warn_timeout = "10m";
    nix-direnv.enable = true;
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
