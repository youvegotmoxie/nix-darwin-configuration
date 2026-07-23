{ config, lib, ... }: {
  options.extras = {
    extraPackages = {
      workOnly = {
        enable = lib.mkEnableOption "extras.extraPackages.workOnly" // { default = false; };
      };
      serverOnly = {
        enable = lib.mkEnableOption "extras.extraPackages.serverOnly" // { default = false; };
      };
      appleSiliconOnly = {
        enable = lib.mkEnableOption "extras.extraPackages.appleSiliconOnly" // { default = true; };
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
