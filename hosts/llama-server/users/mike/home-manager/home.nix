{
  pkgs,
  config,
  ...
}: {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software/tmux.nix
    ../../../../shared/software/zsh.nix
    ../../../../shared/software/starship.nix
    ../../../../shared/software/zoxide.nix
  ];
  # Configure SSH agent socket
  zshConfig = {
    ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
  };
  extras.extraPackages = {
    serverOnly.enable = true;
  };
  home = {
    stateVersion = "26.05";
    sessionVariables = rec {
      # Needed for Zed to prevent routing loops
      "NO_PROXY" = "localhost,127.0.0.1";
      "no_proxy" = NO_PROXY;
    };

    packages = with pkgs; [
      alejandra
      bat
      bat-extras.batman
      delta
      fd
      findutils
      gawk
      gh
      jq
      lazygit
      nh
      nix-output-monitor
      p7zip
      prek
      ripgrep
      rustup
      shfmt
      tldr
      tmux
      ugrep
      viddy
      yq
    ];

    file = {
      ".rustup/settings.toml".source = ./dots/rustup_settings.toml;
      ".config/models.ini".source = ./dots/models.ini;
      ".zsh.d/func.sh".source = ../../../../shared/dots/func.sh;
    };
  };
}
