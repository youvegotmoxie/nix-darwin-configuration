{
  mainUser,
  pkgs,
  hostDir,
  inputs,
  system,
  lib,
  ...
}: {
  nixpkgs.hostPlatform = lib.mkDefault system;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../../../../llama-cpp.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_latest;
  };

  networking = {
    hostName = "${hostDir}";
    networkmanager.enable = true;
    proxy.noProxy = "127.0.0.1,localhost,internal.domain";
    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    firewall.enable = false;
  };

  time.timeZone = "America/Anchorage";

  security.sudo.wheelNeedsPassword = false;
  users.users.${mainUser} = {
    isNormalUser = true;
    extraGroups = ["wheel"]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    openssh.authorizedKeys.keys = [
      "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBNKNWVZe8zRvZ8VNfsDr+KQfDYvi/+ssXo6hIHLFsxwVYya+BcyFZ6TBXARrLONhkKbq4nkEA2CRatJ5bL8WG2H8dnl/WbsV+LQ5NRZz20f0MIKhOkZa6uoZE6gGWEVIxA== cardno:35_285_426"
      "ecdsa-sha2-nistp384 AAAAE2VjZHNhLXNoYTItbmlzdHAzODQAAAAIbmlzdHAzODQAAABhBCC3+lHWSgBAOLx2HgQLDW81dCkgAj4Jvp5bRMOl3ZlHZXbmXZwA8JYPMWiZEzOZlNXkS8UlaiC6vaq8JtPeFNziuLgQ5Ntl2AX4fk+/VpnsouQ7tvPt5wwFdiTcT811Ng== cardno:31_399_365"
    ];
    packages = with pkgs; [neovim];
  };

  environment = {
    systemPackages = with pkgs; [
      btop-rocm
      cmake
      git
      home-manager
      inputs.nil.packages.${system}.nil
      nh
      nixd
      pciutils
      python314
      python314Packages.pip
      shellcheck
      uutils-coreutils-noprefix
      uv
      vim
      wget
    ];
    pathsToLink = ["/share/zsh"];
  };

  programs = {
    zsh.enable = true;
    bash.enable = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  services = {
    openssh.enable = true;
  };

  system = {
    copySystemConfiguration = false;
    stateVersion = "26.05";
  };

  nix = {
    enable = true;
    optimise.automatic = true;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings = {
      "extra-experimental-features" = [
        "nix-command"
        "flakes"
      ];
    };
    extraOptions = ''
      min-free = ${toString (100 * 1024 * 1024)}
      max-free = ${toString (1024 * 1024 * 1024)}
    '';
  };
}
