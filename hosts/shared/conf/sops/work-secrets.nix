{
  lib,
  config,
  ...
}: let
  cfg = config.sopsSecrets.zsh.work;
in {
  options.sopsSecrets.zsh.work = {
    enable = lib.mkEnableOption "sopsSecrets.zsh.work";
    path = lib.mkOption {
      type = lib.types.str;
      default = ".creds.d";
      description = "Destination secret path";
    };
  };
  config = lib.mkIf cfg.enable {
    sops.secrets = {
      SRC_ACCESS_TOKEN = {
        path = "${config.home.homeDirectory}/${cfg.path}/SRC_ACCESS_TOKEN";
        mode = "0600";
      };
      SRC_ENDPOINT = {
        path = "${config.home.homeDirectory}/${cfg.path}/SRC_ENDPOINT";
        mode = "0600";
      };
      BB_USER = {
        path = "${config.home.homeDirectory}/${cfg.path}/BB_USER";
        mode = "0600";
      };
      BB_PASSWD = {
        path = "${config.home.homeDirectory}/${cfg.path}/BB_PASSWD";
        mode = "0600";
      };
      BW_PASSWD = {
        path = "${config.home.homeDirectory}/${cfg.path}/BW_PASSWD";
        mode = "0600";
      };
    };
  };
}
