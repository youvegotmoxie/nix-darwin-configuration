{ config, lib, pkgs, ... }: {
  options.extras = {
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
    };
  };

  options.zshConfig = {
    ssh = {
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
