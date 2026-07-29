{
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
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

  # Override global btop configuration
  programs.btop = {
    package = lib.mkForce pkgs.btop-rocm;
    settings.net_iface = lib.mkForce "enp35s0";
  };

  extras.extraPackages = {
    serverOnly.enable = true;
  };

  home = {
    stateVersion = "26.05";
    sessionVariables = rec {
      # Needed for Zed to prevent routing loops
      "NO_PROXY" = "localhost,127.0.0.1,192.168.148.125";
      "no_proxy" = NO_PROXY;
    };

    packages = with pkgs; [
      amdgpu_top
      lazygit
    ];

    file = {
      ".rustup/settings.toml".source = lib.mkForce ./dots/rustup_settings.toml;
    };
  };
}
