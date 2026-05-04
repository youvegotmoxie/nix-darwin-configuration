{
  config,
  lib,
  ...
}: let
  cfg = config.llama-cpp;
in {
  options.llama-cpp = {
    enable = lib.mkEnableOption "llama-cpp service";
    default = false;
  };

  config = {
    services.llama-cpp = {
      enable = cfg.enable;
      host = "127.0.0.1";
      port = 8990;
    };
  };
}
