{
  lib,
  config,
  ...
}: let
  cfg = config.sopsSecrets.zsh.home;
in {
  options.sopsSecrets.zsh.home = {
    enable = lib.mkEnableOption "sopsSecrets.zsh.home";
    path = lib.mkOption {
      type = lib.types.str;
      default = ".creds.d";
      description = "Destination secret path";
    };
  };
  config = lib.mkIf cfg.enable {
    sops.secrets = {
      gh_token = {
        path = "${config.home.homeDirectory}/${cfg.path}/gh_token";
        mode = "0600";
      };
      restic = {
        path = "${config.home.homeDirectory}/${cfg.path}/restic";
        mode = "0600";
      };
      BW_PASSWD = {
        path = "${config.home.homeDirectory}/${cfg.path}/BW_PASSWD";
        mode = "0600";
      };
    };
  };
}
