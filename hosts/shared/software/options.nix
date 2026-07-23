{ config, lib, ... }: {
  options.extras.extraPackages.workOnly.enable = lib.mkEnableOption "extras.extraPackages.workOnly" // { default = false; };

  options.extras.extraPackages.serverOnly.enable = lib.mkEnableOption "extras.extraPackages.serverOnly" // { default = false; };

  options.extras.extraPackages.appleSiliconOnly.enable = lib.mkEnableOption "extras.extraPackages.appleSiliconOnly" // { default = true; };

  options.extras.extraPackages.personalOnly.enable = lib.mkEnableOption "extras.extraPackages.personalOnly" // { default = false; };

  options.zshConfig.ssh.socketPath = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/.bitwarden-ssh-agent.sock";
  };

  options.zshConfig.workAliases.enable = lib.mkEnableOption "zshConfig.workAliases" // { default = false; };
}
