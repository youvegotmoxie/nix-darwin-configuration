{
  pkgs,
  inputs,
  ...
}: let
  mainUser = "mike";
in {
  nixpkgs.hostPlatform = "x86_64-darwin";
  system.stateVersion = 5;
  system.primaryUser = "${mainUser}";

  # System packages
  environment.systemPackages = with pkgs; [
    inputs.nil.packages.${system}.nil
    uutils-coreutils-noprefix
    reattach-to-user-namespace
    nh
    home-manager
    python313
    python313Packages.pip
    sops
    vim
    gnused
    gnutar
  ];

  environment.pathsToLink = ["/share/zsh"];

  # Auto upgrade nix package and the daemon service.
  nix = {
    enable = true;
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 15d";
      interval = {
        Weekday = 0;
        Hour = 2;
        Minute = 0;
      };
    };
    package = pkgs.nix;
    settings = {
      "extra-experimental-features" = ["nix-command" "flakes"];
    };
    extraOptions = ''
      extra-platforms = x86_64-darwin aarch64-darwin
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };

  # Allow non-free packages
  nixpkgs.config.allowUnfree = true;

  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # Sudo auth with Touch ID
  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = false;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [];
    casks = [
      "ghostty"
      "tailscale-app"
      "raycast"
      "soduto"
    ];
    masApps = {
      "Bitwarden" = 1352778147;
      "Todoist" = 585829637;
      "Texty for Google Messages" = 1538996043;
    };
  };
  environment.variables.XDG_DATA_DIRS = [
    "$GHOSTTY_SHELL_INTEGRATION_XDG_DIR"
  ];
}
