{ config, lib, pkgs, ... }: {
  options.extras = {
    gpuMemory = lib.mkOption {
      type = lib.types.str;
      description = "Memory allocatable to the GPU (macOS)";
      default = "12288";
    };
    syncthingTarget = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Syncthing device(s) to sync to";
      default = ["mike-mac-mini"];
    };
    extraPackages = {
      workOnly = {
        enable = lib.mkEnableOption "extras.extraPackages.workOnly" // { default = false; };
      };
      serverOnly = {
        enable = lib.mkEnableOption "extras.extraPackages.serverOnly" // { default = false; };
      };
      appleSiliconOnly = {
        enable = lib.mkEnableOption "extras.extraPackages.appleSiliconOnly" // { default = pkgs.stdenv.hostPlatform.isDarwin && pkgs.stdenv.hostPlatform.isAarch64; };
      };
      macOnly = {
        enable = lib.mkEnableOption "extras.extraPackages.macOnly" // { default = pkgs.stdenv.hostPlatform.isDarwin; };
      };
      minimal = {
        enable = lib.mkEnableOption "extras.extraPackages.minimal" // { default = false; };
      };
    };
  };

  options.gpgConfig = {
    enable = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Whether to enable GPG and gpg-agent";
    };
    pubKey = lib.mkOption {
      type = lib.types.str;
      description = "Public GPG Key";
      default = "26693209BA633C80";
    };
    sshKeys = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      description = "Authentication Keys as Keygrip";
      default = [
        "FA2DB0DD531C864082BD10F5C936E7BFD93BA80A"
      ];
    };
  };

  options.gitConfig.person = {
    name = lib.mkOption {
      type = lib.types.str;
      description = "Git username";
      default = "Michael Beasley";
    };
    email = lib.mkOption {
      type = lib.types.str;
      description = "Git email";
      default = "youvegotmoxie@gmail.com";
    };
    gpgKey = lib.mkOption {
      type = lib.types.str;
      description = "GPG signing key";
      default = "A6B4C8E1BAEA348F";
    };
  };

  options.rocmConfig = {
    gpuTargets = lib.mkOption {
      type = lib.types.str;
      default = "gfx1151";
      description = "ROCm GPU target passed to CMake as -DGPU_TARGETS (e.g. gfx1151, gfx1201)";
    };
  };

  options.zshConfig = {
    ssh = {
      enable = lib.mkOption {
        type = lib.types.bool;
        default = config.services.gpg-agent.enable;
        description = "Whether to set SSH_AUTH_SOCK to the configured socket path";
      };
      socketPath = lib.mkOption {
        type = lib.types.str;
        default = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
      };
    };
    workAliases = {
      enable = lib.mkEnableOption "zshConfig.workAliases" // { default = false; };
    };
  };
}
