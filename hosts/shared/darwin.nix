{
  pkgs,
  lib,
  inputs,
  mainUser,
  system,
  config,
  ...
}: let
  lixReleaseBranch = "latest";
in {
  # Supplied by the mkDarwinHost factory
  nixpkgs.hostPlatform = lib.mkDefault system;
  system.stateVersion = 5;
  system.primaryUser = "${mainUser}";

  users.users.${mainUser} = {
    home = "/Users/${mainUser}";
    shell = pkgs.zsh;
    packages = [
      pkgs.gnused
      pkgs.gnutar
    ];
  };

  # System environment and packages
  environment = {
    systemPackages = with pkgs; [
      home-manager
      inputs.nil.packages.${system}.nil
      inputs.strace-macos.packages.${system}.default
      libfido2
      nixd
      python314
      python314Packages.pip
      reattach-to-user-namespace
      shellcheck
      uutils-coreutils-noprefix
      uv
    ];
    pathsToLink = ["/share/zsh"];
    variables = {
      XDG_DATA_DIRS = [
        "$GHOSTTY_SHELL_INTEGRATION_XDG_DIR"
      ];
    };
  };

  # Auto upgrade nix package and the daemon service.
  nix = {
    enable = true;
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 10d";
      interval = {
        Weekday = 1;
        Hour = 7;
        Minute = 30;
      };
    };
    package = pkgs.lixPackageSets.${lixReleaseBranch}.lix;
    settings =
      {
        "extra-experimental-features" = [
          "nix-command"
          "flakes"
        ];
      }
      // lib.optionalAttrs (config.nix.package == pkgs.lixPackageSets.${lixReleaseBranch}.lix) {
        # Silence deprecated syntax warnings for Lix
        "extra-deprecated-features" = [
          # This is needed due to old syntax being used in Nixpkgs
          "or-as-identifier"
        ];
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

  # Sudo auth with TouchID
  # The override for pam_reattach is to support Tmux sessions with TouchID over SSH
  security.pam.services.sudo_local = {
    enable = true;
    text = lib.mkForce ''
      auth       optional       ${pkgs.pam-reattach}/lib/pam/pam_reattach.so ignore_ssh
      auth       sufficient     pam_tid.so
    '';
  };

  # Configure the dock and Finder
  system.defaults = {
    screencapture.location = "/Users/${mainUser}/Desktop/screenshots";
    menuExtraClock.Show24Hour = true;
    NSGlobalDomain.AppleShowScrollBars = "WhenScrolling";
    finder = {
      FXRemoveOldTrashItems = true;
      ShowStatusBar = true;
    };
    dock = {
      magnification = true;
      minimize-to-application = true;
      show-process-indicators = true;
      show-recents = false;
      # Show only open applications in the dock
      static-only = true;
    };
  };

  networking = {
    applicationFirewall.enable = true;
  };

  # Use Homebrew for things not working with nixpkgs on macOS
  homebrew = {
    enable = true;
    enableZshIntegration = true;
    global = {
      autoUpdate = true;
    };
    onActivation = {
      upgrade = true;
      cleanup = "zap";
      extraFlags = ["--force"];
      extraEnv = {
        # https://docs.brew.sh/Manpage#environment
        # https://docs.brew.sh/Tap-Trust
        HOMEBREW_NO_ANALYTICS = "1";
        HOMEBREW_NO_ENV_HINTS = "1";
        HOMEBREW_NO_REQUIRE_TAP_TRUST = "1";
      };
    };
    taps = [
      "tw93/tap"
      "youvegotmoxie/homebrew-tap"
    ];
    brews = [
      "tw93/tap/mole"
    ];
    casks = [
      "alcove"
      "betterdisplay"
      "font-monaspice-nerd-font"
      "font-noto-sans-symbols-2"
      "ghostty"
      "orbstack"
      "raycast"
      "thaw"
      "timemachinestatus"
      "youvegotmoxie/homebrew-tap/omlx"
      "zed"
    ];
    masApps = {
      "Strongbox Password Manager" = 897283731;
      "Xcode" = 497799835;
      "Amphetamine" = 937984704;
      "Refined GitHub" = 1519867270;
      "Vimari" = 1480933944;
      "StopTheMadness Pro" = 6471380298;
      "Wipr 2" = 1662217862;
      "Dark Reader for Safari" = 1438243180;
      "Raycast Companion" = 6738274497;
      "SponsorBlock for Safari" = 1573461917;
    };
  };
}
