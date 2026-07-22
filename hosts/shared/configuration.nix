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
  nixpkgs.config.allowUnfree = true;
  imports = [
    ../../hosts/shared/software/ai.nix
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
    extraGroups = ["wheel" "docker"];
    shell = pkgs.zsh;
    # SSH authorizedKeys.keys are defined per-host
    packages = with pkgs; [neovim];
  };

  environment = {
    systemPackages = with pkgs; [
      cmake
      git
      home-manager
      inputs.nil.packages.${system}.nil
      nh
      nixd
      pciutils
      python314
      python314Packages.pip
      rocmPackages.rocm-smi
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

  services = {
    openssh.enable = true;
    vnstat.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
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
