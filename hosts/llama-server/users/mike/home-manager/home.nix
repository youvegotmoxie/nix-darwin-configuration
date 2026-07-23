{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software/atuin.nix
    ../../../../shared/software/btop.nix
    ../../../../shared/software/fzf.nix
    ../../../../shared/software/git.nix
    ../../../../shared/software/mcp.nix
    ../../../../shared/software/misc.nix
    ../../../../shared/software/options.nix
    ../../../../shared/software/starship.nix
    ../../../../shared/software/tmux.nix
    ../../../../shared/software/zoxide.nix
    ../../../../shared/software/zsh.nix
  ];
  # Configure SSH agent socket
  zshConfig = {
    ssh.socketPath = "${config.home.homeDirectory}/.gnupg/S.gpg-agent.ssh";
  };

  # Configure git persona
  gitConfig = {
    person = {
      name = "Michael Beasley";
      email = "youvegotmoxie@gmail.com";
      gpgKey = "A6B4C8E1BAEA348F";
    };
  };

  # Override global btop configuration since that's based on macOS
  programs.btop = {
    package = lib.mkForce pkgs.btop-rocm;
    settings = lib.mkMerge [{
      net_iface = lib.mkForce "enp35s0";
    }];
  };

  extras.extraPackages.serverOnly = {
    enable = true;
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
      amdgpu_top
      bat
      bat-extras.batman
      delta
      fd
      findutils
      gawk
      gh
      jq
      lazygit
      nodejs_26
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

  programs.direnv = {
    enable = true;
    config = {
      warn_timeout = "10m";
    };
    nix-direnv = {
      enable = true;
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
