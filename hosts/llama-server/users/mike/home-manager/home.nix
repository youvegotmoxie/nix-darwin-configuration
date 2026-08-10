{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # shared modules in root of hosts dir
    ../../../../shared/software
  ];
  gpgConfig.enable = false;

  # Override global btop configuration
  programs.btop = {
    package = lib.mkForce pkgs.btop-rocm;
    settings.net_iface = lib.mkForce "enp35s0";
  };

  extras.extraPackages = {
    serverOnly.enable = true;
    minimal.enable = true;
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
      ".config/models.ini".source = ./dots/models.ini;
    };
  };
}
