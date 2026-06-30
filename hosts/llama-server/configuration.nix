{
  mainUser,
  pkgs,
  hostDir,
  inputs,
  system,
  lib,
  ...
}: let
  llama-cpp =
    (pkgs.llama-cpp.override {
      rocmSupport = true;
      blasSupport = true;
    }).overrideAttrs
    (oldAttrs: rec {
      version = "9843";
      src = pkgs.fetchFromGitHub {
        owner = "ggml-org";
        repo = "llama.cpp";
        tag = "b${version}";
        hash = "sha256-8iwnBUxekRDakHqJU4E73BfPYOC0edhc3imYqXSo7uU=";
        leaveDotGit = true;
        postFetch = ''
          git -C "$out" rev-parse --short HEAD > $out/COMMIT
          find "$out" -name .git -print0 | xargs -0 rm -rf
        '';
      };
      # Enable native CPU optimizations (AVX, AVX2, etc.)
      npmDepsHash = "sha256-X1DZgmhS/zHTqDT5zq0kywwntthcJ9vRXeqyO3zz6UU=";
      cmakeFlags =
        (oldAttrs.cmakeFlags or [])
        ++ [
          "-DGGML_NATIVE=ON"
          "-DGGML_HIP=ON"
          "-DGPU_TARGETS=gfx1201"
          "-DCMAKE_BUILD_TYPE=Release"
        ];
      preConfigure = ''
        export NIX_ENFORCE_NO_NATIVE=0
        ${oldAttrs.preConfigure or ""}
      '';
    });
in {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  nixpkgs.hostPlatform = lib.mkDefault system;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "${hostDir}";
  networking.networkmanager.enable = true;
  networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    packages = with pkgs; [
      neovim
    ];
  };

  environment = {
    systemPackages = with pkgs; [
      btop-rocm
      cmake
      git
      home-manager
      inputs.nil.packages.${system}.nil
      llama-cpp
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

  programs.zsh.enable = true;
  programs.bash.enable = true;

  services.llama-cpp = {
    enable = true;
    package = llama-cpp;
    settings = {
      models-preset = "/var/lib/llama-cpp/models.ini";
      host = "0.0.0.0";
      port = 8080;
      cache-ram = 32400;
      cache-type-k = "q8_0";
      cache-type-v = "q8_0";
      threads = 16;
      kv-unified = true;
      jinja = true;
      models-max = 2;
    };
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  system.copySystemConfiguration = false;
  system.stateVersion = "26.05";
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
