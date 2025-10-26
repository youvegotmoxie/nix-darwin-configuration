{pkgs, ...}: let
  mainUser = "mike";
in {
  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 5;
  system.primaryUser = "${mainUser}";

  users.users.${mainUser} = {
    home = "/Users/mike";
    shell = pkgs.zsh;
    packages = [pkgs.vim pkgs.gnused pkgs.gnutar];
  };

  # System packages
  environment.systemPackages = with pkgs; [
    uutils-coreutils-noprefix
    reattach-to-user-namespace
    home-manager
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

  # Autohide the dock
  system.defaults = {
    finder = {
      FXRemoveOldTrashItems = true;
      ShowStatusBar = true;
    };
    dock = {
      magnification = true;
      minimize-to-application = true;
      show-process-indicators = true;
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = false;
      cleanup = "zap";
    };
    brews = [];
    casks = [
      "ghostty"
      "raycast"
      "alcove"
    ];
    masApps = {
      "Bitwarden" = 1352778147;
    };
  };

  environment.variables.XDG_DATA_DIRS = [
    "$GHOSTTY_SHELL_INTEGRATION_XDG_DIR"
  ];
}
